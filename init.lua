local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
wae_s = minetest.get_mod_storage()
wae = {}
wae.quirks = {"simple","melancholy","cheerful","petrified","myscus","victorious","fruity"}
wae.playurns = {}
wae.attends = {}
wae.game_create = function(pos)
    minetest.place_schematic({x=pos.x-23,y=pos.y,z=pos.z-23},wae.thefield,"0",_,true,_)
end

minetest.register_on_joinplayer(function(player)
    local n = player:get_player_name()
    table.insert(wae.playurns,n)
    minetest.chat_send_all(minetest.serialize(wae.playurns))
end)
minetest.register_on_leaveplayer(function(player, timed_out)
    local nm = player:get_player_name()
    local d = 0
    for n=1, #wae.playurns, 1 do 
        if(wae.playurns[n] == nm) then
            d = n 
        else end
    end
    table.remove(wae.playurns,d)
end)
minetest.after(3,function()wae.boundchk(wae.playurns)end)
--    
dofile(modpath.."/schematics.lua")
dofile(modpath.."/support.lua")
dofile(modpath.."/framework.lua")
dofile(modpath.."/nodereg.lua")
dofile(modpath.."/itemreg.lua")