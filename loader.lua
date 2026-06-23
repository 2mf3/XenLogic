-- ═══ XENLOGIC LOADER ═══
local gameID = game.PlaceId

local scripts = {
    [97598239454123] = "Grow-a-Garden-2.lua",
    [189707] = "Natural-Disaster-Survival.lua",
}

local scriptName = scripts[gameID]

if scriptName then
    local url = "https://raw.githubusercontent.com/2mf3/XenLogic/main/XenLogic%20Scripts/" .. scriptName
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("XenLogic Error al cargar: " .. tostring(err))
    end
else
    warn("XenLogic: No hay script para este ID de juego (ID: " .. gameID .. ")")
end