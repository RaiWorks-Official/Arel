local Library = 
local WS = game:GetService("Workspace")
local RS = game:GetService("ReplicatedStorage")
local PLRS = game:GetService("Pkayers")

local Player = PLRS.LocalPlayer
local Character = Player.Character


local Settings = {
  Auto_Click = false,
  Auto_Drain = false,
  Max_Stage = 0,
  Auto_Rebirth = false,
  Auto_Collect_Fish = false, -- fih :DDD
  Auto_Collect = false,

  Auto_Sell = false
}

task.spawn(function() 
  while Settings.Auto_Click do
    local Level = RS.Remote.Event.Level

    Level:FindFirstChild('[C-S]Click'):FireServer(0)
    Level:FindFirstChild('[C-S]Click'):FireServer(0)
    Level:FindFirstChild('[C-S]Click'):FireServer(0)
    Level:FindFirstChild('[C-S]Click'):FireServer(0)
    
    task.wait(0.1)
  end
end)

task.spawn(function() 
  while Settings. do

    task.wait()
  end
end)

task.spawn(function() 
  while Settings. do

    task.wait()
  end
end)

task.spawn(function() 
  while Settings. do

    task.wait()
  end
end)

task.spawn(function() 
  while Settings. do

    task.wait()
  end
end)

task.spawn(function() 
  while Settings. do

    task.wait()
  end
end)