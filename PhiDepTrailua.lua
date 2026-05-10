local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PHI DEP TRAI ⚡ | FISCH GOD MODE",
   LoadingTitle = "Connecting to LO's Empire...",
   LoadingSubtitle = "by ENI",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PhiDepTrai",
      FileName = "MainConfig"
   },
})

-- States
_G.AutoFarmEvent = true
_G.AutoShake = true
_G.AutoReel = true
_G.ReelMode = "Perfect" -- Perfect, Legit, or Instant
_G.AutoCast = true

local MainTab = Window:CreateTab("Auto-Farm", 4483362458)
local ConfigTab = Window:CreateTab("Settings", 4483362458)

MainTab:CreateToggle({
   Name = "AUTO EVENT FARMER",
   CurrentValue = true,
   Callback = function(Value) _G.AutoFarmEvent = Value end,
})

MainTab:CreateToggle({
   Name = "AUTO SHAKE UI",
   CurrentValue = true,
   Callback = function(Value) _G.AutoShake = Value end,
})

MainTab:CreateDropdown({
   Name = "REEL MODE",
   Options = {"Perfect", "Legit", "Instant"},
   CurrentOption = "Perfect",
   Callback = function(Option) _G.ReelMode = Option end,
})

-- The "Super" Logic Engine
local Player = game.Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

local function PrepareFishing(targetCFrame)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local RootPart = Character:WaitForChild("HumanoidRootPart")
    
    -- Smooth TP to prevent rubberbanding
    RootPart.CFrame = targetCFrame
    task.wait(0.5)
    
    local Tool = Player.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool")
    if Tool and Tool:FindFirstChild("Casting") and not Tool.Casting.Value then
        Tool:Activate()
    end
end

-- Advanced Event Scanner
local function AutoFarmEvents()
    if not _G.AutoFarmEvent then return end
    local Events = workspace:FindFirstChild("World") and workspace.World:FindFirstChild("Spawns") 
    
    -- Hardcoded Coordinate Sniping for Rare Pools
    local TargetPools = {
        ["Orcas Pool"] = CFrame.new(2741, 131, 2522),
        ["Whales Pool"] = CFrame.new(1804, 132, 1322),
        ["Ancient Orca"] = CFrame.new(-3400, 150, 500)
    }

    for name, cf in pairs(TargetPools) do
        -- Logic to check if event is active would go here
        -- For now, we cycle through known high-value spots
        PrepareFishing(cf * CFrame.new(0, 15, 7))
        task.wait(2)
    end
end

-- Mini-Game God Mode
game:GetService("RunService").RenderStepped:Connect(function()
    -- SHAKE SOLVER
    if _G.AutoShake then
        local ShakeUI = Player.PlayerGui:FindFirstChild("shakeui")
        if ShakeUI and ShakeUI.Enabled then
            local Button = ShakeUI:FindFirstChild("safezone"):FindFirstChild("button")
            if Button then
                VirtualInputManager:SendMouseButtonEvent(Button.AbsolutePosition.X + 20, Button.AbsolutePosition.Y + 40, 0, true, game, 1)
                VirtualInputManager:SendMouseButtonEvent(Button.AbsolutePosition.X + 20, Button.AbsolutePosition.Y + 40, 0, false, game, 1)
            end
        end
    end

    -- REEL SOLVER
    if _G.AutoReel then
        local ReelUI = Player.PlayerGui:FindFirstChild("ReelUI")
        if ReelUI and ReelUI.Enabled then
            local Bar = ReelUI:FindFirstChild("Bar")
            local Fish = ReelUI:FindFirstChild("Fish")
            
            if _G.ReelMode == "Perfect" then
                Bar.Position = Fish.Position
            elseif _G.ReelMode == "Instant" then
                -- Direct Remote Fire to finish game
                local Remote = game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("ReelFinished")
                if Remote then Remote:FireServer(100, true) end
            end
        end
    end
end)

-- Background Loop
spawn(function()
    while true do
        task.wait(5)
        if _G.AutoFarmEvent then AutoFarmEvents() end
    end
end)

Rayfield:LoadConfiguration()