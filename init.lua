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

-- Server Ip白名单
function server_ip_check()
    if config_server_ip == "on" then
        local hostName = ngx.var.host
        local clientIp = ngx.var.remote_addr
        local result = ipCheck(clientIp,config_server_ip_value)

        -- 如果不在白名单列表，且域名不在例外列表，禁止访问
        if result == false and config_server_exclude[hostName] == nil  then
            return sayHtml(config_server_ip_title,config_server_ip_msg)
        end
    end
end

-- ip黑名单验证
function black_ip_check()
    if config_black_ip == "on" then
        local clientIp = getClientIp()
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

-- user_agent 验证
function user_agent_check()
    if config_user_agent == "on" then
        local userAgent = ngx.var.http_user_agent

        -- 判断userAgent是否为空 或 userAgent是否包含黑名单关键字
        if userAgent == nil or preg_find(userAgent,config_user_agent_value,"ijo") then
            return sayHtml(config_user_agent_title,config_user_agent_msg)
        end
    end
end

-- 搜索蜘蛛白名单和真假蜘蛛验证
function bots_check()
    local userAgent = ngx.var.http_user_agent

    -- 判断是否允许的蜘蛛
    if config_white_bots == "on" then
        if preg_find(userAgent,config_bots_white_value,"ijo") then
            -- 获取客户端IP
            local clientIp = getClientIp()

            local result = botsCheckResult(userAgent,clientIp)

            if result then
                return ngx.exit(ngx.OK)
            else
                return sayHtml(config_bots_check_title,cconfig_bots_check_msg)
            end
        else
            return sayHtml(config_white_bots_title,config_white_bots_msg)
        end
    end
end

-- 国家黑名单验证
function black_country_check()
    if config_black_country == "on" then
        local country = getCountry()

        if config_black_country_value[country] ~= nil then
            -- 需要验证蜘蛛且未开启蜘蛛验证时，判断蜘蛛，防止处于黑名单国家而被屏蔽
            if config_black_country_bots == "on" and config_white_bots == "off" and preg_find(userAgent,config_bots_white_value,"ijo") then
                local userAgent = ngx.var.http_user_agent
                local clientIp = getClientIp()
                local result = botsCheckResult(userAgent,clientIp)

                if result then
                    return ngx.exit(ngx.OK)
                else
                    return sayHtml(config_black_country_title,config_black_country_msg)
                end
            else
                return sayHtml(config_black_country_title,config_black_country_msg)
            end
        end
    end
end

-- 国家白名单验证
function white_country_check()
    if config_white_country == "on" then
        local country = getCountry()

        if config_white_country_value[country] == nil then
            local userAgent = ngx.var.http_user_agent

            -- 需要验证蜘蛛且未开启蜘蛛验证时，判断蜘蛛，防止未处于白名单国家而被屏蔽
            if config_white_country_bots == "on" and config_white_bots == "off" and preg_find(userAgent,config_bots_white_value,"ijo") then
                local clientIp = getClientIp()
                local result = botsCheckResult(userAgent,clientIp)

                if result then
                    return ngx.exit(ngx.OK)
                else
                    return sayHtml(config_white_country_title,config_white_country_msg)
                end
            else
                return sayHtml(config_white_country_title,config_white_country_msg)
            end
        end
    end
end

-- 防刷新验证
function black_limit_check()
    if config_black_limit == "on" then

        -- 判断后缀，不判断图片、css、js等静态资源
        local urlExt = getExt() or ""
        if not preg_find(urlExt,"(css|js|ico|png|jpg|jpeg|gif|webp)","ijo") then
            return ngx.exit(ngx.OK)
        end

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
