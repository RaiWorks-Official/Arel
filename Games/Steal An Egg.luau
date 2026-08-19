-- Safety first :b
local old_index
old_index = hookmetamethod(game, "__index", function(self, key)
    if not checkcaller() and self:IsA("Humanoid") and (key == "WalkSpeed" or key == "walkSpeed") then
        return 16
    end
    return old_index(self, key)
end)
local old_newindex
old_newindex = hookmetamethod(game, "__newindex", function(self, key, value)
    if not checkcaller() and self:IsA("Humanoid") and (key == "WalkSpeed" or key == "walkSpeed") then
        return
    end
    return old_newindex(self, key, value)
end)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RaiWorks-Official/Arel/refs/heads/main/UI.lua"))()

local Settings = {
  Insta_Steal = false,
}