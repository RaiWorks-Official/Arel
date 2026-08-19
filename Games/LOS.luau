local VexUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/RaiWorks-Official/Arel/refs/heads/main/UI.lua"))()
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

local Window = VexUI:CreateWindow({
    Name = "Cresent | Legends of Speed",
    Icon = "zap",
    SideBarWidth = 180,
    Theme = "Dark",
    Transparent = true,
    Author = "By PRIMEZ RAI",
    Music_Player = true,
    User = {
        Enabled = true,
        Anonymous = true,
    },
})

local FarmTab = Window:Tab({Title = "Farming", Icon = "zap", Border = true})
local CrystalTab = Window:Tab({Title = "Crystals", Icon = "gem", Border = true})

Window:SelectTab(1)

FarmTab:Toggle({
    Title = "Auto Orb",
    Callback = function(Value)
        Settings.Auto_Orb = Value
    end
})

FarmTab:Toggle({
    Title = "Auto Gem",
    Callback = function(Value)
        Settings.Auto_Gem = Value
    end
})

FarmTab:Toggle({
    Title = "Auto Hoops",
    Callback = function(Value)
        Settings.Auto_Hoops = Value
    end
})

FarmTab:Toggle({
    Title = "Auto Race",
    Callback = function(Value)
        Settings.Auto_Race = Value
    end
})

FarmTab:Toggle({
    Title = "Auto Rebirth",
    Callback = function(Value)
        Settings.Auto_Rebirth = Value
    end
})

CrystalTab:Dropdown({
    Title = "Select Crystal",
    Multi = false,
    Option = {"Red Crystal", "Blue Crystal", "Yellow Crystal", "Lightning Crystal", "Inferno Crystal", "Cyber Crystal"},
    Value = Settings.Selected_Crystal,
    Callback = function(Value)
        Settings.Selected_Crystal = Value
    end
})

CrystalTab:Toggle({
    Title = "Auto Open Crystal",
    Callback = function(Value)
        Settings.Auto_Crystal = Value
    end
})

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
      local CrystalEvent = RE:FindFirstChild("openCrystalRemote")
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
