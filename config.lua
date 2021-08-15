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
config_weihu_msg = "维护时间:xxxx-xx-xx xx:xx  -- xxxx-xx-xx xx:xx"

-- 统一返回信息，防止拦截信息暴露
config_msg = "您的访问已被安全防护组件拦截，如果被错误拦截，请联系管理员"

-- 是否开启域名验证
config_domain = "off"
-- 载入域名白名单文件
-- lua/config/domain.lua
-- 提示消息内容
config_domain_title = "403 拒绝访问"
config_domain_msg = "未被授权的域名，禁止访问"
-- 此值不为空，则非授权域名跳转到此值
config_domain_redirect = ""

-- 是否开启IP黑名单
config_black_ip = "off"
-- 载入IP黑名单内容
-- lua/config/black_ip.lua
-- 提示消息内容
config_black_ip_title = "403 拒绝访问"
config_black_ip_msg = "您的IP地址被拒绝访问"

-- 是否开启IP白名单
config_white_ip = "off"
-- 载入IP白名单内容
-- lua/config/white_ip.lua
-- 是否不在IP白名单的都禁止访问
config_white_ip_only = "off"
-- 提示消息内容
config_white_ip_only_title = "403 拒绝访问"
config_white_ip_only_msg = "您的IP地址未被授权访问"

-- 是否开启URL白名单
config_url = "off"
-- 载入URL白名单内容
-- lua/config/white_url.lua

-- 是否开启目录限制
config_dir = "off"
-- 载入目录规则配置
-- lua/config/black_dir.lua
config_dir_title = "403 拒绝访问"
config_dir_msg = "未被授权的目录，禁止访问"

-- 是否开启域名header验证
config_domain_header = "off"
-- 静态资源后缀，用于排除header验证
config_static_ext = "(css|js|jpeg|jpg|png|gif|bmp|ico|webp)"
-- 载入域名header验证内容
-- lua/config/domain_header.lua
-- 域名额外验证是否跳过其他验证，on 跳过，off继续验证
config_domain_header_exit = "off"
config_domain_header_title = "403 拒绝访问"
config_domain_header_msg = "不正确的header授权，禁止访问"

-- 反向代理验证/透明代理/普通匿名代理 
-- 只有在 clientIp 与 ngx.var.remote_addr 结果不同时有效
config_proxy = "off"
-- 载入Proxy IP白名单内容
-- lua/config/proxy_ip.lua
config_proxy_title = "403 拒绝访问"
config_proxy_msg = "未被授权的代理 / 禁止浏览器云端加速，禁止访问"

-- 是否开启user_agent 过滤/禁止访问的user_agent
config_user_agent = "off"
-- user_agent 黑名单内容
-- lua/config/useragent.lua
-- 是否开启userAgent简单认证
config_user_agent_auth = "off"
-- 提示消息内容
config_user_agent_title = "403 拒绝访问"
config_user_agent_msg = "伪造/未被授权的 User-Agent"

-- 是否开启蜘蛛白名单，如果user-agent中包含 bot和spider，则验证是否白名单
-- 用于排除遵守robots规则的其他搜索引擎或第三方蜘蛛，如Semrush，BotDotBot等
-- 建议配合蜘蛛真实性验证，防止伪造userAgent蜘蛛名称
-- 不建议开启，可能无意间就会屏蔽掉流量来源，除非你清楚的知道流量来源
-- lua/config/bots.lua
config_white_bots = "off"
-- 提示消息内容
config_white_bots_title = "403 拒绝访问"
config_white_bots_msg = "未被授权的搜索引擎蜘蛛"

-- 是否验证搜索引擎蜘蛛的真实性
config_bots_check = "off"
-- 载入蜘蛛验证内容和验证规则
-- lua/config/bots.lua
-- 提示消息内容
config_bots_check_title = "403 拒绝访问"
cconfig_bots_check_msg = "伪造的搜索引擎蜘蛛"

-- geo数据库地址
geo_path = "/usr/local/nginx/conf/lua/library/GeoLite2.mmdb"
-- 是否开启国家黑名单
config_black_country = "off"
-- 禁止访问的国家
-- lua/config/black_country.lua
-- 提示消息内容
config_black_country_title = "403 拒绝访问"
config_black_country_msg = "您的IP归属地不再允许范围之内"

-- 是否开启国家白名单
config_white_country = "off"
-- 允许访问的国家(开启国家白名单才有效) GeoLite2 中的 [country][name][en]
-- lua/config/white_country.lua
-- 提示消息内容
config_white_country_title = "403 拒绝访问"
config_white_country_msg = "当前网站已开启区域访问限制"

-- 是否开启cc防护
config_black_limit = "off"
-- 触发防刷新次数的阈值(每秒)
config_black_limit_nums = 100
-- 触发方刷新次数后闲置的时长(秒)
config_black_limit_second = 30
-- 提示消息内容
config_black_limit_title = "您的IP地址已被临时禁止访问"
config_black_limit_msg = "连接超限/刷新频率过快，请 <span id='time'>#block_end_time#</span> 秒后再试<script>var timeEnd=setInterval(function(){var second=document.getElementById('time');if(parseInt(second.innerText)>0){second.innerText=parseInt(second.innerText)-1}else{clearInterval(timeEnd);location.reload();}},1000)</script>"

-- redis 配置
config_redis_ip = "127.0.0.1"
config_redis_port = "6379"
