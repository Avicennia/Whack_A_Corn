local thismod = minetest.get_current_modname()
local wac = _G[thismod]

wac.quirks = wac.quirks or {}

function wac.register_quirk(name, def)
	def = def or {}
	local desc = def.description or (name:sub(1, 1):upper()
		.. name:sub(2) .. " Eggcorn")
	local tiles = { def.tile or (name .. "_eggcorn.png") }
	wac.quirks[#wac.quirks + 1] = name

	minetest.register_node(thismod .. ":" .. name .. "_eggcorn", {
		description = desc,
		drawtype = "plantlike",
		tiles = tiles,
		paramtype = "light",
		groups = {thumpy = 1, eggy = 2},
		on_construct = function(pos)
			return minetest.get_node_timer(pos):start(1)
		end,
		on_timer = minetest.remove_node,
		wac_quirk = def
	})
	minetest.register_node(thismod .. ":" .. name .. "_eggcorn_inert", {
		description = desc,
		drawtype = "plantlike",
		tiles = tiles,
		paramtype = "light",
		groups = {pseudoeggy = 4}
	})
end

wac.register_quirk("simple", {
	tile = "nc_tree_eggcorn.png"
})

wac.register_quirk("melancholy", {
	value = 2,
	fx = function(pname)
		local pos = minetest.get_player_by_name(pname):get_pos()
		return wac.tempnodes(4, {{
			pos = {x = pos.x, y = pos.y + 3, z = pos.z},
			orig = "air",
			temp = wac.anynode("default:water_source", "nc_terrain:water_source")
		}})
	end
})

wac.register_quirk("cheerful", { value = 2 })

wac.register_quirk("petrified", {
	value = 2,
	fx = function(pname)
		local player = minetest.get_player_by_name(pname)
		local pos = vector.round(player:get_pos())
		local picked = wac.anynode("default:stone", "nc_terrain:stone")
		local nodes = {}
		for _, p in pairs(wac.find_nodes(pos, {1, 0, 1}, {1, 3, 1}, "air")) do
			if pos.x ~= p.x or pos.z ~= p.z then
				nodes[#nodes + 1] = {pos = p, orig = "air", temp = picked}
			end
		end
		player:set_pos(pos)
		return wac.tempnodes(3, nodes)
	end
})

wac.register_quirk("myscus", {
	fx = function(_, npos)
		for _, v in ipairs(wac.find_nodes(npos, {8, 0, 8}, {8, 0, 8}, "group:eggy")) do
			minetest.remove_node(v)
		end
	end
})

wac.register_quirk("victorious", {
	value = 4,
	tile = "triumphant_eggcorn.png"
})

wac.register_quirk("fruity", {
	value = function()
		return math.random(1, 6)
	end
})