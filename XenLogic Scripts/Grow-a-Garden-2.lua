local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Grow a garden 2 - XenLogic",
   LoadingTitle = "Iniciando Interfaz...",
   LoadingSubtitle = "Modificador de Velocidad",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Ajustes", nil)

local Section = Tab:CreateSection("Movimiento")

local Slider = Tab:CreateSlider({
   Name = "Velocidad de Caminata",
   Info = "Modifica los studs por segundo de tu avatar.",
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local Button = Tab:CreateButton({
   Name = "Restablecer Velocidad (16)",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.WalkSpeed = 16
          -- Actualiza visualmente el slider a 16
          Slider:Set(16)
      end
   end,
})

Rayfield:Notify({
   Title = "XenLogic Cargado",
   Content = "El menú se ha ejecutado con éxito.",
   Duration = 4,
   Image = nil,
})