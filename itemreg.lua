--potsu:damas, 
--
--
minetest.register_craftitem("wac:warrhammer",{
	description = "Warr Hammer",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "maultest.png",
	wield_image = "maultest.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		wac.tumbleparticles(pointed_thing.under,"code_warr.png")
		else end
	end,
	on_secondary_use = function(itemstack, user, pointed_thing)
			local pos = user:get_pos()
			wac.warr_ham(pos)
	end
})
minetest.register_craftitem("wac:codex_dimond",{
	description = "Codex Dimond",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "dimondomicon.png",
	wield_image = "dimondomicon.png",
	on_use = function(itemstack, user, pointed_thing)
		local pos = user:get_pos()
		local delrad = minetest.find_nodes_in_area({x=pos.x-6,y=pos.y-6,z=pos.z-6},{x=pos.x+6,y=pos.y+6,z=pos.z+6}, {"group:eggy"})
		if(pointed_thing.under == nil)then
			if(delrad)then
				local i = math.random(1,#delrad)
			wac.smash(user:get_player_name(),ppos,delrad[i])
			wac.dimond_focused_lazer(delrad[i],"banzer.png")
			else end
		else
		wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		wac.dimond_focused_lazer(pointed_thing.under,"banzer.png")
		end
	end,
	on_secondary_use = function(itemstack,user)
		
	end
})
minetest.register_craftitem("wac:jagged_flint",{
	description = "Jagged Flint Shard",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "flint.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
		elseif(pointed_thing.under ~= nil)then
				local ppos = user:get_pos()
				wac.smash(user:get_player_name(),ppos,pointed_thing.under)
			
		else end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wac:bec_de_corbin",{
	description = "Bec_de_Corbin",
	groups = {metal = 1, event = 2, thwacky = 2},
	inventory_image = "bdc.png",
	wield_image = "bdc.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
		elseif(pointed_thing.under ~= nil)then
				local ppos = user:get_pos()
				wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		else end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wac:baseball_bat",{
	description = "Ol' Reliable",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "bbat.png",
	wield_image = "bbat.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
		elseif(pointed_thing.under ~= nil)then
				local ppos = user:get_pos()
				wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		else end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wac:hostwand",{
    description = "Event Host Wand",
	inventory_image = "hostwand.png"
})
minetest.register_craftitem("wac:vampirewhip",{
    description = "Far Rach",
	inventory_image = "distancewhip.png",
	groups = {metal = 1, event = 2, thwacky = 4},
	range = 8,
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
		elseif(pointed_thing.under ~= nil)then
				local ppos = user:get_pos()
				wac.smash(user:get_player_name(),ppos,pointed_thing.under)
		else
		end
	end,
	on_secondary_use = function()
		minetest.chat_send_all("hi")
	end
})
minetest.register_craftitem("wac:paws",{
	description = "Paws of the Kittypet",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "pawpaw.png",
	wield_image = "trinket_rescue.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under == nil)then
		elseif(pointed_thing.under ~= nil)then
				local ppos = user:get_pos()
				wac.smash(user:get_player_name(),ppos,pointed_thing.under)
			else
		end
	end,
	on_secondary_use = function()
	end
})