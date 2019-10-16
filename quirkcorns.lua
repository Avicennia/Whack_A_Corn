wae.quirks = wae.quirks or {}

function wae.register_quirk(name, def)
	def = def or {}
	local desc = def.description or (name .. "Eggcorn")
	local tiles = { def.tile or (name .. "_eggcorn.png") }
	wae.quirks[#wae.quirks + 1] = name

	minetest.register_node("wae:" .. name .. "_eggcorn", {
		description = desc,
		drawtype = "plantlike",
		tiles = tiles,
		paramtype = "light",
		groups = {thumpy = 1, eggy = 2},
		on_construct = function(pos)
			return minetest.get_node_timer(pos):start(1)
		end,
		on_timer = minetest.remove_node,
		wae_quirk = def
	})
	minetest.register_node("wae:" .. name .. "_eggcorn_inert", {
		description = desc,
		drawtype = "plantlike",
		tiles = tiles,
		paramtype = "light",
		groups = {pseudoeggy = 4}
	})
end

wae.register_quirk("simple", {
	tile = "nc_tree_eggcorn.png"
})

wae.register_quirk("melancholy", {
	value = 2,
	fx = function(pname)
		local pos = minetest.get_player_by_name(pname):get_pos()
		return wae.tempnodes(4, {{
			pos = {x = pos.x, y = pos.y + 3, z = pos.z},
			orig = "air",
			temp = wae.anynode("default:water_source", "nc_terrain:water_source")
		}})
	end
})

wae.register_quirk("cheerful", { value = 2 })

wae.register_quirk("petrified", {
	value = 2,
	fx = function(pname)
		local player = minetest.get_player_by_name(pname)
		local pos = vector.round(player:get_pos())
		local picked = wae.anynode("default:stone", "nc_terrain:stone")
		local nodes = {}
		for _, p in pairs(minetest.find_nodes_in_area(
			{x=pos.x-1,y=pos.y,z=pos.z-1},
			{x=pos.x+1,y=pos.y+3,z=pos.z+1},
			{name = "air"})) do
				if pos.x ~= p.x or pos.z ~= p.z then
					nodes[#nodes + 1] = {pos = p, orig = "air", temp = picked}
				end
		end
		player:set_pos(pos)
		return wae.tempnodes(3, nodes)
	end
})

wae.register_quirk("myscus", {
	fx = function(_, npos)
		for _, v in ipairs(minetest.find_nodes_in_area(
			{x=npos.x-8,y=npos.y,z=npos.z-8},
			{x=npos.x+8,y=npos.y,z=npos.z+8},
			"group:eggy")) do
			minetest.remove_node(v)
		end
	end
})

wae.register_quirk("victorious", {
	value = 4,
	tile = "triumphant_eggcorn.png"
})

wae.register_quirk("fruity", {
	value = function()
		return math.random(1, 6)
	end
})