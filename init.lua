-- 载入配置文件
require "function"
-- 维护状态验证
function weihu_check()
    if config_weihu == "on" then
        return sayHtml(config_weihu_title,config_weihu_msg)
    end
end

-- 域名验证
function domain_check()
    if config_domain == "on" then
        local hostName = ngx.var.host
        if config_domain_value[hostName] == nil then
            if config_domain_redirect ~= nil and config_domain_redirect ~= "" then
                return ngx.redirect(config_domain_redirect,301)
            else
                return sayHtml(config_domain_title,config_domain_msg)
            end
        end
    end
end

-- ip黑名单验证
function black_ip_check()
    if config_black_ip == "on" then
        local clientIp = ngx.var.remote_addr
        local result = ipCheck(clientIp,config_black_ip_value)

        if result then
            return sayHtml(config_black_ip_title,config_black_ip_msg)
        end
    end
end

-- ip白名单验证
function white_ip_check()
    if config_white_ip == "on" then
        local clientIp = ngx.var.remote_addr
        local result = ipCheck(clientIp,config_white_ip_value)

        -- 判断是否IP白名单，跳过后续验证
        if result then
            return ngx.exit(ngx.OK)
        end

        -- 是否不在IP白名单的都禁止访问
        if config_white_ip_only == "on" and result == false then
            return sayHtml(config_white_ip_only_title,config_white_ip_only_msg)
        end
    end
end

-- url验证
function url_check()
    if config_url == "on"  then
        if preg_match(ngx.var.request_uri,config_url_value,"ijo") then
            return ngx.exit(ngx.OK)
        end
    end
end

-- 目录验证
function dir_check()
    if config_dir == "on"  then
        if preg_match(ngx.var.uri,config_dir_value,"ijo") then
            return sayHtml(config_dir_title,config_dir_msg)
        end
    end
end

-- 域名header验证
function domain_header_check()
    if config_domain_header == "on"  then
        -- 静态资源不验证header
        local urlExt = getExt()
        if urlExt ~= nil and preg_match(urlExt,config_static_ext,"ijo") then
            return ngx.exit(ngx.OK)
        end

        local hostName = ngx.var.host
        if config_domain_header_value[hostName] ~= nil then
            local headers = ngx.req.get_headers()
            if headers[config_domain_header_value[hostName][1]] ~= config_domain_header_value[hostName][2] then
                return sayHtml(config_domain_header_title,config_domain_header_msg)
            else
                 -- 判断是否跳过后续验证
                if config_domain_header_exit == "on" then
                    return ngx.exit(ngx.OK)
                end
            end
        end
    end
end

-- 反向代理验证
function proxy_check()
    local clientIp = getClientIp()
    if config_proxy == "on" and clientIp ~= ngx.var.remote_addr then
        return sayHtml(config_proxy_title,config_proxy_msg)
    end
end

-- user_agent 验证
function user_agent_check()
    if config_user_agent == "on" then
        local userAgent = ngx.var.http_user_agent

        -- 判断userAgent是否为空
        if userAgent == nil then
            return sayHtml(config_user_agent_title,config_user_agent_msg)
        end

        -- 判断userAgent是否包含黑名单关键字
        if preg_match(userAgent,config_user_agent_value,"ijo") then
            return sayHtml(config_user_agent_title,config_user_agent_msg)
        end

        -- 是否开启userAgent简单认证
        if config_user_agent_auth == "on" then
            local realBrowser = true

            -- 浏览器头必定包含Mozilla
            if not preg_match(userAgent,"Mozilla","ijo") then
                realBrowser = false
            end

            -- 火狐浏览器必定包含 Mozilla Gecko Firefox
            if preg_match(userAgent,"Firefox","ijo") and not preg_match(userAgent,"^Mozilla.*Gecko.*Firefox.*$","ijo") then
                realBrowser = false
            end

            -- IE浏览器 必定包含 Mozilla MSIE|Trident Windows NT
            if preg_match(userAgent,"(MSIE|Trident)","ijo") and not preg_match(userAgent,"(Mozilla.*MSIE.*Windows NT.*|Mozilla.*Trident.*)$","ijo") then
                realBrowser = false
            end

            -- 苹果浏览器必定包含 Mozilla AppleWebKit Gecko Safari
            if preg_match(userAgent,"Safari","ijo") and not preg_match(userAgent,"^Mozilla.*AppleWebKit.*Gecko.*Safari.*$","ijo") then
                realBrowser = false
            end
    
            -- edge 必定包含 Mozilla AppleWebKit Gecko Safari Edg
            if preg_match(userAgent,"Edg","ijo") and not preg_match(userAgent,"^Mozilla.*AppleWebKit.*Gecko.*(Safari.*Edg|Edg.*Safari).*$","ijo") then
                realBrowser = false
            end

            -- Chrome 必定包含 Mozilla AppleWebKit Gecko Chrome Safari
            if preg_match(userAgent,"Chrome","ijo") and not preg_match(userAgent,"^Mozilla.*AppleWebKit.*Gecko.*Chrome.*Safari.*$","ijo") then
                realBrowser = false
            end

            -- 旧版Opera
            if preg_match(userAgent,"Opera","ijo") and not preg_match(userAgent,"^Opera.*Presto.*Version.*$","ijo") then
                realBrowser = false
            end
    

            -- 不是蜘蛛的时候，判断浏览器真假
            if not realBrowser and not preg_match(userAgent,"(spider|bot)","ijo") then
                return sayHtml(config_user_agent_title,config_user_agent_msg)
            end
        end
    end
