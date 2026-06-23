-- ═══ XENLOGIC FINAL LOADER ═══

local gameID = game.PlaceId
-- La URL que tú me diste para obtener la llave
local JNKIE_KEY_SYSTEM = "https://jnkie.com/get-key/xenlogic"

-- Tu base de datos de juegos (Asegúrate de que los nombres coincidan exactamente con tus archivos en GitHub)
local scripts = {
    [97598239454123] = "Grow-a-Garden-2.lua",
    [189707] = "Natural-Disaster-Survival.lua",
    [104715542330896] = "BlockSpin.lua"
}

-- Función para cargar el script desde tu repo
local function loadGameScript(scriptName)
    local url = "https://raw.githubusercontent.com/2mf3/XenLogic/main/XenLogic%20Scripts/" .. scriptName
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("XenLogic Error al cargar el juego: " .. tostring(err))
    end
end

-- 1. Ejecutamos el flujo de Jnkie
local success, err = pcall(function()
    loadstring(game:HttpGet(JNKIE_KEY_SYSTEM))()
end)

-- 2. Si Jnkie carga, procedemos a buscar el juego
if success then
    local scriptName = scripts[gameID]
    if scriptName then
        loadGameScript(scriptName)
    else
        warn("XenLogic: Script no encontrado para este PlaceID: " .. gameID)
    end
else
    warn("XenLogic: Error en el sistema de llaves Jnkie: " .. tostring(err))
end