
local sock = assert(ngx.req.socket(true))
while true do
    local line, err, part = sock:receive()
    if line then
        ngx.say("received: ",line)
    else
        ngx.say("failed to receive a line: ", err, "[" , part , "]")
        break
    end
end

local ok,err = sock:close()
ngx.say("close:", ok , " ", err)
