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
		if(n >= 1)then
		minetest.punch_node(pos)
		else
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
	label = "Kill them! Kill them All!",
	nodenames = {"wae:sadistic_eggcorn"},
	interval = 3.0,
	chance = 1,
	action = function(pos, node)
	for k in ipairs(wae.playurns)do
	minetest.chat_send_all(minetest.serialize(wae.nameiter(wae.playurns[k],wae.boundchk(wae.playurns))))
	minetest.chat_send_all(minetest.serialize(wae.tabcomp(wae.playurns,wae.boundchk(wae.playurns))))
	minetest.chat_send_all(minetest.serialize(wae.tabtfchk(wae.nameiter(wae.playurns[k],wae.boundchk(wae.playurns)))))
	end
	minetest.chat_send_all("--------------BLANK---------------")
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
			for _,v in ipairs(wae.attends)do
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
			minetest.chat_send_all(minetest.serialize(wae.attends))
		end
	}
)