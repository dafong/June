return function(req,resp)
    if req.handler_func == nil or req.handler == nil or type(req.handler_func) ~= "function" then
        error("june default filter can't find a mapping_func of uri of "..req.path)
    end
    req.handler_func(req.handler,req,resp)
end
