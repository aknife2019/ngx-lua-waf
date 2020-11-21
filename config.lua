-- 是否记录访问日志
config_access = "off"
-- 访问日志保存目录
acc_logs_dir = "/home/wwwlogs/"

-- 防护模式还是日志模式 waf/logs/both
config_status = "both"
-- 日志调试目录
waf_debug_dir = "/home/wwwlogs/waf-debug.log"
-- 错误日志保存目录
waf_logs_dir = "/home/waflogs/"
-- 错误日志保存格式 json | string
logs_type = "string"

-- 是否开启网站维护模式
config_weihu = "off"
-- 网站维护内容
config_weihu_title = "网站维护中"
config_weihu_msg = "维护时间:2020-03-10 01:00 - 2020-03-10 05:00"

-- 统一返回信息，防止拦截信息暴露
-- 您的访问已被安全防护组件拦截，如果被错误拦截，请联系管理员
config_msg = ""

-- 是否开启域名验证
config_domain = "off"
-- 载入域名白名单文件 config_domain_value
-- lua/config/domain.lua
-- 提示消息内容
config_domain_title = "拒绝访问"
config_domain_msg = "未被授权的域名，禁止访问"

-- 是否开启IP黑名单
config_balck_ip = "off"
-- 载入IP黑名单内容 config_white_ip_value
-- lua/config/black_ip.lua
-- 提示消息内容
config_balck_ip_title = "拒绝访问"
config_balck_ip_msg = "您的IP地址被拒绝访问"

-- 是否开启IP白名单
config_white_ip = "off"
-- 载入IP白名单内容 config_white_ip_value
-- lua/config/white_ip.lua
-- 是否不在IP白名单的都禁止访问
config_white_ip_only = "off"
-- 提示消息内容
config_white_ip_only_title = "拒绝访问"
config_white_ip_only_msg = "您的IP地址未被授权访问"

-- 是否开启URL白名单
config_url = "off"
config_url_value = "^/(robots.txt|api.php/\\?.*)$"

-- 是否开启目录限制
config_dir = "off"
config_dir_value = "^/(phpmyadmin/|admin/|mysql/)"
config_dir_title = "拒绝访问"
config_dir_msg = "未被授权的目录，禁止访问"

-- 是否开启域名header验证
config_domain_header = "off"
-- 载入IP白名单内容 config_domain_header_value
-- lua/config/domain_header.lua
-- 域名额外验证是否跳过其他验证，on 跳过，off继续验证
config_domain_header_exit = "off"
config_domain_header_title = "拒绝访问"
config_domain_header_msg = "不正确的header授权，禁止访问"

-- 反向代理验证/透明代理/普通匿名代理 
-- 只有在 clientIp 与 ngx.var.remote_addr 结果不同时有效
config_proxy = "off"
-- 载入IP白名单内容 config_proxy_value_value
-- lua/config/proxy_ip.lua
config_proxy_title = "拒绝访问"
config_proxy_msg = "未被授权的代理，禁止访问"

-- 是否开启user_agent 过滤/禁止访问的user_agent
config_user_agent = "off"
-- 载入过滤内容 config_user_agent_value
-- lua/config/user_agent.lua
-- 是否开启 user_agent 白名单 config_user_agent_white
config_user_agent_white = "off"
-- 提示消息内容
config_user_agent_title = "拒绝访问"
config_user_agent_msg = "伪造/未被授权的 User-Agent"

-- 是否开启蜘蛛白名单，如果user-agent中包含 bot和spider，则验证是否白名单
-- 用于排除遵守robots规则的其他搜索引擎或第三方蜘蛛，如Semrush，BotDotBot等
-- 不建议开启，可能无意间就会屏蔽掉流量来源，除非你清楚的知道流量来源
-- 公用 bots  config_bots_white_value
config_white_bots = "off"
-- 提示消息内容
config_white_bots_title = "拒绝访问"
config_white_bots_msg = "未被授权的搜索引擎蜘蛛"

-- 是否验证搜索引擎蜘蛛的真实性
-- 消耗资源，且部分国内蜘蛛不支持反查和正常，不建议开启
-- 有公开ip段，可以自行修改
config_bots_check = "off"
-- 载入蜘蛛验证内容和验证规则 config_bots_check_value
-- lua/config/bots.lua
-- 提示消息内容
config_bots_check_title = "拒绝访问"
cconfig_bots_check_msg = "伪造的搜索引擎蜘蛛"

-- geo数据库地址
geo_path = "/usr/local/nginx/conf/lua/library/GeoLite2.mmdb"
-- 是否开启国家黑名单
config_black_country = "off"
-- 禁止访问的国家
-- 禁止访问的国家验 config_black_country_value
-- lua/config/black_country.lua
-- 提示消息内容
config_black_country_title = "拒绝访问"
config_black_country_msg = "您的IP归属国家被拒绝访问"

-- 是否开启国家白名单
config_white_country = "off"
-- 允许访问的国家(开启国家白名单才有效) GeoLite2 中的 [country][name][en]
-- lua/config/white_country.lua
-- 提示消息内容
config_white_country_title = "拒绝访问"
config_white_country_msg = "当前网站已开启区域访问限制"

-- 是否开启cc防护
config_black_limit = "off"
-- 触发防刷新次数的阈值(每秒)
config_black_limit_nums = 100
-- 触发方刷新次数后闲置的时长(秒)
config_black_limit_second = 30
-- 不限制的后缀 config_limit_ext
config_limit_ext = "(css|js|jpeg|jpg|png|gif|bmp|ico|webp)"
-- 提示消息内容
config_black_limit_title = "您的IP地址已被临时禁止访问"
config_black_limit_msg = "连接超限/刷新频率过快，请 <span id='time'>#block_end_time#</span> 秒后再试<script>var timeEnd=setInterval(function(){var second=document.getElementById('time');if(parseInt(second.innerText)>0){second.innerText=parseInt(second.innerText)-1}else{clearInterval(timeEnd);location.reload();}},1000)</script>"

-- redis 配置
config_redis_ip = "127.0.0.1"
config_redis_port = "6379"
