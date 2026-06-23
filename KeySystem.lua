-- ═══ KeySystem.lua (El portero) ═══

-- 1. Tu URL de Jnkie
local JNKIE_URL = "https://jnkie.com/flow/4a783689-bf6a-4414-b2bc-725acbf2310e"

-- 2. La URL de tu loader.lua (el que ya tienes funcionando)
-- Asegúrate de que esta URL sea el link "Raw" de tu archivo loader.lua en GitHub
local LOADER_URL = "https://raw.githubusercontent.com/2mf3/XenLogic/main/XenLogic/loader.lua"

-- 3. Ejecución del sistema
local success, err = pcall(function()
    -- Primero cargamos Jnkie para validar la llave
    loadstring(game:HttpGet(JNKIE_URL))()
end)

if success then
    -- Si Jnkie validó correctamente, cargamos tu loader que detecta el juego
    loadstring(game:HttpGet(LOADER_URL))()
else
    warn("XenLogic: Error al iniciar el KeySystem: " .. tostring(err))
end