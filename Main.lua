local PlaceId = game.PlaceId
local Repo = "https://raw.githubusercontent.com/RaiWorks-Official/Arel/main/Games/"

local Supported = {
    ["Legends of Speed"] = {
        Id = 3101667897,
        File = "LOS.luau",
    },
    ["+1 Drain Water per Click"] = {
        Id = 103883942725157,
        File = "DWPC.luau",
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
