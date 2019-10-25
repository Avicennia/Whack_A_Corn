local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
local wac = {}
rawset(_G, thismod, wac)
wac.playurns = {}
wac.attends = {}

minetest.register_on_joinplayer(function(player)
    local n = player:get_player_name()
    table.insert(wac.playurns,n)
    local lll = player:hud_add(wac.scoreshow(player))
    local pmeta = player:get_meta()
    for n=1, 1000, 1 do
    player:hud_remove(n)
    end
    pmeta:set_int("scoretag",lll)
end)
minetest.register_on_leaveplayer(function(player)
    local nm = player:get_player_name()
    local d = 0
    for n=1, #wac.playurns, 1 do
        if(wac.playurns[n] == nm) then
            d = n
        end
    end
    
    table.remove(wac.playurns,d)
end)

function wac.scoreshow(player)
	local pl = player
	local pm = pl:get_meta()
	local sc = pm:get_int("score")
local hudscore = 
{
    hud_elem_type = "text",
    position = {x=0.36, y=0.95},
    name = "score",
    scale = {x = 2, y = 2},
    text = sc,
    number = 10,
    item = 1,
    direction = 0,
    alignment = {x=1, y=0},
    offset = {x=0, y=0},
    size = { x=80, y=80},
}
return hudscore
end

function wac.scoremove(player)
	player:hud_remove(player:hud_add(wac.scoreshow(player)))
end
--
dofile(modpath.."/framework.lua")
dofile(modpath.."/schematics.lua")
dofile(modpath.."/support.lua")
dofile(modpath.."/nodereg.lua")
dofile(modpath.."/itemreg.lua")
dofile(modpath.."/tempnodes.lua")
dofile(modpath.."/quirkcorns.lua")
dofile(modpath.."/jumpcorns.lua")
dofile(modpath.."/jumptools.lua")
dofile(modpath.."/portability.lua")
dofile(modpath.."/gamefield.lua")