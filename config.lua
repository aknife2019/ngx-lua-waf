-- 防护模式还是日志模式 waf/logs
config_status = "waf"
-- 错误日志保存目录
waf_logs_dir = "/home/waflogs/"

------------------------------------------------------------------

-- 是否开启网站维护模式
config_weihu = "off"
-- 网站维护内容
config_weihu_title = "网站维护中"
config_weihu_msg = "维护时间:xxxx-xx-xx xx:xx  -- xxxx-xx-xx xx:xx"

-- 统一返回信息，防止拦截信息暴露
-- config_msg = "您的访问已被安全防护组件拦截，如果被错误拦截，请联系管理员"
config_msg = ""

------------------------------------------------------------------

-- 是否开启域名验证
config_domain = "off"

-- 域名白名单
config_domain_value = {}
-- config_domain_value["aknife.cn"] = "我的个人博客"

-- 提示消息内容
config_domain_title = "403 拒绝访问"
config_domain_msg = "未被授权的域名，禁止访问"
-- 此值不为空，则非白名单域名跳转到此网站
config_domain_redirect = ""

------------------------------------------------------------------

-- 是否开启Server IP白名单 | 仅验证remoteip,用于判断cdn或授权的反代IP
config_server_ip = "off"

-- IP白名单,支持IP段（remote ip）
config_server_ip_value = {}
config_server_ip_value["127.0.0.1"] = "本地"

-- cloudflare 边缘IP
config_server_ip_value["173.245.48.0/20"] = "cloudflare IPV4"
config_server_ip_value["103.21.244.0/22"] = "cloudflare IPV4"
config_server_ip_value["103.22.200.0/22"] = "cloudflare IPV4"
config_server_ip_value["103.31.4.0/22"] = "cloudflare IPV4"
config_server_ip_value["141.101.64.0/18"] = "cloudflare IPV4"
config_server_ip_value["108.162.192.0/18"] = "cloudflare IPV4"
config_server_ip_value["190.93.240.0/20"] = "cloudflare IPV4"
config_server_ip_value["188.114.96.0/20"] = "cloudflare IPV4"
config_server_ip_value["197.234.240.0/22"] = "cloudflare IPV4"
config_server_ip_value["198.41.128.0/17"] = "cloudflare IPV4"
config_server_ip_value["162.158.0.0/15"] = "cloudflare IPV4"
config_server_ip_value["104.16.0.0/13"] = "cloudflare IPV4"
config_server_ip_value["104.24.0.0/14"] = "cloudflare IPV4"
config_server_ip_value["172.64.0.0/13"] = "cloudflare IPV4"
config_server_ip_value["131.0.72.0/22"] = "cloudflare IPV4"
config_server_ip_value["2400:cb00::/32"] = "cloudflare IPV6"
config_server_ip_value["2606:4700::/32"] = "cloudflare IPV6"
config_server_ip_value["2803:f800::/32"] = "cloudflare IPV6"
config_server_ip_value["2405:b500::/32"] = "cloudflare IPV6"
config_server_ip_value["2405:8100::/32"] = "cloudflare IPV6"
config_server_ip_value["2a06:98c0::/29"] = "cloudflare IPV6"
config_server_ip_value["2c0f:f248::/32"] = "cloudflare IPV6"

-- 例外名单
config_server_exclude = {}
config_server_exclude["ip.aknife.cn"] = "直接暴露到公网，不需要判断server Ip"
-- 提示消息内容
config_server_ip_title = "403 拒绝访问"
config_server_ip_msg = "您的IP地址未被授权"

------------------------------------------------------------------

-- 是否开启IP黑名单
config_black_ip = "off"

-- IP黑名单,支持IP段 127.0.0.1  0.0.0.0、0
config_black_ip_value = {}
-- config_black_ip_value["127.0.0.0"] = "未知IP"
-- 拒绝所有IP访问
-- config_black_ip_value["0.0.0.0/0"] = "未知IP"

-- 提示消息内容
config_black_ip_title = "403 拒绝访问"
config_black_ip_msg = "您的IP地址被拒绝访问"

------------------------------------------------------------------

-- 是否开启IP白名单
config_white_ip = "off"

-- IP白名单,支持IP段（remote ip）
config_white_ip_value = {}
config_white_ip_value["127.0.0.1"] = "本地"

-- 是否不在IP白名单的都禁止访问
config_white_ip_only = "off"
-- 提示消息内容
config_white_ip_only_title = "403 拒绝访问"
config_white_ip_only_msg = "您的IP地址未被授权访问"

------------------------------------------------------------------

-- 是否开启user_agent 过滤/禁止访问的user_agent
config_user_agent = "off"
-- user_agent 黑名单内容
config_user_agent_value = "(nimbostratus|petalbot|mj12bot|ahrefsbot|semrushbot|blexbot|dotbot|mail.ru_bot|pyspider|curl|wget|java|pecl|python|aiohttp|okhttp|guzzle|libwww|urllib|scrapy|httrack|nmap|sqlmap|CheckHost|mechanize|urlgrabber|libdnf|httpie|http_request2|go-http-client|dalvik)"
-- 提示消息内容
config_user_agent_title = "403 拒绝访问"
config_user_agent_msg = "未被识别的浏览器标识(UserAgent)"

