require "init"

if getClientIp() == nil then
    sayHtml('未获取到用户IP','服务器配置错误')
end

-- 执行自定义配置
custom()

-- 判断是否开启日志
if config_access == "on" then
    -- 判断后缀，不记录图片、css、js等静态资源
    local urlExt = getExt() or ""
    if not preg_match(urlExt,"(css|js|ico|png|jpg|jpeg|gif|webp)","ijo") then
        ngx.ctx.acc = getLogs()
        ngx.ctx.type = logs_type
        ngx.ctx.acc_path = acc_logs_dir     
    end
end

weihu_check()
domain_check()
black_ip_check()
white_ip_check()
proxy_check()
url_check()
dir_check()
domain_header_check()
user_agent_check()
bots_check()
black_country_check()
white_country_check()
black_limit_check()

-- sayHtml("测试通过","正常执行中")
