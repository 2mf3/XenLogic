-- main.lua corregido
local gameID = game.PlaceId

local scripts = {
    [97598239454123] = "Grow-a-Garden-2.lua",
    [189707] = "Natural-Disaster-Survival.lua"

}

local scriptName = scripts[gameID]

if scriptName then
    local success, err = pcall(function()
        local url = "https://raw.githubusercontent.com/2mf3/XenLogic/main/XenLogic%20Scripts/" .. scriptName
        loadstring(game:HttpGet(url))()
    end)
    
    if not success then
        warn("XenLogic Error al cargar: " .. tostring(err))
    end
else
    warn("XenLogic: No hay script para este juego (ID: " .. gameID .. ")")
end