------------------------------------------------------------------

-- 是否开启蜘蛛白名单
-- 用于排除遵守robots规则的其他搜索引擎或第三方蜘蛛，如Semrush，BotDotBot等
config_white_bots = "off"
-- Googlebot http://www.google.com/bot.html
-- Bingbot/AdIdxBot/BingPreview/MicrosoftPreview http://www.bing.com/bingbot.htm
-- Yahoo! Slurp http://help.yahoo.com/help/us/ysearch/slurp
-- YandexBot https://webmaster.yandex.com
-- DuckDuckBot https://duckduckgo.com/duckduckgo-help-pages/results/duckduckbot/
-- Baiduspider http://www.baidu.com/search/spider.html
-- 360Spider https://www.so.com/help/spider_ip.html
-- Yisouspider
-- Sogou web spider/Sogou wap spider https://www.sogou.com/docs/help/webmasters.htm
config_bots_white_value = "(Googlebot|Bingbot|AdIdxBot|BingPreview|MicrosoftPreview|Yahoo! Slurp|YandexBot|DuckDuckBot|Baiduspider|360Spider|Yisouspider|Sogou web spider|Sogou wap spider)"

-- 提示消息内容
config_white_bots_title = "403 拒绝访问"
config_white_bots_msg = "未被授权的搜索引擎蜘蛛"

