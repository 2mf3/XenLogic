-- 1. Cargar dependencias (WindUI)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Lib/WindUI/main/WindUI.lua"))()

-- 2. Definir la función que crea tu interfaz (Tu script de juego)
local function StartMyScript()
    local Window = WindUI:CreateWindow({
        Title = "XenLogic | Grow a Garden 2",
        Folder = "XenLogicData"
    })

    local Tab = Window:Tab({ Title = "Main" })
    Tab:Label({ Title = "¡Bienvenido a Grow a Garden 2!" })
    -- Aquí pones tus botones de AutoFarm, etc.
end

-- 3. INTEGRACIÓN DE JNKIE (El Key System)
-- Este código ejecutará Jnkie. Si la llave es correcta, Jnkie cargará el script.
-- Como tú ya tienes tu link de Jnkie, lo usamos directamente:

local JNKIE_URL = "https://jnkie.com/flow/4a783689-bf6a-4414-b2bc-725acbf2310e"

local success, err = pcall(function()
    loadstring(game:HttpGet(JNKIE_URL))()
end)

-- IMPORTANTE: Si Jnkie se encarga de todo, el script debería inyectarse solo.
-- Si Jnkie te pide un "destino", pon el link de este mismo archivo loader.lua.