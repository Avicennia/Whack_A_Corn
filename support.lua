--
--
--

minetest.register_abm({
	label = "The Cycle of Egg and Corn Continues",
	nodenames = {"wae:resigned_grass"},
	interval = 0.5,
	chance = 100,
	action = function(pos, node)
		local n = math.random(1,10);
		if(n >= 6)then
		minetest.punch_node(pos)
		elseif(minetest.get_node({{x=pos.x,y=pos.y+1,z=pos.z}}).name == "air")then 
			minetest.remove_node({x=pos.x,y=pos.y+1,z=pos.z})
		end
		if(minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "wae:victorious_eggcorn")then
			minetest.remove_node({x=pos.x,y=pos.y+1,z=pos.z})
			minetest.set_node({x=pos.x+1,y=pos.y+1,z=pos.z},{name = "wae:"..wae.array_rand(wae.quirks).."_eggcorn"})
		end
	end

})
minetest.register_abm({
	label = "To bring eggs again",
	nodenames = {"group:eggy"},
	interval = 2.0,
	chance = 4,
	action = function(pos, node)
		if(minetest.get_node({x=pos.x,y=pos.y,z=pos.z}).name == "wae:victorious_eggcorn")then
			minetest.remove_node({x=pos.x,y=pos.y,z=pos.z})
			minetest.punch_node({x=pos.x+1,y=pos.y,z=pos.z})
			minetest.punch_node({x=pos.x-1,y=pos.y,z=pos.z})
			minetest.punch_node({x=pos.x,y=pos.y,z=pos.z+1})
			minetest.punch_node({x=pos.x,y=pos.y,z=pos.z-1})
		end
	end

})
minetest.register_abm({
	label = "The Cycle of Egg and Corn Continues Yet again",
	nodenames = {"group:eggy"},
	interval = 0.5,
	chance = 50,
	action = function(pos, node)
		local n = math.random(1,10);
		if(n >= 2)then
		minetest.punch_node({x=pos.x,y=pos.y+1,z=pos.z})
		else
		end
	end

})
minetest.register_abm({
	label = "Poof away all the mess",
	nodenames = {"group:eggy"},
	interval = 2.0,
	chance = 40,
	action = function(pos, node)
		minetest.remove_node(pos)
	end

})
--[[minetest.register_abm({
	label = "Fake Construction temp ABM",
	nodenames = {"wae:resigned_grass"},
	interval = 3.0,
	chance = 0.5,
	action = function(pos, node)
		if(minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "air")then
			minetest.set_node({x=pos.x+1,y=pos.y,z=pos.z},{name = "wae:resigned_grass"})
		else minetest.chat_send_all("?")
		end
	end

})]]

minetest.register_chatcommand("ckscore",
	{
		description = "Check player scores", 
		privs = {interact=true},
		func = function(name, param)
			local pobjlist = minetest.get_connected_players()
			local namelist = {}
			local sclist = {}
			for k,v in pairs(pobjlist) do 
				table.insert(namelist,v:get_player_name())
			end
			for k,v in ipairs(namelist) do  
				minetest.chat_send_all(namelist[k])
				local pmeta = minetest.get_player_by_name(namelist[k]):get_meta()
				minetest.chat_send_all(pmeta:get_int("score"))
				end
			return true
			end
	}
)