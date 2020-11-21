-- 载入配置文件
require "config"

-- 载入配置文件
require "black_ip"
require "white_ip"
require "proxy_ip"
require "domain"
require "domain_header"
require "user_agent"
require "bots"
require "black_country"
require "white_country"

-- 函数判断规则 --
preg_match = ngx.re.find

-- 获取客户端IP
function getClientIp()
    local headers = ngx.req.get_headers()
    local clientIp = nil
    -- 仅获取真实IP cloudflare:CF-Connecting-IP
    -- 取消直接获取CF-Connecting-IP，当多层代理时获取的是假IP
    -- clientIp = headers["CF-Connecting-IP"]
    if type(headers["X-Forwarded-For"]) == "table" then
        clientIp = headers["X-Forwarded-For"][1]
    else
        clientIp = headers["X-Forwarded-For"]
    end

    if clientIp == nil then
        clientIp = headers["X-Real-IP"]
    end

    if clientIp == nil then
        clientIp = ngx.var.remote_addr
    end

    --
    if preg_match(clientIp,",") then
        local pos  = string.find(clientIp, ",", 1)
        clientIp = string.sub(clientIp,1,pos-1)
    end

    return clientIp
end

-- 根据ip地址获取国家
function getCountry()
    local cjson = require "cjson"
    local geo = require "maxminddb"

    if not geo.initted() then
        geo.init(geo_path)
    end

    local res,err=geo.lookup(getClientIp())
    if not res then
        return false
    else
        return res["country"]["iso_code"]
    end
end

-- IP校验
function ipCheck(ipAddress,ipValue)
    local ipmatcher = require "ipmatcher"
    local ip, err = ipmatcher.new_with_value(ipValue)
    local data, err = ip:match(ipAddress)
    if data then
        return true
    else
        return false
    end
end

-- 关闭redis连接
function close_redis(red)
    -- 若果redis未连接
    if not red then
        return
    end

    --释放连接(连接池实现)
    local pool_max_idle_time = 10000 --毫秒
    local pool_size = 100 --连接池大小

    -- 判断redis连接池
    local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)
    if not ok then
        ngx.say("错误：redis连接池已断开")
        -- 终止执行
        return ngx.exit(ngx.HTTP_OK)
    end
end

--获取扩展名
function getExt()
    local url = ngx.var.uri
    local ext = url:match(".+%.(%w+)$")
    if ext == nil then
        ext = url:match(".+%.(%w+)%?%w+$")
    end
    if ext == nil then
        ext = url:match(".+%.(%w+)%?%w=%w+$")
    end
    return ext
end

-- 调试
function debug(logs)
    local f = assert(io.open(waf_debug_dir, "a"))
    f:write(logs.."\n\n")
    f:close()
end

-- 获取请求参数
function getLogs()
    local time = os.date("%Y-%m-%d %H:%M:%S")
    
    local lua_logs = {}
    -- 记录参数到 log_by_lua  段处理
    lua_logs["host"] = ngx.var.host
    local status = ngx.status
    if status == 0 then
        status = 200
    end
    lua_logs["status"] = status
    lua_logs["time"] = time
    lua_logs["client"] = getClientIp()
    lua_logs["remote"] = ngx.var.remote_addr
    lua_logs["uri"] = ngx.var.request_uri
    lua_logs["method"] = ngx.var.request_method
    -- 开启获取body数据
    ngx.req.read_body()
    lua_logs["post"] = ngx.req.get_body_data() or ""
    lua_logs["agent"] = ngx.var.http_user_agent
    lua_logs["header"] = ngx.req.get_headers()

    return lua_logs
end

-- 提示内容
function sayHtml(title,msg)
    -- 获取当前服务器时间
    local time = os.date("%Y-%m-%d %H:%M:%S")

    if config_status == "logs" or config_status == "both" then
        ngx.ctx.type = logs_type
        local waf_logs = getLogs()
        waf_logs["type"] = msg
        ngx.ctx.waf = waf_logs
        ngx.ctx.waf_path = waf_logs_dir       
    end

    if config_status == "waf" or config_status == "both" then
        -- 判断是否启用统一返回信息
        if config_msg ~= "" then
            msg = config_msg
        end

        if config_weihu == "on" then
            ngx.status = 200
            msg = config_weihu_msg
        else
            ngx.status = 403
        end

        ngx.say("<!doctype html><html><head><meta charset='utf-8'><title>安全组件拦截提示</title><style>* {-webkit-box-sizing: border-box;-moz-box-sizing: border-box;box-sizing: border-box;}html {font-family:sans-serif;font-size:10px;-webkit-tap-highlight-color:rgba(0,0,0,0);}li{color:cadetblue;font-size:24px;}body{margin:0;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:14px;line-height:1.42857143;color:#333;background-color:#fff;}.container{max-width: 1200px;width:80%;margin:0px auto;}.jumbotron {margin-bottom: 30px;color: inherit;background-color: #eee;border-radius: 6px;padding: 48px 60px;}.jumbotron .h1, .jumbotron h1 {font-size: 60px;}.panel {margin-bottom: 20px;background-color: #fff;border: 1px solid transparent;border-radius: 4px;-webkit-box-shadow: 0 1px 1px rgba(0,0,0,.05);box-shadow: 0 1px 1px rgba(0,0,0,.05);}.panel-success {border-color: #d6e9c6;}.panel-success>.panel-heading {color: #3c763d;background-color: #dff0d8;border-color: #d6e9c6;}.panel-error{background-color:#dff0d8;border-color: #d6e9c6;color:gray;}.panel-heading {text-align:center;padding: 10px 15px;border-bottom: 1px solid transparent;border-top-left-radius: 3px;border-top-right-radius: 3px;}.jumbotron p {margin-bottom: 15px;font-size: 21px;font-weight: 200;}</style></head><body><div class='container' style='margin-top:9%;'><div class='jumbotron'><div class='panel panel-error'><div class='panel-heading' style='font-size: 60px;'>",title,"</div></div><div class='panel panel-success'><div class='panel-heading'><h1>",msg,"</h1></div></div><p style='text-align:center;margin-top:50px;'>时间: ",time," &nbsp; &nbsp; IP信息: ",getClientIp()," &nbsp; &nbsp; <a style='text-decoration:none;color: brown;' href='https://github.com/aknife2019/ngx-lua-waf' target='_blank'>ngx-lua-waf</a></p></div></div></body></html>")
        return ngx.exit(ngx.HTTP_OK)
    end
end
