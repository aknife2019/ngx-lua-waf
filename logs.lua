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
    local logs =  "请求域名：" .. waf_logs["host"] .."\n请求时间：" .. waf_logs["time"] .."\n响应代码：" .. waf_logs["status"] .."\n客户端IP：" .. waf_logs["client"] .."\nRemote-IP：" .. waf_logs["remote"]
    if waf_logs["xffip"] then
        logs = logs .. "\nX-Forwarded-For：" .. waf_logs["xffip"]
    end
    if waf_logs["cfip"] then
        logs = logs .. "\nCloudFlareIp：" .. waf_logs["cfip"] 
    end

    logs =  logs .. "\n请求参数：" .. waf_logs["uri"] .. "\n请求方法：" .. waf_logs["method"]
    if waf_logs["method"] == "POST" and waf_logs["post"] ~= "" then
        logs = logs .. "\nPOST参数:"..waf_logs["post"]
    end
    logs = logs .. "\n完整Header:" .. cjson.encode(waf_logs['header']) .. "\nUser-Agent：" .. waf_logs["agent"] .. "\n拦截规则：" .. waf_logs["type"] .. "\n\n"

    -- 排除网站图标请求
    if waf_logs['uri'] ~= '/favicon.ico' then
        local f = assert(io.open(waf_path .. dayDate .. ".log", "a"))
        f:write(logs)
        f:close()
    end
end
