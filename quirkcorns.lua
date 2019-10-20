local thismod = minetest.get_current_modname()
local wac = _G[thismod]

wac.quirks = wac.quirks or {}

function wac.register_quirk(name, def)
	def = def or {}
	local desc = def.description or (name:sub(1, 1):upper()
		.. name:sub(2) .. " Eggcorn")
	local tile = def.tile or (name .. "_eggcorn.png")
	wac.quirks[#wac.quirks + 1] = name

	minetest.register_craftitem(thismod .. ":" .. name .. "_eggcorn", {
		description = desc,
		inventory_image = tile,
		wac_quirk = def
	})
end

wac.register_quirk("simple", {
	tile = "nc_tree_eggcorn.png"
})

wac.register_quirk("melancholy", {
	value = 2,
	fx = function(player)
		if not player then return end
		local pos = player:get_pos()
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
	fx = function(player)
		if not player then return end
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
		wac.find_corns(npos, 8, wac.jump_smash)
	end
})

wac.register_quirk("victorious", {
	value = 4,
	tile = "triumphant_eggcorn.png",
	tick = function (self)
		local obj = self.object
		wac.find_corns(obj:get_pos(), 2, function(lua, pobj)
			if pobj ~= obj then return wac.jump_smash(lua, pobj) end
		end)
		for _, o in pairs(minetest.get_objects_inside_radius(obj:get_pos(), 2)) do
			if o ~= obj then
				local lua = o.get_luaentity and o:get_luaentity()
				if lua and lua.jumpcorn then wac.jump_smash(lua, o) end
			end
		end
	end
})

wac.register_quirk("fruity", {
	value = function()
		return math.random(1, 6)
	end
})