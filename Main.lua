local PlaceId = game.PlaceId
local Repo = "https://raw.githubusercontent.com/YourUser/YourRepo/main/"

local Supported = {
    ["Legends of Speed"] = {
        Id = 3101667897,
        File = "LOS.luau",
    },
}

local PlaceFile = nil

for _, config in pairs(Supported) do
    if config.Id == PlaceId then
        PlaceFile = config.File
        break
    end
end

if PlaceFile then
    loadstring(game:HttpGet(Repo .. PlaceFile))()
else
    error("Game Not Supported! Place ID: " .. tostring(PlaceId))
end
