local RayfieldLoaded, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not RayfieldLoaded then
    warn("Error fatal al cargar Rayfield: " .. tostring(Rayfield))
    return
end

-- Base de datos completa
local ShopSeeds = {
    {Id = 1,  String = "Carrot",          Price = 1},
    {Id = 2,  String = "Strawberry",      Price = 10},
    -- ... (tu tabla sigue igual)
    {Id = 26, String = "Dragon's Breath", Price = 90000000},
}

-- Función para nombres
local function getSeedNames()
    local names = {}
    for _, seed in ipairs(ShopSeeds) do table.insert(names, seed.String) end
    return names
end

local Window = Rayfield:CreateWindow({
   Name = "Grow a Garden 2 - XenLogic",
   LoadingTitle = "Iniciando...",
   LoadingSubtitle = "Sistema cargado correctamente",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

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