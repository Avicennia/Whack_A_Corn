local thismod = minetest.get_current_modname()

minetest.register_node(thismod .. ":resigned_grass",{
	description = "Resigned Grass",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2, wac_check = 1},
	tiles = {
		"wac_node_resigned_grass_top.png",
		"wac_node_resigned_dirt.png",
		"wac_node_resigned_dirt.png^wac_node_resigned_grass_overlay.png"
	},
	sounds = {footstep = {name = "wac_resignedgrasswalk"}}
})

minetest.register_node(thismod .. ":smashed_egg", {
	description = "Smashed Eggcorn",
	groups = {choppy = 1, eggy = 2, falling_node = 1},
	tiles = {"wac_node_eggcorn_hashed.png"},
	drawtype = "nodebox",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, 0.1875, 0.125, -0.4375, 0.3125}, -- NodeBox1
			{-0.3125, -0.5, 0.1875, -0.25, -0.4375, 0.3125}, -- NodeBox3
			{0.25, -0.5, -0.4375, 0.3125, -0.4375, -0.25}, -- NodeBox4
			{-0.1875, -0.5, -0.5, -0.0625, -0.375, -0.25}, -- NodeBox6
			{0.375, -0.5, -0.4375, 0.4375, -0.4375, -0.3125}, -- NodeBox7
			{-0.0625, -0.5, -0.1875, 0, -0.4375, 0}, -- NodeBox8
			{0, -0.5, -0.1875, 0.125, -0.375, -0.125}, -- NodeBox9
			{0.3125, -0.5, 0, 0.4375, -0.4375, 0.0625}, -- NodeBox10
		}
	},
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(3)
	end,
	on_timer = function(pos)
		minetest.remove_node(pos)
	end

})

minetest.register_node(thismod .. ":stone",{
	description = "Stone",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2, wac_check = 1},
	tiles = {"wac_node_stone.png"},
})

minetest.register_abm({
	label = "Clean up old games",
	nodenames = {"group:wac_check"},
	interval = 10,
	chance = 1,
	action = function(pos)
		local id = minetest.get_meta(pos):get_float("wac_id")
		if (not id) or (id == 0) then
			return minetest.after(math.random() * 10,
			function() return minetest.remove_node(pos) end)
		end
	end
})