local function split(str,sp)
    if sp == nil or sp=="" then return {str} end
    if str == nil then return {} end
    local t = {}
    for m in ngx.re.gmatch(str,"[^"..sp.."]+") do
        table.insert(t,m[0])
    end
    return t
end
string.split = split
