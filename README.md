# lua-waf 防护
***
### 缘由
> 刚开始知道 lua-waf的时候，是因为公司网站频繁遭到竞争对手的采集  
> 于是知道了ModSecurity、ngx_lua_waf、openstar、OpenWAF 等工具 
> 他们功能太复杂了，我要的功能很简单，于是便有了初始的第一个版本  
> 规则配置很多直接用了lua的table，是因为可以清晰的看到是防护什么的 

### 功能介绍
> config.lua 为配置文件，包含完整的功能介绍和注释  
> 分为三种模式 waf 只防护不记日志录，logs 只记录日志，both 防护+记录日志  
> 维护模式  
> ip黑名单 / ip白名单(黑名单优先级高于白名单)  
> 反向代理验证  
> 域名验证  
> header验证(域名+特定header,我个人用于api调试的)  
> 目录限制  
> user_agent 过滤(爬虫)  
> 蜘蛛白名单 / 验证蜘蛛真实性  
> 国家黑名单 / 国家白名单(黑名单优先级高于白名单)  
> CC防护  

### 版本更新 
> 2020-07-30 更新了域名独立验证(config_domain_extra)   
> ......................................  
> 2020-10-22  
> 修改了逻辑错误和验证规则,更新了GeoLite2数据库  
> 移除config_domain_extra,增加config_domain_header  
> 修改了部分默认配置，增加了过滤日志,增加了目录过滤  
> ......................................  
> 2020-10-25  
> 修改了报错页面，稍微美观一些  
> 添加调试函数，修改header验证的逻辑错误  
> ......................................  
> 2020-11-07  
> 增加了IP段验证  
> 增加了反向代理验证(当获取到的IP地址和remote_addr不同时有效)  
> 蜘蛛ip段校验  
> ......................................  
> 2020-11-11  
> 增加user-agent白名单  
> ......................................  
> 2020-11-16  
> 调整判断顺序
> 修复header验证的逻辑错误   

### 注意事项
> 反向代理验证如果开启，非高匿代理也会被拒绝

### TODO: 
> 简单功能，想要功能全的可以使用其他的开源程序  
> 目前只是浏览，并没有交互功能，大概率不会更新

+ 暂无


### 其他说明  
> 地址数据使用了 GeoLite2 免费数据，请自行更新  
  
### 部署方式  
``` shell
# 基于nginx + lua
# 安装 geoip数据库依赖   编译安装https://github.com/maxmind/libmaxminddb
apt-get install libmaxminddb-dev
git clone https://github.com/aknife2019/ngx-lua-waf.git
mv ngx-lua-waf /usr/local/nginx/conf/
# 编辑nginx.conf  http{}
vi /usr/local/nginx/conf/nginx.conf
```

``` nginx
# 编辑nginx.onf ,搜索 default_type  application/octet-stream; 替换为
default_type  text/html;
charset utf-8;
        
# 载入lua依赖文件
lua_package_path  "/usr/local/nginx/conf/lua/?.lua;/usr/local/nginx/conf/lua/config/?.lua;/usr/local/nginx/conf/lua/library/?.lua;;";
lua_package_cpath  "/usr/local/nginx/conf/lua/library/?.so;;";
# lua验证
init_by_lua_file  '/usr/local/nginx/conf/lua/init.lua';
access_by_lua_file  '/usr/local/nginx/conf/lua/access.lua';
log_by_lua_file  '/usr/local/nginx/conf/lua/logs.lua';
```
