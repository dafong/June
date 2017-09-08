#June

A game server based openresty

#Install


###install nginx & lua-nginx & stream-lua-nginx
nginx            1.13.11
lua-nginx        0.10.10
stream-lua-nginx latest
'''
#!/bin/sh
export LUAJIT_LIB=/usr/local/opt/luajit/lib
export LUAJIT_INC=/usr/local/opt/luajit/include/luajit-2.1

./configure --prefix=/usr/local/openresty \
        --with-stream  \
        --add-module=/Users/xinlei.fan/Documents/resty_modules/stream-lua-nginx-module \
        --add-module=/Users/xinlei.fan/Documents/resty_modules/lua-nginx-module-0.10.10 \
        --with-ld-opt="-Wl,-rpath,/usr/local/opt/luajit/lib"
'''
###install cjson
'''
make install LUA_INCLUDE_DIR=/usr/local/include/luajit-2.1 LUA_CMODULE_DIR=/usr/local/openresty/lualib LUA_MODULE_DIR=/usr/local/openresty/lualib CJSON_CFLAGS="-g -fpic" CJSON_LDFLAGS='-bundle -undefined dynamic_lookup'
'''
