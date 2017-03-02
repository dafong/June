local M={}
function M:merge(...)
    local t = {}
    for _,o in ipairs({...}) do
        for k,v in pairs(o) do
            if type(v)~="table" do
                t[k] = v
            else
                t[k]=self:merge(t[k],v)
            end
        end
    end

end
return M
