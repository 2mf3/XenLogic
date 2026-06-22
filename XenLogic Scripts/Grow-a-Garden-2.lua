local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- Tabla de semillas completa
local ShopSeeds = {
    {Id = 1,  String = "Carrot",          Price = 1},
    {Id = 2,  String = "Strawberry",      Price = 10},
    {Id = 3,  String = "Blueberry",       Price = 25},
    {Id = 4,  String = "Tulip",           Price = 40},
    {Id = 5,  String = "Tomato",          Price = 200},
    {Id = 6,  String = "Apple",           Price = 400},
    {Id = 7,  String = "Bamboo",          Price = 700},
    {Id = 8,  String = "Corn",            Price = 2500},
    {Id = 9,  String = "Cactus",          Price = 5000},
    {Id = 10, String = "Pineapple",       Price = 10000},
    {Id = 11, String = "Mushroom",        Price = 15000},
    {Id = 12, String = "Green Bean",      Price = 20000},
    {Id = 13, String = "Banana",          Price = 30000},
    {Id = 14, String = "Grape",           Price = 50000},
    {Id = 15, String = "Coconut",         Price = 140000},
    {Id = 16, String = "Mango",           Price = 300000},
    {Id = 17, String = "Dragon Fruit",    Price = 120000},
    {Id = 18, String = "Acorn",           Price = 700000},
    {Id = 19, String = "Cherry",          Price = 1200000},
    {Id = 20, String = "Sunflower",       Price = 5000000},
    {Id = 21, String = "Venus Fly Trap",  Price = 7000000},
    {Id = 22, String = "Pomegranate",     Price = 12000000},
    {Id = 23, String = "Poison Apple",    Price = 25000000},
    {Id = 24, String = "Venom Spitter",   Price = 30000000},
    {Id = 25, String = "Moon Bloom",      Price = 65000000},
    {Id = 26, String = "Dragon's Breath", Price = 90000000},
}

local Window = WindUI:CreateWindow({ Title = "Grow a Garden 2 | XenLogic", Icon = "lucide:leaf", Resizable = true })
local ShopTab = Window:Tab({ Title = "Tienda y Venta" })

local selectedSeeds = {}
local autoBuy = false
local autoSell = false
local sellInterval = 5

ShopTab:Dropdown({
    Title = "Seleccionar Semillas (Múltiple)",
    Values = (function() local t = {} for _, s in ipairs(ShopSeeds) do table.insert(t, s.String) end return t end)(),
    Multi = true,
    Callback = function(v) selectedSeeds = v end
})

ShopTab:Toggle({ Title = "Auto-Comprar", Callback = function(v) autoBuy = v end })
ShopTab:Slider({ 
    Title = "Segundos para Auto-Venta", 
    Value = { Min = 1, Max = 300, Default = 5 }, 
    Callback = function(v) sellInterval = v end 
})
ShopTab:Toggle({ Title = "Auto-Vender Inventario", Callback = function(v) autoSell = v end })

-- Lógica de Auto-Compra y Auto-Venta
task.spawn(function()
    local remote = game:GetService("ReplicatedStorage").SharedModules.Packet.RemoteEvent
    
    while true do
        if autoBuy then
            for _, name in pairs(selectedSeeds) do
                -- Formato capturado: "x\0\nStrawberry" -> 'x' es char 120, \0 es null, \n es length
                local lenChar = string.char(#name)
                remote:FireServer(buffer.fromstring("x\0" .. lenChar .. name))
            end
        end
        if autoSell then
            -- Formato capturado: "\171\0\17"
            remote:FireServer(buffer.fromstring("\171\0\17"))
        end
        task.wait(autoSell and sellInterval or 0.6)
    end
end)