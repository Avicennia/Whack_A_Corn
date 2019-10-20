local thismod = minetest.get_current_modname()
local wac = _G[thismod]

--
--
--

minetest.register_abm({
	label = "indicator",
	nodenames = {thismod .. ":sadistic_eggcorn"},
	interval = 3.0,
	chance = 1,
	action = function()
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
	action = function(pos)
		minetest.remove_node(pos)
	end

})


minetest.register_chatcommand("ckscore",
	{
		description = "Check player scores",
		privs = {interact=true},
		func = function(name)
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
		func = function()
			minetest.chat_send_all(minetest.serialize(wac.attends))
		end
	}
)
minetest.register_chatcommand("score;rs;all",
	{
		description = "Sets all scores to zero",
		privs = {interact=true},
		func = function()
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
		func = function(name)
			minetest.chat_send_all("Game Paused!")
			local player = minetest.get_player_by_name(name)
			local ppos = player:get_pos()
			local stat = wac.find_nodes(ppos, {25, 0, 25}, {25, 16, 25},
				thismod .. ":sadistic_eggcorn")
			local pstat = stat[1]
			for _,v in pairs(wac.find_nodes(pstat, {25, 20, 25}, {25, -4, 25},
				thismod .. ":resigned_grass"))do
				minetest.set_node(v,{name = thismod .. ":resigned_grass_inert"})
			end
		end
	}
)
minetest.register_chatcommand("board;start",
	{
		description = "Starts eggcorn spawning on board",
		privs = {interact=true},
		func = function(name)
			minetest.chat_send_all("Game Paused!")
			local player = minetest.get_player_by_name(name)
			local ppos = player:get_pos()
			local stat = wac.find_nodes(ppos, {25, 0, 25}, {25, 16, 25},
				thismod .. ":sadistic_eggcorn")
			local pstat = stat[1]
			for _,v in pairs(wac.find_nodes(pstat, {25, 20, 25}, {25, -4, 35},
				thismod .. ":resigned_grass_inert"))do
				minetest.set_node(v,{name = thismod .. ":resigned_grass"})
			end
		end
	}
)