-- loader
-- local Players = game:GetService("Players")
local Id = game.PlaceId

local Supported = {
  ["Legends of Speed"] = {
    Id = ,
    File = "LOS.luau",
  },
}

for i, v in ipairs(Supported) do
  if Id == v.Id then
    loadstring()()
  else
    error("Not Supported")
  end
end