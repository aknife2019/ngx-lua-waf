require "init"

if getClientIp() == nil then
    sayHtml('未获取到用户IP','服务器配置错误')
end

weihu_check()
domain_check()
server_ip_check()
black_ip_check()
white_ip_check()
user_agent_check()
bots_check()
black_country_check()
white_country_check()
black_limit_check()