-- 开启蜘蛛白名单后自动验证搜索引擎蜘蛛的真实性，否则白名单没有意义
config_bots_check_value = {}
config_bots_check_value["Googlebot"] = "^.*(google\\.com|googlebot\\.com)\\.$"
config_bots_check_value["Bingbot"] = "^.*search\\.msn\\.com\\.$"
config_bots_check_value["AdIdxBot"] = "^.*search\\.msn\\.com\\.$"
config_bots_check_value["BingPreview"] = "^.*search\\.msn\\.com\\.$"
config_bots_check_value["BingPreview"] = "^.*search\\.msn\\.com\\.$"
config_bots_check_value["MicrosoftPreview"] = "^.*search\\.msn\\.com\\.$"
config_bots_check_value["Yahoo! Slurp"] = "^.*yahoo\\.net\\.$"
config_bots_check_value["YandexBot"] = "^.*(yandex\\.ru|yandex\\.net|yandex\\.com)\\.$"
config_bots_check_value["DuckDuckBot"] = {"40.80.242.63","20.12.141.99","20.49.136.28","51.116.131.221","51.107.40.209","20.40.133.240","20.50.168.91","51.120.48.122","20.193.45.113","40.76.173.151","40.76.163.7","20.185.79.47","52.142.26.175","20.185.79.15","52.142.24.149","40.76.162.208","40.76.163.23","40.76.162.191","40.76.162.247","40.88.21.235","20.191.45.212","52.146.59.12","52.146.59.156","52.146.59.154","52.146.58.236","20.62.224.44","51.104.180.53","51.104.180.47","51.104.180.26","51.104.146.225","51.104.146.235","20.73.202.147","20.73.132.240","20.71.12.143","20.56.197.58","20.56.197.63","20.43.150.93","20.43.150.85","20.44.222.1","40.89.243.175","13.89.106.77","52.143.242.6","52.143.241.111","52.154.60.82","20.197.209.11","20.197.209.27","20.226.133.105","191.234.216.4","191.234.216.178","20.53.92.211","20.53.91.2","20.207.99.197","20.207.97.190","40.81.250.205","40.64.106.11","40.64.105.247","20.72.242.93","20.99.255.235","20.113.3.121","52.224.16.221","52.224.21.53","52.224.20.204","52.224.21.19","52.224.20.249","52.224.20.203","52.224.20.190","52.224.16.229","52.224.21.20","52.146.63.80","52.224.20.227","52.224.20.193","52.190.37.160","52.224.21.23","52.224.20.223","52.224.20.181","52.224.21.49","52.224.21.55","52.224.21.61","52.224.19.152","52.224.20.186","52.224.21.27","52.224.21.51","52.224.20.174","52.224.21.4","51.104.164.109","51.104.167.71","51.104.160.177","51.104.162.149","51.104.167.95","51.104.167.54","51.104.166.111","51.104.167.88","51.104.161.32","51.104.163.250","51.104.164.189","51.104.167.19","51.104.160.167","51.104.167.110","20.191.44.119","51.104.167.104","20.191.44.234","51.104.164.215","51.104.167.52","20.191.44.22","51.104.167.87","51.104.167.96","20.191.44.16","51.104.167.61","51.104.164.147","20.50.48.159","40.114.182.172","20.50.50.130","20.50.50.163","20.50.50.46","40.114.182.153","20.50.50.118","20.50.49.55","20.50.49.25","40.114.183.251","20.50.50.123","20.50.49.237","20.50.48.192","20.50.50.134","51.138.90.233","40.114.183.196","20.50.50.146","40.114.183.88","20.50.50.145","20.50.50.121","20.50.49.40","51.138.90.206","40.114.182.45","51.138.90.161","20.50.49.0","40.119.232.215","104.43.55.167","40.119.232.251","40.119.232.50","40.119.232.146","40.119.232.218","104.43.54.127","104.43.55.117","104.43.55.116","104.43.55.166","52.154.169.50","52.154.171.70","52.154.170.229","52.154.170.113","52.154.171.44","52.154.172.2","52.143.244.81","52.154.171.87","52.154.171.250","52.154.170.28","52.154.170.122","52.143.243.117","52.143.247.235","52.154.171.235","52.154.171.196","52.154.171.0","52.154.170.243","52.154.170.26","52.154.169.200","52.154.170.96","52.154.170.88","52.154.171.150","52.154.171.205","52.154.170.117","52.154.170.209","191.235.202.48","191.233.3.202","191.235.201.214","191.233.3.197","191.235.202.38","20.53.78.144","20.193.24.10","20.53.78.236","20.53.78.138","20.53.78.123","20.53.78.106","20.193.27.215","20.193.25.197","20.193.12.126","20.193.24.251","20.204.242.101","20.207.72.113","20.204.242.19","20.219.45.67","20.207.72.11","20.219.45.190","20.204.243.55","20.204.241.148","20.207.72.110","20.204.240.172","20.207.72.21","20.204.246.81","20.207.107.181","20.204.246.254","20.219.43.246","52.149.25.43","52.149.61.51","52.149.58.139","52.149.60.38","52.148.165.38","52.143.95.162","52.149.56.151","52.149.30.45","52.149.58.173","52.143.95.204","52.149.28.83","52.149.58.69","52.148.161.87","52.149.58.27","52.149.28.18","20.79.226.26","20.79.239.66","20.79.238.198","20.113.14.159","20.75.144.152","20.43.172.120","20.53.134.160","20.201.15.208","20.93.28.24","20.61.34.40","52.242.224.168","20.80.129.80"}
config_bots_check_value["Baiduspider"] = "^.*(baidu\\.com|baidu\\.jp)\\.$"
config_bots_check_value["360Spider"] = {"180.153.232.0/24","180.153.234.0/24","180.153.236.0/24","180.163.220.0/24","42.236.101.0/24","42.236.102.0/24","42.236.103.0/24","42.236.10.0/24","42.236.12.0/24","42.236.13.0/24","42.236.14.0/24","42.236.15.0/24","42.236.16.0/24","42.236.17.0/24","42.236.46.0/24","42.236.48.0/24","42.236.49.0/24","42.236.50.0/24","42.236.51.0/24","42.236.52.0/24","42.236.53.0/24","42.236.54.0/24","42.236.55.0/24","42.236.99.0/24"}
config_bots_check_value["Yisouspider"] = "^.*sm\\.cn\\.$"
config_bots_check_value["Sogou web spider"] = "^.*sogou\\.com\\.$"
config_bots_check_value["Sogou wap spider"] = "^.*sogou\\.com\\.$"

-- 提示消息内容
config_bots_check_title = "403 拒绝访问"
cconfig_bots_check_msg = "伪造的搜索引擎蜘蛛"

------------------------------------------------------------------

-- geo数据库地址
geo_path = "/usr/local/nginx/conf/lua/library/Country.mmdb"
-- 是否开启国家黑名单
config_black_country = "off"

-- 禁止访问的国家
config_black_country_value = {}
-- config_black_country_value["CN"] = "中国大陆"
-- config_black_country_value["HK"] = "中国香港"
-- config_black_country_value["TW"] = "中国台湾"
-- config_black_country_value["MO"] = "中国澳门"

-- 是否放行蜘蛛+验证蜘蛛真实性
config_black_country_bots = "off"

-- 提示消息内容
config_black_country_title = "403 拒绝访问"
config_black_country_msg = "当前网站已开启区域访问限制"

------------------------------------------------------------------

-- 是否开启国家白名单
config_white_country = "off"

-- 允许访问的国家(开启国家白名单才有效) GeoLite2 中的 [country][name][en]
config_white_country_value = {}
-- config_white_country_value["CN"] = "中国大陆"
-- config_white_country_value["HK"] = "中国香港"
-- config_white_country_value["TW"] = "中国台湾"
-- config_white_country_value["MO"] = "中国澳门"

-- 是否放行蜘蛛+验证蜘蛛真实性
config_white_country_bots = "off"

-- 提示消息内容
config_white_country_title = "403 拒绝访问"
config_white_country_msg = "当前网站已开启区域访问限制"

------------------------------------------------------------------

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
