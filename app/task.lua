local M={}

function M:handler()
    -- print("wid="..wid)
    -- local httpc  = http.new()
    -- local res,err = httpc:request_uri("http://192.168.8.183/system/info",{
    --     method = "GET"
    -- })
    -- if not res then
    --     print("failed to request: ", err)
    -- else
    --     print(res.body)
    -- end
    print("call me~!")
    -- ngx.timer.at(3,M.handler)
end
M:handler()
return M
