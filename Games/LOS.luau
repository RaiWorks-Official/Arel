-- local library = loadstring("https://github.com/RaiWorks-Official/Arel/UI.lua")()
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
  Auto_Rebirth = false,
  Auto_Crystal = false,
  Selected_Crystal = "Red Crystal",
}

task.spawn(function() 
  while task.wait(0.1) do
    if Settings.Auto_Orb then
      local OrbEvent = RE:FindFirstChild("orbEvent")
      if OrbEvent then
        OrbEvent:FireServer("collectOrb", "Red Orb", "City")
        OrbEvent:FireServer("collectOrb", "Red Orb", "City")
        OrbEvent:FireServer("collectOrb", "Blue Orb", "City")
        OrbEvent:FireServer("collectOrb", "Blue Orb", "City")
        OrbEvent:FireServer("collectOrb", "Red Orb", "Desert")
        OrbEvent:FireServer("collectOrb", "Red Orb", "Desert")
        OrbEvent:FireServer("collectOrb", "Blue Orb", "Desert")
        OrbEvent:FireServer("collectOrb", "Blue Orb", "Desert")
        OrbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        OrbEvent:FireServer("collectOrb", "Red Orb", "Magma City")
        OrbEvent:FireServer("collectOrb", "Blue Orb", "Magma City")
        OrbEvent:FireServer("collectOrb", "Blue Orb", "Magma City")
      end
    end
  end
end)

task.spawn(function() 
  while task.wait(0.1) do
    if Settings.Auto_Gem then
      local OrbEvent = RE:FindFirstChild("orbEvent")
      if OrbEvent then
        OrbEvent:FireServer("collectOrb", "Gem", "City")
        OrbEvent:FireServer("collectOrb", "Gem", "City")
        OrbEvent:FireServer("collectOrb", "Gem", "City")
        OrbEvent:FireServer("collectOrb", "Gem", "City")
        OrbEvent:FireServer("collectOrb", "Gem", "Desert")
        OrbEvent:FireServer("collectOrb", "Gem", "Desert")
        OrbEvent:FireServer("collectOrb", "Gem", "Desert")
        OrbEvent:FireServer("collectOrb", "Gem", "Desert")
        OrbEvent:FireServer("collectOrb", "Gem", "Magma City")
        OrbEvent:FireServer("collectOrb", "Gem", "Magma City")
        OrbEvent:FireServer("collectOrb", "Gem", "Magma City")
        OrbEvent:FireServer("collectOrb", "Gem", "Magma City")
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if Settings.Auto_Hoops then
      local char = Player.Character or Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if hoops and hrp then
        for _, v in ipairs(hoops:GetChildren()) do
          if v:IsA("BasePart") and v:FindFirstChild("TouchInterest") and firetouchinterest then
            firetouchinterest(hrp, v, 0)
            firetouchinterest(hrp, v, 1)
          end
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if Settings.Auto_Race then
      local RaceEvent = RE:FindFirstChild("raceEvent")
      if RaceEvent then
        RaceEvent:FireServer("joinRace")
      end
    end
  end
end)

task.spawn(function() 
  while task.wait(0.1) do
    if Settings.Auto_Rebirth then
      local RebirthEvent = RE:FindFirstChild("rebirthEvent")
      if RebirthEvent then
        RebirthEvent:FireServer("rebirthRequest")
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if Settings.Auto_Crystal and Settings.Selected_Crystal ~= "" then
      local CrystalEvent = RE:FindFirstChild("openCrystal")
      if CrystalEvent then
        if CrystalEvent:IsA("RemoteFunction") then
          CrystalEvent:InvokeServer("openCrystal", Settings.Selected_Crystal)
        elseif CrystalEvent:IsA("RemoteEvent") then
          CrystalEvent:FireServer("openCrystal", Settings.Selected_Crystal)
        end
      end
    end
  end
end)
