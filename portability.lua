local thismod = minetest.get_current_modname()
--local wac = _G[thismod]

if nodecore then
	nodecore.register_craft({
		label = "summon sadistic eggcorn",
		norotate = true,
		priority = 10,
		nodes = {
			{match = "nc_tree:eggcorn", replace = thismod .. ":sadistic_eggcorn"},
			{x = 1, match = "nc_lode:prill_hot", replace = "air"},
			{x = -1, match = "nc_lode:prill_hot", replace = "air"},
			{z = 1, match = "nc_lode:prill_hot", replace = "air"},
			{z = -1, match = "nc_lode:prill_hot", replace = "air"},
		}
	})
end