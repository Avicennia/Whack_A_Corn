local thismod = minetest.get_current_modname()
local wac = _G[thismod]

if nodecore then
	local function check_test(x, y, z)
		return y ~= 0 or (x > 1 or x < -1 or z > 1 or z < -1) and (x == 0 or z == 0)
	end
	nodecore.register_craft({
		label = "summon sadistic eggcorn",
		norotate = true,
		priority = 10,
		check = function(pos)
			return wac.gamefield_fits(pos, check_test)
		end,
		nodes = {
			{match = "nc_tree:eggcorn", replace = "air"},
			{x = 1, match = "nc_lode:prill_hot", replace = "air"},
			{x = -1, match = "nc_lode:prill_hot", replace = "air"},
			{z = 1, match = "nc_lode:prill_hot", replace = "air"},
			{z = -1, match = "nc_lode:prill_hot", replace = "air"},
		},
		after = function(pos)
			return wac.gamefield_create(pos)
		end
	})
end