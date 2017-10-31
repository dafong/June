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
* [module's life-cycle](#module's-life-cycke)
* [june offered modules](#june-offered-modules)
    * [router](#router)
    * [filter](#filter)
    * [cookie](#cookie)
* [how to create a module](#how-to-create-a-module)



June offered modules
=======

Router
======

Filter
======

Cookie
======


How to create a module
======================
You can refer to the cookie module,it's very simple.

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
TODO
====
the controller's dir and the template's root path setting
