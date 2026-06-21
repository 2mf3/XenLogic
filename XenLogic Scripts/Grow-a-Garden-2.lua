-- GAG2.lua (Asegúrate de que este sea el contenido del archivo en GitHub)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Grow a Garden 2 - XenLogic",
   LoadingTitle = "Iniciando Interfaz...",
   LoadingSubtitle = "Modificador de Velocidad",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("Ajustes", nil)
local Section = Tab:CreateSection("Movimiento")

local Slider = Tab:CreateSlider({
   Name = "Velocidad de Caminata",
   Info = "Modifica los studs por segundo.",
   Range = {16, 100}, -- IMPORTANTE: Añade el rango, si no Rayfield puede fallar
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Restablecer Velocidad (16)",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = 16
      end
   end,
})