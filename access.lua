require "init"

-- 获取当前客户端的header头，判断真实IP
headers = ngx.req.get_headers()
-- 仅获取真实IP cloudflare:CF-Connecting-IP 未考虑其他cdn
clientIp = getClientIp()
if clientIp == nil then
    clientIp = ngx.var.remote_addr
    sayHtml('未获取到用户IP','服务器配置错误')
end


hostName = ngx.var.host
userAgent = ngx.var.http_user_agent
requestUri = ngx.var.request_uri

weihu_check()
domain_check()
black_ip_check()
white_ip_check()
domain_header_check()
proxy_check()
dir_check()
user_agent_check()
bots_check()
black_country_check()
white_country_check()
black_limit_check()

-- sayHtml("测试通过","正常执行中")
