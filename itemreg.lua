--potsu:damas, 
--
--
minetest.register_craftitem("wae:warrhammer",{
	description = "Warr Hammer",
	groups = {metal = 1, thwacky = 2},
	inventory_image = "maultest.png",
	wield_image = "maultest.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under ~= nil)then
			local ppos = user:get_pos()
			local noi = minetest.get_node(pointed_thing.under)
			local nodename = noi.name
			wae.smash(user:get_player_name(),ppos,pointed_thing.under)
		wae.tumbleparticles(pointed_thing.under,"code_warr.png")
		else end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wae:codex_dimond",{
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
			wae.smash(user:get_player_name(),ppos,delrad[i])
			wae.dimond_focused_lazer(delrad[i],"banzer.png")
			else end
		else
		wae.smash(user:get_player_name(),ppos,pointed_thing.under)
		wae.dimond_focused_lazer(pointed_thing.under,"banzer.png")
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wae:jagged_flint",{
	description = "Jagged Flint Shard",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "flint.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under == nil)then
		else
		wae.eggsmash(user, pointed_thing, itemstack) 
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wae:bec_de_corbin",{
	description = "Bec_de_Corbin",
	groups = {metal = 1, event = 2, thwacky = 2},
	inventory_image = "bdc.png",
	wield_image = "bdc.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under == nil)then
		else
		wae.eggsmash(user, pointed_thing, itemstack)
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wae:baseball_bat",{
	description = "Ol' Reliable",
	groups = {metal = 1, event = 2, thwacky = 3},
	inventory_image = "bbat.png",
	wield_image = "bbat.png",
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under == nil)then
		else
		wae.eggsmash(user, pointed_thing, itemstack)
		end
	end,
	on_secondary_use = function()
	end
})
minetest.register_craftitem("wae:hostwand",{
    description = "Event Host Wand",
	inventory_image = "hostwand.png"
})
minetest.register_craftitem("wae:vampirewhip",{
    description = "Far Rach",
	inventory_image = "distancewhip.png",
	groups = {metal = 1, event = 2, thwacky = 4},
	range = 8,
	on_use = function(itemstack, user, pointed_thing)
		if(pointed_thing.under == nil)then
		else
		wae.eggsmash(user, pointed_thing, itemstack)
		end
	end,
	on_secondary_use = function()
		minetest.chat_send_all("hi")
	end
})