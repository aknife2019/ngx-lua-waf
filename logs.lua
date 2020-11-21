local dayDate = os.date("%Y-%m-%d")
local cjson = require "cjson"

-- 拦截日志
local waf_logs = ngx.ctx.waf
if waf_logs ~= nil or type(waf_logs) == "table" then
     -- 创建目录
    local waf_path = ngx.ctx.waf_path .. waf_logs["host"] .. "/"
    -- 创建目录
    if os.execute("cd "..waf_path) ~= 0 then
        os.execute("mkdir -p " .. waf_path)
        os.execute("chmod -R 0777 " .. waf_path)
    end

    -- 组合日志记录
    local logs = ""
    if ngx.ctx.type == "json" then
        logs = cjson.encode(waf_logs) .. "\n\n"
    else
        logs =  "请求域名：" .. waf_logs["host"] .."\n请求时间：" .. waf_logs["time"] .."\n响应代码：" .. waf_logs["status"] .."\n客户端IP：" .. waf_logs["client"] .."\nRemote-IP：" .. waf_logs["remote"] .. "\n请求参数：" .. waf_logs["uri"] .. "\n请求方法：" .. waf_logs["method"] .. "\nPOST参数:"..waf_logs["post"] .. "\nUser-Agent：" .. waf_logs["agent"] .. "\n完整Header:" .. cjson.encode(waf_logs['header']) .. "\n拦截规则：" .. waf_logs["type"] .. "\n\n"
    end

    -- 排除网站图标请求
    if waf_logs['uri'] ~= '/favicon.ico' then
        local f = assert(io.open(waf_path..dayDate..".log", "a"))
        f:write(logs)
        f:close()
    end
end

-- 访问日志
local acc_logs = ngx.ctx.acc
if acc_logs ~= nil or type(acc_logs) == "table" then
    -- 创建目录
    local acc_path = ngx.ctx.acc_path .. acc_logs["host"] .. "/"
    if os.execute("cd "..acc_path) ~= 0 then
        os.execute("mkdir -p " .. acc_path)
        os.execute("chmod -R 0777 " .. acc_path)
    end

    -- 组合日志记录
    local logs = ""
    if ngx.ctx.type == "json" then
        logs = cjson.encode(acc_logs) .. "\n\n"
    else
        logs =  "请求域名：" .. acc_logs["host"] .."\n请求时间：" .. acc_logs["time"] .."\n响应代码：" .. waf_logs["status"] .."\n客户端IP：" .. acc_logs["client"] .."\nRemote-IP：" .. acc_logs["remote"] .. "\n请求参数：" .. acc_logs["uri"] .. "\n请求方法：" .. acc_logs["method"] .. "\nPOST参数:"..acc_logs["post"] .. "\nUser-Agent：" .. acc_logs["agent"] .. "\n\n"
    end

    local f = assert(io.open(acc_path..dayDate..".log", "a"))
    f:write(logs)
    f:close()
end