-- ═══ XENLOGIC LOADER ═══
local gameID = game.PlaceId

-- Asegúrate de que los nombres coincidan exactamente con tus archivos
local scripts = {
    [97598239454123] = "Grow-a-Garden-2.lua",
    [189707] = "Natural-Disaster-Survival.lua",
}

local scriptName = scripts[gameID]

if scriptName then
    -- HE CAMBIADO LA RUTA A "XenLogic/" porque es donde tienes tus archivos
    local url = "https://raw.githubusercontent.com/2mf3/XenLogic/main/XenLogic/" .. scriptName
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("XenLogic Error al cargar: " .. tostring(err))
    end
else
    warn("XenLogic: No hay script para este ID de juego (ID: " .. gameID .. ")")
end