local thismod = minetest.get_current_modname()
local wac = _G[thismod]

--potsu:damas,
--
--
minetest.register_craftitem(thismod .. ":warrhammer",{
	description = "Warr Hammer",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "maultest.png",
	wield_image = "maultest.png",
	on_use = function(_, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
			wac.tumbleparticles(pointed_thing.under,"code_warr.png")
		end
	end,
	on_secondary_use = function(_, user)
			local pos = user:get_pos()
			wac.warr_ham(pos)
	end
})
minetest.register_craftitem(thismod .. ":codex_dimond",{
	description = "Codex Dimond",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "dimondomicon.png",
	wield_image = "dimondomicon.png",
	on_use = function(_, user, pointed_thing)
		local pos = user:get_pos()
		local delrad = wac.find_nodes(pos, {6, 6, 6}, {6, 6, 6}, "group:eggy")
		if(pointed_thing.under == nil)then
			if(delrad)then
				local i = math.random(1,#delrad)
			wac.smash(user:get_player_name(),nil,delrad[i])
			wac.dimond_focused_lazer(delrad[i],"banzer.png")
			end
		else
		wac.smash(user:get_player_name(),nil,pointed_thing.under)
		wac.dimond_focused_lazer(pointed_thing.under,"banzer.png")
		end
	end,
	on_secondary_use = function() end
})
minetest.register_craftitem(thismod .. ":jagged_flint",{
	description = "Jagged Flint Shard",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "flint.png",
	on_use = function(_, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem(thismod .. ":bec_de_corbin",{
	description = "Bec_de_Corbin",
	groups = {metal = 1, event = 2, thwacky = 2},
	inventory_image = "bdc.png",
	wield_image = "bdc.png",
	on_use = function(_, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem(thismod .. ":baseball_bat",{
	description = "Ol' Reliable",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "bbat.png",
	wield_image = "bbat.png",
	on_use = function(_, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem(thismod .. ":hostwand",{
    description = "Event Host Wand",
	inventory_image = "hostwand.png"
})
minetest.register_craftitem(thismod .. ":vampirewhip",{
    description = "Far Rach",
	inventory_image = "distancewhip.png",
	groups = {metal = 1, event = 2, thwacky = 4},
	range = 8,
	on_use = function(_, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		end
	end,
	on_secondary_use = function()
		minetest.chat_send_all("hi")
	end
})
minetest.register_craftitem(thismod .. ":paws",{
	description = "Paws of the Kittypet",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "trinket_rescue.png",
	wield_image = "trinket_rescue.png",
	on_use = function(_, user, pointed_thing)
		if(pointed_thing.under == nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		end
	end,
	on_secondary_use = function()
	end
})