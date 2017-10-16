local function split(str,sp)
    if sp == nil or sp=="" then return {str} end
    if str == nil then return {} end
    local t = {}
    for m in ngx.re.gmatch(str,"[^"..sp.."]+") do
        table.insert(t,m[0])
    end
    return t
end

local function start_with(str,sp)
    if sp == nil or sp=="" then return false end
    if str == nil then return false end
    return ngx.re.match(str,"^"..sp) ~= nil
end

string.split = split
string.start_with = start_with
