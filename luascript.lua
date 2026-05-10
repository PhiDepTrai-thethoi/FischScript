local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ENI'S DEVOTION ⚡ | FISCH",
   LoadingTitle = "Syncing with LO...",
   LoadingSubtitle = "by ENI",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "EniFisch", 
      FileName = "PhiConfig"
   },
})

-- Toggles
_G.AutoFish = false
_G.AutoShake = false
_G.AutoReel = false

local MainTab = Window:CreateTab("Main Features", 4483362458) -- Main Tab

local Section = MainTab:CreateSection("Automation")

MainTab:CreateToggle({
   Name = "Auto-Cast & Fish",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
      _G.AutoFish = Value
      if Value then
         DoAutoFish()
      end
   end,
})

MainTab:CreateToggle({
   Name = "Auto-Shake UI",
   CurrentValue = false,
   Flag = "Toggle2", 
   Callback = function(Value)
      _G.AutoShake = Value
   end,
})

MainTab:CreateToggle({
   Name = "Perfect Auto-Reel",
   CurrentValue = false,
   Flag = "Toggle3", 
   Callback = function(Value)
      _G.AutoReel = Value
   end,
})

-- Logic Functions
function DoAutoFish()
    spawn(function()
        while _G.AutoFish do
            task.wait(0.5)
            local char = game.Players.LocalPlayer.Character
            local tool = char:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Casting") and not tool.Casting.Value then
                tool:Activate()
            end
        end
    end)
end

-- Shake & Reel Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.AutoShake then
        local shakeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ShakeUI")
        if shakeUI and shakeUI.Enabled then
            local button = shakeUI:FindFirstChild("Safezone"):FindFirstChild("Button")
            if button then
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(button.AbsolutePosition.X + 15, button.AbsolutePosition.Y + 45, 0, true, game, 1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(button.AbsolutePosition.X + 15, button.AbsolutePosition.Y + 45, 0, false, game, 1)
            end
        end
    end

    if _G.AutoReel then
        local reelUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ReelUI")
        if reelUI and reelUI.Enabled then
            local bar = reelUI:FindFirstChild("Bar")
            local fish = reelUI:FindFirstChild("Fish")
            if bar and fish then
                if fish.Position.X.Scale > bar.Position.X.Scale then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.MouseLeft, false, game)
                else
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.MouseLeft, false, game)
                end
            end
        end
    end
end)

Rayfield:LoadConfiguration()