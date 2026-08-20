local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RaiWorks-Official/Arel/refs/heads/main/UI.lua"))()

local Players = game.Players
local Player = Players.LocalPlayer
local Character = Player.Character

local WS = workspace
local RS = game.ReplicatedStorage
local Run_Service = game:GetService("RunService")
local Camera = WS.CurrentCamera

local Settings = {
  Auto_Click = false,
  Auto_Drain = false,
  Max_Stage = 0,
  Auto_Rebirth = false,
  Auto_Collect_Fish = false,
  Auto_Collect = false,
  Auto_Sell = false,
  ESP_Pets = false,
  Selected_Pump = "1",
}

local Current_Stage = 1
local ESP_Cache = {}

local Window = Library:CreateWindow({
    Name = "Cresent | +1 Drain Water",
    Icon = "droplet",
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

local Farm_Tab = Window:Tab({Title = "Farming", Icon = "zap", Border = true})
local Shop_Tab = Window:Tab({Title = "Shop", Icon = "shopping-cart", Border = true})
local ESP_Tab = Window:Tab({Title = "Visuals", Icon = "eye", Border = true})

Window:SelectTab(1)

Farm_Tab:Toggle({
    Title = "Auto Click",
    Callback = function(Value)
        Settings.Auto_Click = Value
    end
})

Farm_Tab:Toggle({
    Title = "Auto Drain",
    Callback = function(Value)
        Settings.Auto_Drain = Value
        if Value then
          Current_Stage = 1
        end
    end
})

Farm_Tab:Input({
    Title = "Max Stage (1-15)",
    Value = tostring(Settings.Max_Stage),
    Callback = function(Value)
        Settings.Max_Stage = tonumber(Value) or Settings.Max_Stage
    end
})

Farm_Tab:Toggle({
    Title = "Auto Collect Fish",
    Callback = function(Value)
        Settings.Auto_Collect_Fish = Value
    end
})

Farm_Tab:Toggle({
    Title = "Auto Collect Cash",
    Callback = function(Value)
        Settings.Auto_Collect = Value
    end
})

Farm_Tab:Toggle({
    Title = "Auto Rebirth",
    Callback = function(Value)
        Settings.Auto_Rebirth = Value
    end
})

Shop_Tab:Toggle({
    Title = "Auto Sell",
    Callback = function(Value)
        Settings.Auto_Sell = Value
    end
})

Shop_Tab:Dropdown({
    Title = "Select Pump",
    Multi = false,
    Option = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"},
    Value = Settings.Selected_Pump,
    Callback = function(Value)
        Settings.Selected_Pump = Value
    end
})

Shop_Tab:Button({
    Title = "Buy Pump",
    Callback = function()
        pcall(function()
            local Pump_Remote = RS:FindFirstChild("Remote") and RS.Remote:FindFirstChild("Event") and RS.Remote.Event:FindFirstChild("Pump") and RS.Remote.Event.Pump:FindFirstChild("[C-S]BuyCashPump")
            if Pump_Remote then
                Pump_Remote:FireServer(tonumber(Settings.Selected_Pump) or 1)
            end
        end)
    end
})

ESP_Tab:Toggle({
    Title = "Pet ESP",
    Callback = function(Value)
        Settings.ESP_Pets = Value
    end
})

task.spawn(function() 
  while task.wait(0.1) do
    if Settings.Auto_Click then
      local Level = RS:FindFirstChild("Remote") and RS.Remote:FindFirstChild("Event") and RS.Remote.Event:FindFirstChild("Level")
      if Level then
        local Click = Level:FindFirstChild("[C-S]Click")
        if Click then
          Click:FireServer(0)
          Click:FireServer(0)
          Click:FireServer(0)
          Click:FireServer(0)
        end
      end
    end
  end
end)

task.spawn(function() 
  while task.wait(0.2) do
    if Settings.Auto_Rebirth then
      pcall(function()
        if Player.PlayerGui.HUD.Main.Left.Rebirth.GuideFingerIcon.Visible then
          RS.Remote.Event.Rebirth:FindFirstChild("[C - S]TryRebirth"):FireServer()
        end
      end)
    end
  end
end)

task.spawn(function() 
  while task.wait(1) do
    if Settings.Auto_Collect then
      pcall(function()
        local Char = Player.Character or Character
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
        local Plot_Id = Player:GetAttribute("FishShowPlotId")
        if HRP and Plot_Id and WS:FindFirstChild(tostring(Plot_Id)) then
          local Area = WS[tostring(Plot_Id)]:FindFirstChild("玩家区域") or WS[tostring(Plot_Id)]:FindFirstChild("\xe7\x8e\xa9\xe5\xae\xb6\xe5\x8c\xba\xe5\x9f\x9f")
          local Btn = Area and (Area:FindFirstChild("收集按钮") or Area:FindFirstChild("\xe6\x94\xb6\xe9\x9b\x86\xe6\x8c\x89\xe9\x92\xae"))
          local Touch = Btn and Btn:FindFirstChild("Touch")
          if Touch then
            firetouchinterest(HRP, Touch, 0)
            task.wait()
            firetouchinterest(HRP, Touch, 1)
          end
        end
      end)
    end
  end
end)

task.spawn(function() 
  while task.wait(0.1) do
    if Settings.Auto_Drain then
      pcall(function()
        local Char = Player.Character or Character
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
        local Scene = WS:FindFirstChild("主场景") or WS:FindFirstChild("\xe4\xb8\xbb\xe5\x9c\xba\xe6\x99\xaf")
        local Verify = Scene and (Scene:FindFirstChild("验证场景") or Scene:FindFirstChild("\xe9\xaa\x8c\xe8\xaf\x81\xe5\x9c\xba\xe6\x99\xaf"))
        
        if HRP and Verify then
          if Current_Stage > tonumber(Settings.Max_Stage) then
            Current_Stage = 1
          end

          for _, V in pairs(Verify:GetChildren()) do
            if V.Name:match("(%d+)$") == tostring(Current_Stage) then
              local Water = V:FindFirstChild("水面") or V:FindFirstChild("\xe6\xb0\xb4\xe9\x9d\xa2")
              if Water and Water.CanCollide == true then
                HRP.CFrame = Water.CFrame * CFrame.new(0, 5, 0)
              else
                if Current_Stage < tonumber(Settings.Max_Stage) then
                  Current_Stage = Current_Stage + 1
                else
                  RS.Remote.Event.Level:FindFirstChild("[C-S]GoShow"):FireServer()
                  Current_Stage = 1
                end
              end
              break
            end
          end
        end
      end)
    else
      Current_Stage = 1
    end
  end
end)

task.spawn(function() 
  while task.wait(0.3) do
    if Settings.Auto_Collect_Fish then
      pcall(function()
        local Char = Player.Character or Character
        local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
        local Scene = WS:FindFirstChild("主场景") or WS:FindFirstChild("\xe4\xb8\xbb\xe5\x9c\xba\xe6\x99\xaf")
        local Verify = Scene and (Scene:FindFirstChild("验证场景") or Scene:FindFirstChild("\xe9\xaa\x8c\xe8\xaf\x81\xe5\x9c\xba\xe6\x99\xaf"))
        local Fish_Folder = (Verify and Verify:FindFirstChild("WorldFish")) or WS:FindFirstChild("WorldFish")

        if HRP and Fish_Folder then
          for _, V in pairs(Fish_Folder:GetDescendants()) do
            if not Settings.Auto_Collect_Fish then break end
            if V:IsA("ProximityPrompt") and V.Name == "PickupPrompt" then
              local Root = V.Parent
              local Fish = Root and Root.Parent
              if Root and Fish then
                local Stage_Id = Fish:GetAttribute("StageId")
                if not Stage_Id or tonumber(Stage_Id) <= tonumber(Settings.Max_Stage) then
                  HRP.CFrame = Root.CFrame
                  task.wait(0.15)
                  fireproximityprompt(V)
                  task.wait(0.2)
                end
              end
            end
          end
        end
      end)
    end
  end
end)

task.spawn(function() 
  while task.wait(1) do
    if Settings.Auto_Sell then
      pcall(function()
        RS.Remote.Function.Fish:FindFirstChild("[C-S]SellAllFish"):InvokeServer("OFF", false)
      end)
    end
  end
end)

local function Clear_ESP()
  for Model, Drawing_Obj in pairs(ESP_Cache) do
    if Drawing_Obj then
      Drawing_Obj.Visible = false
      Drawing_Obj:Remove()
    end
  end
  table.clear(ESP_Cache)
end

Run_Service.RenderStepped:Connect(function()
  if not Settings.ESP_Pets then
    if next(ESP_Cache) then
      Clear_ESP()
    end
    return
  end

  local Scene = WS:FindFirstChild("主场景") or WS:FindFirstChild("\xe4\xb8\xbb\xe5\x9c\xba\xe6\x99\xaf")
  local Verify = Scene and (Scene:FindFirstChild("验证场景") or Scene:FindFirstChild("\xe9\xaa\x8c\xe8\xaf\x81\xe5\x9c\xba\xe6\x99\xaf"))
  local Fish_Folder = (Verify and Verify:FindFirstChild("WorldFish")) or WS:FindFirstChild("WorldFish")

  local Found_Pets = {}

  if Fish_Folder then
    for _, V in pairs(Fish_Folder:GetChildren()) do
      if V:IsA("Model") then
        local Root = V:FindFirstChild("FishRoot", true) or V.PrimaryPart or V:FindFirstChildWhichIsA("BasePart", true)
        if Root then
          Found_Pets[V] = Root
        end
      end
    end
  end

  for Model, Root in pairs(Found_Pets) do
    local Vector, On_Screen = Camera:WorldToViewportPoint(Root.Position)

    if On_Screen then
      if not ESP_Cache[Model] then
        local Text_Obj = Drawing.new("Text")
        Text_Obj.Size = 13
        Text_Obj.Center = true
        Text_Obj.Outline = true
        Text_Obj.OutlineColor = Color3.fromRGB(0, 0, 0)
        Text_Obj.Color = Color3.fromRGB(0, 255, 150)
        ESP_Cache[Model] = Text_Obj
      end

      local Dist = math.floor((Root.Position - Camera.CFrame.Position).Magnitude)
      ESP_Cache[Model].Position = Vector2.new(Vector.X, Vector.Y)
      ESP_Cache[Model].Text = Model.Name .. " [" .. tostring(Dist) .. "m]"
      ESP_Cache[Model].Visible = true
    else
      if ESP_Cache[Model] then
        ESP_Cache[Model].Visible = false
      end
    end
  end

  for Model, Drawing_Obj in pairs(ESP_Cache) do
    if not Found_Pets[Model] or not Model:IsDescendantOf(WS) then
      Drawing_Obj.Visible = false
      Drawing_Obj:Remove()
      ESP_Cache[Model] = nil
    end
  end
end)
