for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        print("Found RemoteEvent:", v:GetFullName())
    end
end

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("RemoteFunction") then
        print("Found RemoteFunction:", v:GetFullName())
    end
end
