local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)
wae_s = minetest.get_mod_storage()
wae = {}
wae.quirks = {"simple","melancholy","cheerful","petrified","myscus","victorious","fruity"}
wae.game_create = function(pos)
    minetest.place_schematic({x=pos.x-23,y=pos.y,z=pos.z-23},wae.thefield,"0",_,true,_)
end

--    
dofile(modpath.."/schematics.lua")
dofile(modpath.."/support.lua")
dofile(modpath.."/framework.lua")
dofile(modpath.."/nodereg.lua")
dofile(modpath.."/itemreg.lua")