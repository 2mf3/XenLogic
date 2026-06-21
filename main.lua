-- main.lua
local gameID = game.PlaceId

-- Aquí agregas tus juegos. La ID a la izquierda, el nombre del archivo a la derecha.
local scripts = {
    [97598239454123] = "Grow-a-Garden-2", -- Grow a Garden 2
    [189707] = "Natural-Disaster-Survival.lua" -- Natural Disaster Survival
}

local scriptName = scripts[gameID]

if scriptName then
    -- ESTO ES LO QUE HACE LA MAGIA: 
    -- Carga dinámicamente el archivo que corresponde al juego.
    loadstring(game:HttpGet("https://raw.githubusercontent.com/2mf3/XenLogic/main/XenLogic%20Scripts/" .. scriptName))()
else
    warn("XenLogic: No hay script para este juego (ID: " .. gameID .. ")")
end