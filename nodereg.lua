--
--
--

--Sadistic eggcorn God: Game starting node 
minetest.register_node("wae:sadistic_eggcorn",{
	description = "Sadistic Eggcorn",
	drawtype = "plantlike",
	tiles = {"sadistic_eggcorn.png"},
	groups = {cracky = 2, eventy = 2},
	on_rightclick = function(pos)
		wae.game_create(pos)
		minetest.set_node({x=pos.x,y=pos.y+15,z=pos.z}, {name="wae:sadistic_eggcorn"})
		wae_s:set_string("gboard",minetest.serialize(
			minetest.find_nodes_in_area({x=pos.x-23,y=pos.y,z=pos.z-23},{x=pos.x+23,y=pos.y-15,z=pos.z+23},{name = "wae:resigned_grass"})))
		minetest.remove_node(pos)
		for k,v in ipairs(minetest.find_nodes_in_area({x=pos.x-23,y=pos.y,z=pos.z-23},{x=pos.x+23,y=pos.y-15,z=pos.z+23},{name = "wae:resigned_grass"}))do
			wae.spewparticles(v,"dev_tex.png")
		end
	end
})
--Fence: Designates area where the game is conducted.
minetest.register_node("wae:fence",{
	description = "Subjugatory Fence",
	tiles = {"subjugatory_fence.png"},
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
minetest.register_node("wae:resigned_grass",{
	description = "Resigned Grass",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2},
	tiles = {"resigned_grass_top.png"},
	sounds = {footstep = {name = "resignedgrasswalk"}},
	on_punch = function(pos)
		local pup = {x=pos.x,y=pos.y+1,z=pos.z}
		math.random(0,10);math.random(0,10);
		local num = math.random(0,10)
		if(num >=4)then
		local timer = minetest.get_node_timer(pos)
		timer:start(0.5)
		else
		end
	end,
	 on_timer = function(pos)
		local pup = {x=pos.x,y=pos.y+1,z=pos.z}
		if(minetest.get_node(pup).name == "air")then
		minetest.set_node(pup,{name = "wae:"..wae.array_rand(wae.quirks).."_eggcorn"})
		else 
	 end
	end
})
minetest.register_node("wae:resigned_grass_inert",{
	description = "Resigned Grass",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2},
	tiles = {"resigned_grass_top.png"},
	groups = {pseudoeggy = 2}
})
minetest.register_node("wae:smashed_egg", {
	description = "Smashed Eggcorn",
	groups = {choppy = 1},
	tiles = {"hashed_eggcorn.png"},
	drawtype = "nodebox",
	paramtype = "light",
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
	groups = {eggy = 2}
})
minetest.register_node("wae:deaf_glass", {
    description = "Glass",
    drawtype = "glasslike_framed",
    tiles = {"deaf_glass.png", "deaf_glass_detail.png"},
    inventory_image = minetest.inventorycube("deaf_glass.png"),
	paramtype = "light",
	pointable = false,
    sunlight_propagates = true, 
	groups = {cracky = 3, oddly_breakable_by_hand = 3}
})
--[[minetest.register_node("wae:subjugatory_fpost", {
	tiles = {"nc_tree_tree_side.png"},
	drawtype = "nodebox",
	paramtype = "light",
	connects_to = {"wae:subjugatory_fpost"},
	connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	node_box = {
		type = "connected",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5875, 0.0625},
		},
		connect_back = {-0.0625, -0.1, 0.0625, 0.0625, 0, 0.5},
		connect_right = {0.0625, -0.1, -0.0625, 0.5, 0, 0.0625},
		connect_left = {-0.5, -0.1, -0.0625, -0.0625, 0, 0.0625},
		connect_front = {-0.0625, -0.1, -0.5, 0.0625, 0, -0.0625},
	}
})
]]

minetest.register_node("wae:dev", {
		tiles = {
			"nc_tree:log.png",
		},
		drawtype = "nodebox",
		paramtype = "light",
		node_box = {
			type = "fixed",
			fixed = {
				{0, -0.5, 0, 0.0625, 0.5, 0.0625}, -- NodeBox1
				{-0.0625, -0.5, 0, 0, 0.3125, 0.0625}, -- NodeBox3
				{-0.0625, -0.5, -0.0625, 0, 0.25, 0}, -- NodeBox4
				{0, -0.5, -0.0625, 0.0625, 0.4375, 0}, -- NodeBox5
			}
		},
	groups = {cracky=3, stone=1},
	on_punch = function(pos)
		minetest.remove_node(pos)
		minetest.remove_node({x=pos.x,y=pos.y-1,z=pos.z})
	end
})
minetest.register_node("wae:stone",{
	description = "Stone",
	groups = {crumbly = 2, event = 2, oddly_breakable_by_hand = 2},
	tiles = {"stone.png"},
})