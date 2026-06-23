@ -1,86 +1,88 @@
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- Tabla de semillas
local ShopSeeds = {
    {Id = 1,  String = "Carrot", Price = 1}, {Id = 2,  String = "Strawberry", Price = 10},
    {Id = 3,  String = "Blueberry", Price = 25}, {Id = 4,  String = "Tulip", Price = 40},
    {Id = 5,  String = "Tomato", Price = 200}, {Id = 6,  String = "Apple", Price = 400},
    {Id = 7,  String = "Bamboo", Price = 700}, {Id = 8,  String = "Corn", Price = 2500},
    {Id = 9,  String = "Cactus", Price = 5000}, {Id = 10, String = "Pineapple", Price = 10000},
    {Id = 11, String = "Mushroom", Price = 15000}, {Id = 12, String = "Green Bean", Price = 20000},
    {Id = 13, String = "Banana", Price = 30000}, {Id = 14, String = "Grape", Price = 50000},
    {Id = 15, String = "Coconut", Price = 140000}, {Id = 16, String = "Mango", Price = 300000},
    {Id = 17, String = "Dragon Fruit", Price = 120000}, {Id = 18, String = "Acorn", Price = 700000},
    {Id = 19, String = "Cherry", Price = 1200000}, {Id = 20, String = "Sunflower", Price = 5000000},
    {Id = 21, String = "Venus Fly Trap", Price = 7000000}, {Id = 22, String = "Pomegranate", Price = 12000000},
    {Id = 23, String = "Poison Apple", Price = 25000000}, {Id = 24, String = "Venom Spitter", Price = 30000000},
    {Id = 25, String = "Moon Bloom", Price = 65000000}, {Id = 26, String = "Dragon's Breath", Price = 90000000},
}
-- ═══ SERVICES ═══
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local Net = require(ReplicatedStorage.SharedModules.Networking)
local remote = ReplicatedStorage.SharedModules.Packet.RemoteEvent

local Window = WindUI:CreateWindow({ Title = "Grow a Garden 2 | XenLogic", Icon = "lucide:leaf", Resizable = true })
local ShopTab = Window:Tab({ Title = "Tienda y Venta" })
local Window = WindUI:CreateWindow({ Title = "Grow A Garden 2 | XenLogic", Icon = "lucide:leaf", Resizable = true })

-- Variables globales
local remote = game:GetService("ReplicatedStorage").SharedModules.Packet.RemoteEvent
-- ═══ TABS ═══
local MenuTab = Window:Tab({ Title = "Menu" })
local FarmTab = Window:Tab({ Title = "Farm" })
local ShopTab = Window:Tab({ Title = "Shop" })
local PlayerTab = Window:Tab({ Title = "Player" })
local VisualTab = Window:Tab({ Title = "Visuals" })

-- ═══ VARIABLES ═══
local S = { water=false, harvest=false, sell=false, autoBuy=false }
local selectedSeeds = {}
local autoBuy, autoSell = false, false
local buyDelay = 0.5 
local sellInterval = 5
local dWater, dHarvest, dBuy, dSell = 0.1, 0.1, 0.1, 1

-- UI: Selección de Semillas
ShopTab:Dropdown({
    Title = "Seleccionar Semillas",
    Values = (function() local t = {} for _, s in ipairs(ShopSeeds) do table.insert(t, s.String) end return t end)(),
    Multi = true,
    Callback = function(v) selectedSeeds = v end
})
-- ═══ MENU ═══
MenuTab:Paragraph({ Title = "Version", Desc = "v1" })
MenuTab:Button({ Title = "Copy Discord Link", Callback = function() setclipboard("https://discord.gg/rp3uxwHmN") end })

-- UI: Configuración de Compra
ShopTab:Slider({ 
    Title = "Delay Compra (Segundos)", 
    Value = { Min = 0.1, Max = 5, Default = 0.5, Increment = 0.1 }, 
    Callback = function(v) buyDelay = v end 
})
ShopTab:Toggle({ Title = "Auto-Comprar", Callback = function(v) autoBuy = v end })
-- ═══ FARM ═══
FarmTab:Toggle({ Title = "Auto Water", Callback = function(v) S.water = v end })
FarmTab:Slider({ Title = "Water Delay (s)", Value = { Min = 0.1, Max = 10, Default = 0.1, Increment = 0.1 }, Callback = function(v) dWater = v end })
FarmTab:Toggle({ Title = "Auto Harvest", Callback = function(v) S.harvest = v end })
FarmTab:Slider({ Title = "Harvest Delay (s)", Value = { Min = 0.1, Max = 10, Default = 0.1, Increment = 0.1 }, Callback = function(v) dHarvest = v end })

-- UI: Configuración de Venta
ShopTab:Slider({ 
    Title = "Intervalo Auto-Venta (Segundos)", 
    Value = { Min = 1, Max = 300, Default = 5, Increment = 1 }, 
    Callback = function(v) sellInterval = v end 
})
ShopTab:Toggle({ Title = "Auto-Vender", Callback = function(v) 
    autoSell = v 
    if autoSell then
        task.spawn(function()
            while autoSell do
                print("Iniciando secuencia de venta...")
                -- Secuencia de 3 pasos para evitar rechazo del servidor
                remote:FireServer(buffer.fromstring("\172\0\22")) -- Hablar
                task.wait(0.5)
                remote:FireServer(buffer.fromstring("\170\0\25")) -- Confirmar
                task.wait(0.5)
                remote:FireServer(buffer.fromstring("\171\0\23")) -- Vender
                
                print("Secuencia finalizada.")
                task.wait(sellInterval)
            end
        end)
    end
end })
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

-- Bucle de Compra (Separado para no interferir)
-- ═══ LOOPS ═══
task.spawn(function()
    while true do
        if autoBuy then
            for _, name in pairs(selectedSeeds) do
                if autoBuy then
                    local lenChar = string.char(#name)
                    remote:FireServer(buffer.fromstring("x\0" .. lenChar .. name))
                    task.wait(buyDelay)
                end
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
        task.wait(0.1)
        task.wait(0.05)
    end
end)