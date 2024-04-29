# lua-waf 防护

### 非常简易的ngx+lua防护方案，复杂功能推荐配合 ModSecurity 使用

### 功能介绍
> config.lua 为配置文件，包含完整的功能介绍和注释  
> 分为两种模式 waf 防护+日志，logs 只记录日志  
>  
> 维护模式  
> 域名验证  
> ip黑名单  
> ip白名单  
> userAgent过滤  
> 蜘蛛白名单+蜘蛛真实性验证  
> 国家黑名单  
> 国家白名单  
> CC防护  

### 更新说明
> 2024-04-28  
> 更新GeoLite2库:MaxMind Country + ipipnet + chunzhen + clang整理后的数据库,仅保留国家代码[code=>CN]数据   
> 移除没必要的功能  
> 修改部分逻辑  


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
lua_package_path  "/usr/local/nginx/conf/lua/?.lua;/usr/local/nginx/conf/lua/library/?.lua;;";
lua_package_cpath  "/usr/local/nginx/conf/lua/library/?.so;;";
# lua验证
init_by_lua_file  '/usr/local/nginx/conf/lua/init.lua';
access_by_lua_file  '/usr/local/nginx/conf/lua/access.lua';
log_by_lua_file  '/usr/local/nginx/conf/lua/logs.lua';
```
