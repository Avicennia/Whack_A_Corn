local thismod = minetest.get_current_modname()
local wac = _G[thismod]

function wac.scoreshow(player)
	local pl = player
	local pm = pl:get_meta()
	local sc = pm:get_int("score")
local hudscore = 
{
    hud_elem_type = "text",
    position = {x=0.5, y=0.5},
    name = "score",
    scale = {x = 20, y = 20},
    text = sc,
    number = 1,
    item = 1,
    direction = 0,
    alignment = {x=0, y=0},
    offset = {x=-40, y=-10},
    size = { x=200, y=200 },
}
return hudscore
end

function wac.scoremove(player)
	player:hud_remove(player:hud_add(wac.scoreshow(player)))
end
function wac.register_smasher(name, def)
	def.wac_smasher = true

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

	return minetest.register_craftitem(name, def)
end

--
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