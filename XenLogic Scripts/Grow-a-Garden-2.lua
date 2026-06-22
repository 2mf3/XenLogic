local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Base de datos completa integrada
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

-- Función para extraer los nombres automáticamente para el Dropdown
local function getSeedNames()
    local names = {}
    for _, seed in ipairs(ShopSeeds) do
        table.insert(names, seed.String)
    end
    return names
end

local Window = Rayfield:CreateWindow({
   Name = "Grow a Garden 2 - XenLogic",
   LoadingTitle = "Iniciando Interfaz...",
   LoadingSubtitle = "Sistema de Tienda Completo",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- Pestaña Ajustes
local Tab = Window:CreateTab("Ajustes", nil)
Tab:CreateSlider({
   Name = "Velocidad de Caminata",
   Range = {16, 100},
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 16,
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = Value end
   end,
})

-- Pestaña Tienda
local ShopTab = Window:CreateTab("Tienda", nil)
local selectedSeedName = ShopSeeds[1].String
local autoBuyEnabled = false

ShopTab:CreateDropdown({
   Name = "Seleccionar Semilla",
   Options = getSeedNames(),
   CurrentOption = selectedSeedName,
   Callback = function(Option)
      selectedSeedName = Option
   end,
})

ShopTab:CreateToggle({
   Name = "Auto-Comprar",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyEnabled = Value
      if autoBuyEnabled then
         task.spawn(function()
            while autoBuyEnabled do
               local remote = game:GetService("ReplicatedStorage"):FindFirstChild("SharedModules")
               if remote then
                   remote = remote.Packet.RemoteEvent
                   local buf = buffer.create(32)
                   buffer.writeu8(buf, 0, 0x09) 
                   buffer.writeu8(buf, 1, 0x00)
                   buffer.writeu8(buf, 2, 0x01)
                   buffer.writeu8(buf, 3, #selectedSeedName)
                   buffer.writestring(buf, 4, selectedSeedName)
                   
                   remote:FireServer(buffer.readbuffer(buf, 0, 4 + #selectedSeedName))
               end
               task.wait(0.6) 
            end
         end)
      end
   end,
})