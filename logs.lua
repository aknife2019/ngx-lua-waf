local waf_logs = ngx.ctx.waf
local waf_type = ngx.ctx.type
if waf_logs == nil or type(waf_logs) ~= "table" then
    return
end

-- 组合日志记录
local logs = ""
if waf_type == "json" then
    local cjson=require "cjson"
    logs = cjson.encode(waf_logs) .. "\n\n"
else
    logs =  "请求域名：" .. waf_logs["host"] .."\n请求时间：" .. waf_logs["time"] .."\n客户端IP：" .. waf_logs["client"] .."\nRemote-IP：" .. waf_logs["remote"] .. "\n请求参数：" .. waf_logs["uri"] .. "\n请求方法：" .. waf_logs["method"] .. "\nPOST参数:"..waf_logs["post"] .. "\nUser-Agent：" .. waf_logs["agent"] .. "\n完整Header:" .. waf_logs['header'] .. "\n拦截规则：" .. waf_logs["type"] .. "\n\n"
end

-- 排除网站图标请求
if waf_logs['uri'] ~= '/favicon.ico' then
    local f = assert(io.open(ngx.ctx.waf_path, "a"))
    f:write(logs)
    f:close()
end