end

-- 搜索蜘蛛白名单和真假蜘蛛验证
function bots_check()
    local userAgent = ngx.var.http_user_agent

    -- 判断是否允许的蜘蛛
    if config_white_bots == "on" then
        if preg_match(userAgent,"(spider|bot)","ijo") and not preg_match(userAgent,config_bots_white_value,"ijo") then
            return sayHtml(config_white_bots_title,config_white_bots_msg)
        end
    end

    -- 验证蜘蛛真假；判断是否开启验证，且是否属于蜘蛛
    if config_bots_check == "on" and preg_match(userAgent,"(spider|bot)","ijo") then
            for key, value in pairs(config_bots_check_value) do
            -- 判断是否包含待验证的蜘蛛关键字
            if preg_match(userAgent,key,"ijo") then
                local clientIp = getClientIp()
                -- 验证蜘蛛真假,host 反查ip
                local handle = io.popen("host " ..clientIp)
                local result = handle:read("*all")
                handle:close()
                --检查是否包含验证域名
                if preg_match(result,value,"ijo") then
                    return ngx.exit(ngx.OK)
                else
                    return sayHtml(config_bots_check_title,cconfig_bots_check_msg)
                end
            end
        end
    end
end

-- 国家黑名单验证
function black_country_check()
    if config_black_country == "on" then
        local country = getCountry()

        if config_black_country_value[country] ~= nil then
            return sayHtml(config_black_country_title,config_black_country_msg)
        end
    end
end

-- 国家白名单验证
function white_country_check()
    if config_white_country == "on" then
        local country = getCountry()

        if not country then
            return sayHtml("服务器错误","IP归属地获取失败！")
        else
            if config_white_country_value[country] == nil then
                return sayHtml(config_white_country_title,config_white_country_msg)
            end
        end
    end
end

-- 防刷新验证
function black_limit_check()
    if config_black_limit == "on" then
        -- 调用redis脚本
        local redis = require "redis"
        -- 创建redis实例
        local red = redis:new()
        -- 设置redis超时时间
        red:set_timeout(1000)
        -- 连接redis服务
        local ok, err = red:connect(config_redis_ip,config_redis_port)
        -- 连接失败报错
        if not ok then
            return close_redis(red)
        end

        local clientIp = getClientIp()
        local hostName = ngx.var.host
        local requestUri = ngx.var.request_uri

        local limitKey = "limit:"..clientIp..hostName..requestUri
        local blockIp = "limit:"..clientIp..":block"
        local blockTime = "limit:"..clientIp..":time"

        -- 判断ip是否被拒绝
        local is_block,err = red:get(blockIp)
        if tonumber(is_block) == 1 then
            local block_time,err = red:get(blockTime)
            local block_end_time = config_black_limit_second - ( ngx.time() - block_time )

            -- 关闭redis
            close_redis(red)
            return sayHtml(config_black_limit_title,ngx.re.sub(config_black_limit_msg,"#block_end_time#",block_end_time))
        end

        -- 判断ip是否正常
        -- incr key值不存在则设置为1，存在则自增1
        res, err = red:incr(limitKey)
        if res == 1 then
            -- expire 用于设置 key 的过期时间，key 过期后将不再可用。单位以秒计
            res, err = red:expire(limitKey,1)
        end

        -- 如果每秒访问次数大于 config_black_limit_nums，则加入黑名单，限制config_black_limit_second秒
        if res > config_black_limit_nums then
            -- 设置限制的ip和限制时间
            red:set(blockIp,1)
            red:expire(blockIp,config_black_limit_second)
            -- 记录封禁时间，用于倒计时
            red:set(blockTime,ngx.time())
            red:expire(blockTime,config_black_limit_second)
        end

        -- 关闭redis连接
        close_redis(red)
    end
end
