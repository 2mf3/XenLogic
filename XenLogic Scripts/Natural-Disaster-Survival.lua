local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Natural Disaster - XenLogic",
   LoadingTitle = "Cargando XenLogic...",
   LoadingSubtitle = "Survival Mod",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Supervivencia", nil)

local Section = Tab:CreateSection("Movimiento")

-- Control de Velocidad
local SpeedSlider = Tab:CreateSlider({
   Name = "Velocidad de Caminata",
   Info = "Aumenta tu velocidad para huir de los desastres.",
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 16,
   Flag = "NDWalkSpeed",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- Control de Salto
local JumpSlider = Tab:CreateSlider({
   Name = "Poder de Salto",
   Info = "Aumenta la fuerza de salto para subir a estructuras.",
   Increment = 1,
   Suffix = " studs",
   CurrentValue = 50,
   Flag = "NDJumpPower",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.UseJumpPower = true
          player.Character.Humanoid.JumpPower = Value
      end
   end,
})

-- Botón para restablecer todo por defecto
local ResetButton = Tab:CreateButton({
   Name = "Restablecer Valores Base",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
          player.Character.Humanoid.WalkSpeed = 16
          player.Character.Humanoid.JumpPower = 50
          SpeedSlider:Set(16)
          JumpSlider:Set(50)
      end
   end,
})

Rayfield:Notify({
   Title = "XenLogic Activado",
   Content = "¡Prepárate para sobrevivir al desastre!",
   Duration = 4,
   Image = nil,
})