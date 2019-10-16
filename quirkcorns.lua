wae.quirks = {}

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

function wae.smash(pname, ppos, npos)
	local nname = npos and minetest.get_node(npos).name
	local def = nname and minetest.registered_nodes[nname]
	local quirk = def and def.wae_quirk
	if not quirk then return end

	local value = quirk.value or 1
	if type(value) == "function" then value = value(pname, npos) end

	local player = minetest.get_player_by_name(pname)
	local pmeta = player:get_meta()
	pmeta:set_int("score", pmeta:get_int("score")+value)

	minetest.set_node(npos,{name = "wae:smashed_egg"})

	if quirk.fx then quirk.fx(pname, npos) end
end

wae.register_quirk("simple", {
	tile = "nc_tree_eggcorn.png"
})
wae.register_quirk("melancholy", {
	value = 2,
	fx = function(pname)
		return wae.eggeffect_deluge(pname, 4)
	end
})
wae.register_quirk("cheerful", { value = 2 })
wae.register_quirk("petrified", {
	value = 2,
	fx = function(pname)
		return wae.eggeffect_entomb(pname, 3)
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