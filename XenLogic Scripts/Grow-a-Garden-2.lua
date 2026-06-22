local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- ═══ SERVICES ═══
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Net = require(ReplicatedStorage.SharedModules.Networking)
local remote = ReplicatedStorage.SharedModules.Packet.RemoteEvent

local Window = WindUI:CreateWindow({ Title = "Grow A Garden 2 | XenLogic", Icon = "lucide:leaf", Resizable = true })

-- ═══ TABS ═══
local MenuTab = Window:Tab({ Title = "Menu" })
local FarmTab = Window:Tab({ Title = "Farm" })
local ShopTab = Window:Tab({ Title = "Shop" })
local PlayerTab = Window:Tab({ Title = "Player" })
local VisualTab = Window:Tab({ Title = "Visuals" })

-- ═══ VARIABLES ═══
local S = { water=false, harvest=false, sell=false, autoBuy=false }
local selectedSeeds = {}
local dWater, dHarvest, dBuy, dSell = 0.1, 0.1, 0.1, 1

-- ═══ MENU ═══
MenuTab:Paragraph({ Title = "Version", Desc = "v1" })
MenuTab:Button({ Title = "Copy Discord Link", Callback = function() setclipboard("https://discord.gg/rp3uxwHmN") end })

-- ═══ FARM ═══
FarmTab:Toggle({ Title = "Auto Water", Callback = function(v) S.water = v end })
FarmTab:Slider({ Title = "Water Delay (s)", Value = { Min = 0.1, Max = 10, Default = 0.1, Increment = 0.1 }, Callback = function(v) dWater = v end })
FarmTab:Toggle({ Title = "Auto Harvest", Callback = function(v) S.harvest = v end })
FarmTab:Slider({ Title = "Harvest Delay (s)", Value = { Min = 0.1, Max = 10, Default = 0.1, Increment = 0.1 }, Callback = function(v) dHarvest = v end })

-- ═══ SHOP ═══
local SeedList = {"Carrot", "Strawberry", "Blueberry", "Tulip", "Tomato", "Apple", "Bamboo", "Corn", "Cactus", "Pineapple"}
ShopTab:Dropdown({ Title = "Select Seeds", Values = SeedList, Multi = true, Callback = function(v) selectedSeeds = v end })
ShopTab:Toggle({ Title = "Auto Buy", Callback = function(v) S.autoBuy = v end })
ShopTab:Slider({ Title = "Buy Delay (s)", Value = { Min = 0.1, Max = 10, Default = 0.1, Increment = 0.1 }, Callback = function(v) dBuy = v end })
ShopTab:Toggle({ Title = "Auto Sell", Callback = function(v) S.sell = v end })
ShopTab:Slider({ Title = "Sell Delay (s)", Value = { Min = 1, Max = 10, Default = 1, Increment = 1 }, Callback = function(v) dSell = v end })

-- ═══ PLAYER ═══
PlayerTab:Slider({ Title = "WalkSpeed", Value = { Min = 16, Max = 100, Default = 16, Increment = 1 }, Callback = function(v) LP.Character.Humanoid.WalkSpeed = v end })
PlayerTab:Toggle({ Title = "Noclip", Callback = function(v) _G.nc = v end })

-- ═══ VISUALS ═══
VisualTab:Toggle({ Title = "Highlight Plants", Callback = function(v) _G.hPlants = v end })
VisualTab:Toggle({ Title = "Highlight Players", Callback = function(v) _G.hPlayers = v end })

-- ═══ LOOPS ═══
task.spawn(function()
    while true do
        if S.water then
            local id = LP:GetAttribute("PlotId")
            if id then local pl = workspace.Gardens:FindFirstChild("Plot"..id)
                if pl then for _,p in pl:GetDescendants() do if p:IsA("BasePart") and CollectionService:HasTag(p,"PlantArea") then Net.WateringCan.UseWateringCan:Fire(p.Position, 1, nil) end end end
            end
            task.wait(dWater)
        end
        if S.harvest then
            for _,o in workspace:GetDescendants() do if o:IsA("ProximityPrompt") and (o.Name=="HarvestPrompt" or o.Name=="CollectPrompt") then fireproximityprompt(o) end end
            task.wait(dHarvest)
        end
        if S.autoBuy then
            for _,name in pairs(selectedSeeds) do 
                remote:FireServer(buffer.fromstring("x\0" .. string.char(#name) .. name)) 
                task.wait(dBuy) 
            end
        end
        if S.sell then
            -- Sell Logic (GAG2 v3 Protocol)
            remote:FireServer(buffer.fromstring("\172\0\22"))
            remote:FireServer(buffer.fromstring("\170\0\25"))
            remote:FireServer(buffer.fromstring("\171\0\23"))
            task.wait(dSell)
        end
        
        -- Highlights
        for _,p in pairs(workspace:GetDescendants()) do
            if _G.hPlants and p:IsA("BasePart") and CollectionService:HasTag(p,"PlantArea") then
                if not p:FindFirstChild("Highlight") then local h = Instance.new("Highlight", p) h.FillColor = Color3.fromRGB(0,255,0) end
            elseif not _G.hPlants and p:FindFirstChild("Highlight") and p.Name == "Highlight" then p:Destroy() end
        end
        task.wait(0.05)
    end
end)