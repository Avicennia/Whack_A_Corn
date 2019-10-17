local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
wac = {}
wac.playurns = {}
wac.attends = {}
wac.game_create = function(pos)
    minetest.place_schematic({x=pos.x-23,y=pos.y,z=pos.z-23},wac.thefield,"0",true)
end

minetest.register_on_joinplayer(function(player)
    local n = player:get_player_name()
    table.insert(wac.playurns,n)
    --minetest.chat_send_all(minetest.serialize(wac.playurns))
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
minetest.after(3,function()wac.boundchk(wac.playurns)end)
--
dofile(modpath.."/schematics.lua")
dofile(modpath.."/support.lua")
dofile(modpath.."/framework.lua")
dofile(modpath.."/nodereg.lua")
dofile(modpath.."/itemreg.lua")
dofile(modpath.."/tempnodes.lua")
dofile(modpath.."/quirkcorns.lua")

minetest.register_entity("wac:myentity",{
    initial_properties = {
        hp_max = 1,
        physical = true,
        collide_with_objects = false,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
        visual = "upright_sprite",
        visual_size = {x = 0.4, y = 0.4},
        textures = {"bdc.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0.5, y = 1.5},
    },
})
