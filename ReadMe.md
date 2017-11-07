June
====

Another simple lua web framework based openresty

Table of Contents
=================
* [Require](#require)
* [Get Start](#get-start)
* [Description](#description)


Require
=======

1. nginx            1.13.11
2. lua-nginx        0.10.10
3. cjson


Get start
=========


Description
==========
June offer a simple framework to help you build up http service rapidly.

The architecture is simple and scalable, you can easyly extend it by you need.

The core concept of june is module, a module is a lua block to offer service for per request. In lua ,as you know you can require any lua file as "lua module" to call
some function in any where, all of the module point to one instance in fact , but in Openresty ,things be a littler different. cause we want to the module's life-cycle bind to a request, if we require the lua file , they will point to one instance(per Openresty work process), that's not we want.

June's module offer mechanism to create a new module instance for each request/response.
* [module's life-cycle](#module's-life-cycle)
* [june offered modules](#june-offered-modules)
    * [router](#router)
    * [filter](#filter)
    * [cookie](#cookie)
* [how to create a module](#how-to-create-a-module)

Module's life cycle
===================
A module's life is binding to a request,every request has a module's instance,it's used to offer some feature for every single request,the feature looks like router , filter,cookie or session, it's not like the lua require,because lua's require will refrence same instance when different request was handled by same nginx child process,in that case mutiple request will share data, which make thins worse when we want to implement feature like cookie or session or any other feature which data should bind to a single request.

June offered modules
=======

June handle the request by several internal module. they will load by default, also you can disable all of all,and
June will do nothing but without any error.

Router
======

Route module offered feature url mapping.

Filter
======

Filter module offered feature as like a "filter chain" to process request and response.It works like below:

(request,response)->[fiter A [fiter B [...and so on] ] ]



Cookie
======

Cookie module actually is a resty.cookie's wrapper

How to create a module
======================
You can refer to the cookie module,it's very simple,source code below:

```lua
local M={}
local utils  = require"utils"
local cookie = require"resty.cookie"
function M:process(req,resp)
    local c = cookie:new()
    req:reg_module(self.name,c)
    resp:reg_module(self.name,c)
end

setmetatable( M , { __call = function(t,name,conf)
    local ins = {name=name}
    setmetatable(ins,{ __index = M })
    return ins
end})

return M

```

You have noticed a module has a metatable which change the __call function to create a module's instance,the para name will be the name you passed in config where you enable the module . the para conf is the config table,you can parse the config here.A module also must have a function like "process(request,response)"  june will call this function when a new request was comming,this function can return nothing and also can return a new function here we call it a module handler, when all module's process was called, the handler they returned will be traverse in turn with the parameter request and response.



TODO
====
the controller's dir
