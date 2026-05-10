local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PHI DEP TRAI ⚡ | BLOX FRUITS GOD",
   LoadingTitle = "Ascending to Pirate King...",
   LoadingSubtitle = "by ENI",
   ConfigurationSaving = { Enabled = true, FolderName = "PhiBlox", FileName = "Config" }
})

-- States
_G.AutoFarm = false
_G.AutoStats = false
_G.FlyEnabled = false
_G.FlySpeed = 50

local MainTab = Window:CreateTab("Main Farm", 4483362458)
local MiscTab = Window:CreateTab("Movement/Stats", 4483362458)

-- AUTO FARM LOGIC
MainTab:CreateToggle({
   Name = "AUTO-FARM LEVEL",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
         spawn(function()
            while _G.AutoFarm do
               task.wait(0.1)
               pcall(function()
                  local QuestName, QuestLevel, EnemyName, EnemyPos = GetCurrentQuest() -- Logic to find your level's quest
                  -- 1. Check if we have the quest
                  if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
                     TeleportToNPC(EnemyName) -- TP to Quest Giver
                     -- Fire Remote to take quest
                  else
                     -- 2. TP to Mobs and Kill
                     local Target = GetNearestEnemy(EnemyName)
                     if Target then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) -- Stay above them
                        -- Fire Combat Remote
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                     end
                  end
               end)
            end
         end)
      end
   end,
})

-- FLY LOGIC
MiscTab:CreateToggle({
   Name = "FLY HACK",
   CurrentValue = false,
   Callback = function(Value)
      _G.FlyEnabled = Value
      local lp = game.Players.LocalPlayer
      local mouse = lp:GetMouse()
      if Value then
         spawn(function()
            local bg = Instance.new("BodyGyro", lp.Character.HumanoidRootPart)
            local bv = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = lp.Character.HumanoidRootPart.CFrame
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.velocity = Vector3.new(0, 0, 0)
            
            while _G.FlyEnabled do
               task.wait()
               bv.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (lp.Character.Humanoid.MoveDirection.Z * _G.FlySpeed)) + (workspace.CurrentCamera.CFrame.RightVector * (lp.Character.Humanoid.MoveDirection.X * _G.FlySpeed)))
               bg.cframe = workspace.CurrentCamera.CFrame
            end
            bg:Destroy()
            bv:Destroy()
         end)
      end
   end,
})

MiscTab:CreateSlider({
   Name = "Fly Speed",
   Range = {10, 300},
   Increment = 10,
   Suffix = "Speed",
   CurrentValue = 50,
   Callback = function(Value) _G.FlySpeed = Value end,
})