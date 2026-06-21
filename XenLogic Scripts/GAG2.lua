local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Control de Velocidad",
   LoadingTitle = "Cargando Interfaz...",
   LoadingSubtitle = "por AI Collaborator",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Principal", nil)

local Slider = Tab:CreateSlider({
   Name = "Velocidad del Jugador",
   Info = "Ajusta la velocidad de caminata de tu personaje.",
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      -- Modifica la velocidad del personaje local
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- Notificación de éxito
Rayfield:Notify({
   Title = "¡Listo!",
   Content = "El script se ha cargado correctamente.",
   Duration = 3,
   Image = nil,
})