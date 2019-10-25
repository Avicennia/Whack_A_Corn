local thismod = minetest.get_current_modname()
local modpath = minetest.get_modpath(thismod)

local wac = {}
rawset(_G, thismod, wac)

local function include(n)
	return dofile(modpath .. "/" .. n .. ".lua")
end

include("framework")
include("nodereg")
include("itemreg")
include("tempnodes")
include("quirkcorns")
include("jumpcorns")
include("jumptools")
include("portability")
include("gamefield")
include("scoring")
