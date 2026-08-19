local library = loadstring("https://github.com/RaiWorks-Official/Arel/UI.lua")()
local hoops = workspace:FindFirstChild("Hoops")

local Players = game.Players
local Player = Players.LocalPlayer
local Character = Player.Character

local RS = game.ReplicatedStorage
local RE = RS:FindFirstChild("rEvents")

local Settings = {
  Auto_Orb = false,
  Auto_Gem = false,
  Auto_Hoops = false,
  Auto_Race = false, -- Werent Able to find another method
}

task.spawn(function()
  while Settings.Auto_Hoops do
    if hoops and Character and Character:FindFirstChild("HumanoidRootPart") then
      local hrp = Character:FindFirstChild("HumanoidRootPart")
      for _, v in ipairs(hoops:GetChildren()) do
        if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") and firetouchinterest then
          firetouchinterest(hrp, v, 0)
          firetouchinterest(hrp, v, 1)
        end
      end
    end
    task.spawn(0.1)
  end
end)

task.spawn(function()
  while Settings.Auto_Race do
    local RaceEvent = RE:FindFirstChild("raceEvent")
    if RaceEvent then
      RaceEvent:FireServer("joinRace")
    end
    task.spawn(0.1)
  end
end)