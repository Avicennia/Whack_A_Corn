local thismod = minetest.get_current_modname()
local wac = _G[thismod]

--
--
--

local wac_s = minetest.get_mod_storage()

--Sadistic eggcorn God: Game starting node
minetest.register_node(thismod .. ":sadistic_eggcorn",{
	description = "Sadistic Eggcorn",
	drawtype = "plantlike",
	tiles = {"sadistic_eggcorn.png"},
	groups = {cracky = 2, eventy = 2},
	on_rightclick = function(pos)
		wac.game_create(pos)
		minetest.set_node({x=pos.x,y=pos.y+15,z=pos.z},
			{name=thismod .. ":sadistic_eggcorn"})
		local field = wac.find_nodes(pos, {23, 15, 23}, {23, 0, 23},
			thismod .. ":resigned_grass")
		wac_s:set_string("gboard",minetest.serialize(field))
		minetest.remove_node(pos)
		for _,v in ipairs(field)do
			wac.spewparticles(v,"dev_tex.png")
		end
	end
})
--Fence: Designates area where the game is conducted.
minetest.register_node(thismod .. ":fence",{
	description = "Subjugatory Fence",
	tiles = {"stone.png"},
	groups = {choppy = 3},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
		}
	}
})
minetest.register_node(thismod .. ":resigned_grass",{
	description = "Resigned Grass",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2},
	tiles = {
		"resigned_grass_top.png",
		"stone.png",
		"resigned_grass_overlay.png"
	},
	sounds = {footstep = {name = "resignedgrasswalk"}}
})
minetest.register_node(thismod .. ":resigned_grass_inert",{
	description = "Resigned Grass",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2, pseudoeggy = 2},
	tiles = {"resigned_grass_top.png"},
})
minetest.register_node(thismod .. ":smashed_egg", {
	description = "Smashed Eggcorn",
	groups = {choppy = 1, eggy = 2, falling_node = 1},
	tiles = {"hashed_eggcorn.png"},
	drawtype = "nodebox",
	paramtype = "light",
	walkable = false,
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
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2},
	tiles = {"stone.png"},
})