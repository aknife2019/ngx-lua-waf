-- 防护模式还是日志模式 waf/logs
config_status = "waf"
-- 日志调试目录
waf_debug_dir = "/home/wwwlogs/waf-debug.log"
-- 错误日志保存目录
waf_logs_dir = "/home/waflogs/"

-- 是否开启网站维护模式
config_weihu = "off"
-- 网站维护内容
config_weihu_title = "网站维护中"
config_weihu_msg = "维护时间:2020-08-12 12:00 - 2020-08-12 13:00"

-- 统一返回信息，防止拦截信息暴露
config_msg = ""

-- 是否开启域名验证
config_domain = "off"
-- 此值不为空，则非授权域名跳转到此值
config_domain_redirect = ""
-- 追加值
-- config_domain_value['域名'] = "备注"

-- 是否开启IP黑名单
config_black_ip = "off"
-- 追加值
-- config_black_ip_value["IP地址"] = "备注"

-- 是否开启IP白名单
config_white_ip = "off"
-- 追加值
-- config_white_ip_value["ip地址"] = "备注"
-- 是否不在IP白名单的都禁止访问
config_white_ip_only = "off"

-- 是否开启URL白名单
config_url = "off"
-- 重新赋值
-- config_url_value = "^\\/(robots\\.txt)$"

-- 是否开启目录限制
config_dir = "off"
-- 重新赋值
-- config_dir_value = "^\\/(phpmyadmin|mysql|admin|wp-admin)\\/"

-- 是否开启域名header验证
config_domain_header = "off"
-- 静态资源后缀，用于排除header验证
config_static_ext = "(css|js|jpeg|jpg|png|gif|bmp|ico|webp)"
-- 域名额外验证是否跳过其他验证，on 跳过，off继续验证
config_domain_header_exit = "off"
-- 追加值
-- config_domain_header_value['域名'] = {"Header名称","Header值"}

-- 反向代理验证/透明代理/普通匿名代理
-- 只有在 clientIp 与 ngx.var.remote_addr 结果不同时有效
config_proxy = "off"
-- 追加值
-- config_proxy_value["IP/IP段"] = "备注"

-- 是否开启user_agent 过滤/禁止访问的user_agent
config_user_agent = "off"
-- 重新赋值
-- config_user_agent_value = "(nimbostratus|petalbot|mj12bot|ahrefsbot|semrushbot|blexbot|dotbot|mail.ru_bot|pyspider|curl|wget|java|pecl|python|aiohttp|okhttp|guzzle|libwww|urllib|scrapy|httrack|nmap|sqlmap|CheckHost|mechanize|urlgrabber|libdnf|httpie|http_request2|go-http-client)"
-- 是否开启userAgent简单认证
config_user_agent_auth = "off"

-- 是否开启蜘蛛白名单，如果user-agent中包含 bot和spider，则验证是否白名单
-- 建议配合蜘蛛真实性验证，防止伪造userAgent蜘蛛名称
config_white_bots = "off"

-- 是否验证搜索引擎蜘蛛的真实性
config_bots_check = "off"

-- 是否开启国家黑名单
config_black_country = "off"
-- 追加值
-- config_black_country_value["国家编码"] = "备注"

-- 是否开启国家白名单
config_white_country = "off"
-- 追加值
-- config_white_country_value["国家编码"] = "备注"

-- 是否开启cc防护
config_black_limit = "off"
-- 触发防刷新次数的阈值(每秒)
config_black_limit_nums = 100
-- 触发方刷新次数后闲置的时长(秒)
config_black_limit_second = 30

-- redis 配置
config_redis_ip = "127.0.0.1"
config_redis_port = "6379"

-- 自定义规则,优先级最高
function custom()
--     local userAgent = ngx.var.http_user_agent
--     if preg_match(userAgent,"curl|wget","ijo") ~= nil then
--         return ngx.exit(ngx.OK)
--     end
end
