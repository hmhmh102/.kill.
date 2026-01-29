--// SCP Muscle Legends Script
--// Clean version

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/memejames/elerium-v2-ui-library/main/Library",
    true
))()

local Window = Library:AddWindow("SCP", {
    main_color = Color3.fromRGB(255,255,255),
    min_size = Vector2.new(650, 320),
    can_resize = false
})

local Main = Window:AddTab("Main")
local Farm = Window:AddTab("Farm")
local Kill = Window:AddTab("Kill")

Main:Show()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

--// Auto Strength
local AutoStrength = false
Farm:AddSwitch("Auto Strength", function(v)
    AutoStrength = v
    task.spawn(function()
        while AutoStrength do
            pcall(function()
                for i = 1, 10 do
                    LocalPlayer.muscleEvent:FireServer("rep")
                end
            end)
            task.wait(0.001)
        end
    end)
end)

--// Auto Rebirth
local AutoRebirth = false
Farm:AddSwitch("Auto Rebirth", function(v)
    AutoRebirth = v
    task.spawn(function()
        while AutoRebirth do
            pcall(function()
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end)
            task.wait(1)
        end
    end)
end)

--// FPS Boost
Main:AddButton("FPS Boost", function()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
            v:Destroy()
        end
    end
    game:GetService("Lighting").GlobalShadows = false
end)

--// Fast Punch
local FastPunch = false
Kill:AddSwitch("Fast Punch", function(v)
    FastPunch = v
    local tool = LocalPlayer.Backpack:FindFirstChild("Punch") or 
                 (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Punch"))
    if tool and tool:FindFirstChild("attackTime") then
        tool.attackTime.Value = v and 0 or 0.35
    end
end)

--// Auto Kill (Simple)
local AutoKill = false
Kill:AddSwitch("Auto Kill", function(v)
    AutoKill = v
    task.spawn(function()
        while AutoKill do
            pcall(function()
                LocalPlayer.muscleEvent:FireServer("punch","leftHand")
                LocalPlayer.muscleEvent:FireServer("punch","rightHand")
            end)
            task.wait(0.05)
        end
    end)
end)

print("✅ SCP Loaded Successfully")