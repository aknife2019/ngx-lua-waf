-- 白名单蜘蛛,先判断包含 Spider/bot 在判断白名单
config_bots_white_value = "(Baidu|Google|Bing|MSNBot|360|Yisou|Sogou|Yandex|Applebot|PetalBot)"

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
config_bots_check_value["PetalBot"] = "^.*petalsearch\\.com\\.$"
