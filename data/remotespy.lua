local function GetDescendants(parent) -- from louknt's backporting utility pack
    local descendants = {}
    local function rec(inst)
        for _, child in ipairs(inst:GetChildren()) do
            table.insert(descendants, child)
            rec(child)
        end
    end
    rec(parent)
    return descendants
end

warn('Rocky2u+ RemotePrinter')
warn('Made by Java')

for _, v in pairs(GetDescendants(workspace)) do
    if v:IsA("RemoteEvent") then
        print("[R2RP] Found RemoteEvent:", v:GetFullName())
    end
end

for _, v in pairs(GetDescendants(workspace)) do
    if v:IsA("RemoteFunction") then
        print("[R2RP] Found RemoteFunction:", v:GetFullName())
    end
end
