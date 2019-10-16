--
--
--

minetest.register_abm({
	label = "The Cycle of Egg and Corn Continues",
	nodenames = {"wac:resigned_grass"},
	interval = 0.5,
	chance = 100,
	action = function(pos, node)
		local n = math.random(1,10);
		if(n >= 1)then
		minetest.punch_node(pos)
		else
		end
		if(minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "wac:victorious_eggcorn")then
			minetest.remove_node({x=pos.x,y=pos.y+1,z=pos.z})
			minetest.set_node({x=pos.x+1,y=pos.y+1,z=pos.z},{name = "wac:"..wac.array_rand(wac.quirks).."_eggcorn"})
		end
	end

})
minetest.register_abm({
	label = "To bring eggs again",
	nodenames = {"group:eggy"},
	interval = 2.0,
	chance = 4,
	action = function(pos, node)
		if(minetest.get_node({x=pos.x,y=pos.y,z=pos.z}).name == "wac:victorious_eggcorn")then
			minetest.remove_node({x=pos.x,y=pos.y,z=pos.z})
			minetest.punch_node({x=pos.x+1,y=pos.y,z=pos.z})
			minetest.punch_node({x=pos.x-1,y=pos.y,z=pos.z})
			minetest.punch_node({x=pos.x,y=pos.y,z=pos.z+1})
			minetest.punch_node({x=pos.x,y=pos.y,z=pos.z-1})
		end
	end

})
minetest.register_abm({
	label = "indicator",
	nodenames = {"wac:sadistic_eggcorn"},
	interval = 3.0,
	chance = 1,
	action = function(pos, node)	
		wac.boundchk(wac.playurns)
		wac.ttris(wac.attends,wac.boundchk(wac.playurns))
		minetest.chat_send_all(minetest.serialize(wac.attends))
		for _,v in pairs(wac.attends)do
		wac.duptrunc(wac.dupchk(v,wac.attends),wac.attends)
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


minetest.register_chatcommand("ckscore",
	{
		description = "Check player scores", 
		privs = {interact=true},
		func = function(name, param)
			for _,v in ipairs(wac.attends)do
				local pmeta = v and minetest.get_player_by_name(v):get_meta()
				minetest.chat_send_player(name,v)
				minetest.chat_send_player(name,pmeta:get_int("score"))
			end

			return true
			end
	}
)
minetest.register_chatcommand("ckattends",
	{
		description = "Check current attendees", 
		privs = {interact=true},
		func = function(name, param)
			minetest.chat_send_all(minetest.serialize(wac.attends))
		end
	}
)
minetest.register_chatcommand("score;rs;all",
	{
		description = "Sets all scores to zero", 
		privs = {interact=true},
		func = function(name, param)
			minetest.chat_send_all("All scores reset!")
			for _,v in pairs(wac.playurns)do
				local player = minetest.get_player_by_name(v)
				local pmeta = player:get_meta()
				pmeta:set_int("score",0)
			end
		end
	}
)
minetest.register_chatcommand("board;stop",
	{
		description = "Stops eggcorn spawning on board", 
		privs = {interact=true},
		func = function(name, param)
			minetest.chat_send_all("Game Paused!")
			local player = minetest.get_player_by_name(name)
			local ppos = player:get_pos()
			local stat = minetest.find_nodes_in_area({x=ppos.x-25,y=ppos.y,z=ppos.z-25},{x=ppos.x+25,y=ppos.y+16,z=ppos.z+25},"wac:sadistic_eggcorn")
			local pstat = stat[1]
			for _,v in pairs(minetest.find_nodes_in_area({x=pstat.x-25,y=pstat.y-4,z=pstat.z-25},{x=pstat.x+25,y=pstat.y-20,z=pstat.z+25},"wac:resigned_grass"))do
				minetest.set_node(v,{name = "wac:resigned_grass_inert"})
			end
		end
	}
)
minetest.register_chatcommand("board;start",
	{
		description = "Starts eggcorn spawning on board", 
		privs = {interact=true},
		func = function(name, param)
			minetest.chat_send_all("Game Paused!")
			local player = minetest.get_player_by_name(name)
			local ppos = player:get_pos()
			local stat = minetest.find_nodes_in_area({x=ppos.x-25,y=ppos.y,z=ppos.z-25},{x=ppos.x+25,y=ppos.y+16,z=ppos.z+25},"wac:sadistic_eggcorn")
			local pstat = stat[1]
			for _,v in pairs(minetest.find_nodes_in_area({x=pstat.x-25,y=pstat.y-4,z=pstat.z-25},{x=pstat.x+25,y=pstat.y-20,z=pstat.z+25},"wac:resigned_grass_inert"))do
				minetest.set_node(v,{name = "wac:resigned_grass"})
			end
		end
	}
)