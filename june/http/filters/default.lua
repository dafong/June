return function(req,resp)
    if req.router == nil then return end
    if req.router.handler_func == nil or req.router.handler == nil or type(req.router.handler_func) ~= "function" then
        error("june default filter can't find a mapping_func of uri of "..req.path)
    end
    req.router.handler_func(req.router.handler,req,resp)
end
