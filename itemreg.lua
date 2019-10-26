local thismod = minetest.get_current_modname()
local wac = _G[thismod]


function wac.register_smasher(name, def)
	def.wac_smasher = true

	def.inventory_image = def.inventory_image or ("wac_tool_" .. name .. ".png")

	def.wac_smash_targets = def.wac_smash_targets
	or function(func, lua, obj) return func(lua, obj) end

	def.on_use = def.on_use or function(_, user, pointed_thing)
		if pointed_thing.type == "node" then
			return minetest.node_punch(pointed_thing.under,
				minetest.get_node(pointed_thing.under),
				user, pointed_thing)
		elseif pointed_thing.type == "object" then
			def.wac_smash_targets(function(obj)
				local opos = obj:get_pos()
				local function helper(...)
					if def.wac_smash_quirk then
						def.wac_smash_quirk(opos)
					end
					return ...
				end
				return helper(wac.jump_whack(user, obj))
			end, pointed_thing.ref)
		end
	end

	return minetest.register_craftitem(thismod .. ":" .. name, def)
end

--
--
--

wac.register_smasher("warrhammer", {
	description = "Warr Hammer",
	groups = {metal = 1, thwacky = 2},
	wac_smash_quirk = function(pos)
		wac.tumbleparticles(pos,"wac_fx_warrcode.png")
	end,
	wac_tool_rarity = 2
})

wac.register_smasher("codex_dimond", {
	description = "Codex Dimond",
	groups = {metal = 1, thwacky = 2},
	wac_smash_targets = function(func, obj)
		if not func(obj) then return end
		local delrad = {}
		wac.find_corns(obj:get_pos(), 6, function(_, xobj)
			delrad[#delrad + 1] = xobj
		end)
		if #delrad < 1 then return end
		local pick = delrad[math.random(1, #delrad)]
		func(pick)
	end,
	wac_smash_quirk = function(pos)
		wac.dimond_focused_lazer(pos,"wac_fx_banzer.png")
	end,
	wac_tool_rarity = 5
})

wac.register_smasher("bec_de_corbin", {
	description = "Bec_de_Corbin",
	groups = {metal = 1, event = 2, thwacky = 2},
	wac_tool_rarity = 1
})

wac.register_smasher("baseball_bat",{
	description = "Ol' Reliable",
	groups = {metal = 1, event = 2, thwacky = 3},
	wac_tool_rarity = 1
})

wac.register_smasher("vampirewhip",{
    description = "Far Rach",
	groups = {metal = 1, event = 2, thwacky = 4},
	range = 8,
	wac_tool_rarity = 3
})

wac.register_smasher("paws",{
	description = "Paws of the Kittypet",
	groups = {metal = 1, event = 2, thwacky = 3},
	wac_tool_rarity = 2
})

wac.register_smasher("suchion_cup",{
	description = "Suchion Cup",
	groups = {metal = 1, event = 2, thwacky = 3},
	wac_tool_rarity = 3,
	wac_smash_quirk = function(pos)
		wac.find_corns(pos, 10, function(_, obj)
			local rel = vector.subtract(pos, obj:get_pos())
			local len = vector.length(rel)
			if len > 0 then
				rel = vector.multiply(rel, 250 / len / len / len)
				obj:add_velocity(rel)
			end
		end)
	end,
})