-- 白名单蜘蛛,先判断包含 Spider/bot 在判断白名单
config_bots_white_value = "(Baidu|Google|Bing|MSNBot|360|Yisou|Sogou|Yandex|Applebot)"

-- 反查蜘蛛,部分不支持反查
config_bots_check_value = {}
config_bots_check_value["Baidu"] = "^.*(baidu\\.com|baidu\\.jp)\\.$"
config_bots_check_value["Google"] = "^.*(google\\.com|googlebot\\.com)\\.$"
config_bots_check_value["Bing"] = "^.*(search\\.msn\\.com)\\.$"
config_bots_check_value["MSNBot"] = "^.*(search\\.msn\\.com)\\.$"
config_bots_check_value["Yisou"] = "^.*(sm\\.cn)\\.$"
config_bots_check_value["Sogou"] = "^.*(sogou\\.com)\\.$"
config_bots_check_value["Yandex"] = "^.*(yandex\\.ru|yandex\\.net|yandex\\.com)\\.$"
config_bots_check_value["Applebot"] = "^.*applebot\\.apple\\.com\\.$"

-- https://tool.ip138.com/spider/
config_bots_check_ips = {}

-- http://www.so.com/help/spider_ip.html
config_bots_check_ips["360"] = {}
config_bots_check_ips["360"]["180.153.232.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["180.153.234.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["180.153.236.0.24"] = "360蜘蛛"
config_bots_check_ips["360"]["180.163.220.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.101.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.102.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.103.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.10.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.12.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.13.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.14.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.15.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.16.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.17.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.46.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.48.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.49.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.50.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.51.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.52.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.53.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.54.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.55.0/24"] = "360蜘蛛"
config_bots_check_ips["360"]["42.236.99.0/24"] = "360蜘蛛"
