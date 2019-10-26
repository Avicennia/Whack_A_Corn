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
	rarity = 1,
	tile = "nc_tree_eggcorn.png"
})

wac.register_quirk("melancholy", {
	rarity = 1.75,
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

wac.register_quirk("cheerful", {
	rarity = 2,
	value = 2
})

wac.register_quirk("petrified", {
	rarity = 1.5,
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
	wac_corn_rarity = 1,
	fx = function(_, npos)
		wac.find_corns(npos, 8, wac.jump_smash)
	end
})

wac.register_quirk("victorious", {
	rarity = 3,
	value = 4,
	tile = "triumphant_eggcorn.png",
	tick = function (self)
		local obj = self.object
		wac.find_corns(obj:get_pos(), 2, function(lua, pobj)
			if pobj ~= obj then return wac.jump_smash(lua, pobj) end
		end)
	end
})

wac.register_quirk("fruity", {
	rarity = 3,
	value = function()
		return math.random(1, 6)
	end
})

wac.register_quirk("sadistic", {
	rarity = 7,
	value = function()
		return math.random(1, 20)
	end,
	fx = function(player)
		local pname = player:get_player_name()
		minetest.after(0.25, function()
			player = minetest.get_player_by_name(pname)
			if not player then return end
			local pos = player:get_pos()
			pos.y = pos.y + player:get_properties().eye_height
			local inv = player:get_inventory()
			for i = 1, inv:get_size("main") do
				local stack = inv:get_stack("main", i)
				inv:set_stack("main", i, ItemStack(""))
				if not stack:is_empty() then
					local obj = minetest.add_item(pos, stack)
					if obj then obj:set_velocity({
						x = (math.random() - 0.5) * 10,
						y = math.random() * 10,
						z = (math.random() - 0.5) * 10,
					}) end
				end
			end
		end)
	end
})
