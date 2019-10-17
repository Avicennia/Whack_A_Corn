local thismod = minetest.get_current_modname()
local wac = _G[thismod]

minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
	if not puncher:is_player() then return end
	local wielded = puncher:get_wielded_item()
	local def = minetest.registered_items[wielded:get_name()]
	if (not def) or (not def.wac_smasher) then return end
	local hits = def.wac_smash_targets
		and def.wac_smash_targets(pos, node, puncher, pointed_thing)
		or {pos}
	for _, p in pairs(hits) do
		wac.smash(puncher:get_player_name(), p)
		if def.wac_smash_quirk then
			def.wac_smash_quirk(p, pos, node, puncher, pointed_thing)
		end
	end
end)

function wac.register_smasher(name, def)
	def.wac_smasher = true
	def.on_use = def.on_use or function(_, user, pointed_thing)
		if pointed_thing.type ~= "node" or not pointed_thing.under then return end
		minetest.node_punch(pointed_thing.under, minetest.get_node(pointed_thing.under),
			user, pointed_thing)
	end
	return minetest.register_craftitem(name, def)
end

--potsu:damas,
--
--
wac.register_smasher(thismod .. ":warrhammer",{
	description = "Warr Hammer",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "maultest.png",
	wield_image = "maultest.png",
	wac_smash_quirk = function(pos)
		wac.tumbleparticles(pos,"code_warr.png")
	end
})
wac.register_smasher(thismod .. ":codex_dimond",{
	description = "Codex Dimond",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "dimondomicon.png",
	wield_image = "dimondomicon.png",
	wac_smash_targets = function(pos)
		local picked = {pos}
		local delrad = wac.find_nodes(pos, {6, 6, 6}, {6, 6, 6}, "group:eggy")
		if #delrad > 0 then picked[#picked + 1] = delrad[math.random(1, #delrad)] end
		return picked
	end,
	wac_smash_quirk = function(pos)
		wac.dimond_focused_lazer(pos,"banzer.png")
	end
})
wac.register_smasher(thismod .. ":jagged_flint",{
	description = "Jagged Flint Shard",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "flint.png"
})
wac.register_smasher(thismod .. ":bec_de_corbin",{
	description = "Bec_de_Corbin",
	groups = {metal = 1, event = 2, thwacky = 2},
	inventory_image = "bdc.png",
	wield_image = "bdc.png"
})
wac.register_smasher(thismod .. ":baseball_bat",{
	description = "Ol' Reliable",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "bbat.png",
	wield_image = "bbat.png"
})
wac.register_smasher(thismod .. ":hostwand",{
	description = "Event Host Wand",
	inventory_image = "hostwand.png"
})
wac.register_smasher(thismod .. ":vampirewhip",{
    description = "Far Rach",
	inventory_image = "distancewhip.png",
	groups = {metal = 1, event = 2, thwacky = 4},
	range = 8
})
wac.register_smasher(thismod .. ":paws",{
	description = "Paws of the Kittypet",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "trinket_rescue.png",
	wield_image = "trinket_rescue.png"
})