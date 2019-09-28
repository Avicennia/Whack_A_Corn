-- Functions, Variables, and supporting shared references are stored here.
-- Just for the sake of slightly better separation of components.

wae.array_rand = function(t)
	math.random(1,#t);math.random(1,#t);local res = math.random(1,#t)
	return t[res]
end

wae.spewparticles = function(pos,tex)
	minetest.add_particlespawner({
		amount = 4,
		time = 1,
		minpos = {x=pos.x-0.98, y=pos.y+0.98, z=pos.z-0.98},
		maxpos = {x=pos.x+0.98, y=pos.y+0.98, z=pos.z+0.98},
		minvel = {x=0.1, y=1, z=0.1},
		maxvel = {x=0.2, y=3, z=0.2},
		minacc = {x=0, y=0, z=0},
		maxacc = {x=0.1, y=0.4, z=0.1},
		minexptime = 1,
		maxexptime = 4,
		minsize = 1,
		maxsize = 2,
		collisiondetection = false,
		collision_removal = false,
		vertical = false,
		texture = tex,
		glow = 2
	})
end
wae.dimond_focused_lazer = function(pos,tex)
	minetest.add_particlespawner({
		amount = 29,
		time = 1,
		minpos = {x=pos.x, y=pos.y+10, z=pos.z},
		maxpos = {x=pos.x, y=pos.y-1, z=pos.z},
		minvel = {x=0.01, y=0, z=0.01},
		maxvel = {x=0.02, y=0, z=0.02},
		minacc = {x=0, y=0, z=0},
		maxacc = {x=0.1, y=0.4, z=0.1},
		minexptime = 0.1,
		maxexptime = 0.5,
		minsize = 40,
		maxsize = 40,
		collisiondetection = false,
		collision_removal = false,
		vertical = false,
		texture = tex,
		glow = 2
	})
end
wae.tumbleparticles = function(pos,tex)
	minetest.add_particlespawner({
		amount = 40,
		time = 2,
		minpos = {x=pos.x-0.8, y=pos.y, z=pos.z-0.8},
		maxpos = {x=pos.x+0.8, y=pos.y, z=pos.z+0.8},
		minvel = {x=0, y=0, z=0},
		maxvel = {x=0, y=0, z=0},
		minacc = {x=0, y=0.5, z=0},
		maxacc = {x=0.1, y=1, z=0.1},
		minexptime = 0.3,
		maxexptime = 0.6,
		minsize = 1,
		maxsize = 5,
		collisiondetection = false,
		collision_removal = false,
		vertical = false,
		texture = tex,
		glow = 2
	})
end
wae.eggeffect_entomb = function(name, dur)
	local pos = minetest.get_player_by_name(name):get_pos()
	local airfield = minetest.find_nodes_in_area({x=pos.x-1,y=pos.y,z=pos.z-1},{x=pos.x+1,y=pos.y+3,z=pos.z+1},{name = "air"})
	for k,v in ipairs(airfield) do
		minetest.set_node(v, {name = "default:stone" or "nc_terrain:stone"})
	end
	minetest.after(dur, function() for k,v in pairs(minetest.find_nodes_in_area({x=pos.x-1,y=pos.y,z=pos.z-1},{x=pos.x+1,y=pos.y+3,z=pos.z+1},{name = "default:stone"})) do 
	minetest.remove_node(v)end end)
	end
wae.eggeffect_deluge = function(name, dur)
	local pos = minetest.get_player_by_name(name):get_pos()
	local airfield = minetest.find_nodes_in_area({x=pos.x,y=pos.y+4,z=pos.z},{x=pos.x,y=pos.y+3,z=pos.z},{name = "air"})
	for k,v in ipairs(airfield) do
		minetest.set_node(v, {name = "default:water_source" or "nc_terrain:water_source"})
	end
	minetest.after(dur, function() for k,v in pairs(minetest.find_nodes_in_area({x=pos.x-1,y=pos.y,z=pos.z-1},{x=pos.x+1,y=pos.y+5,z=pos.z+1},{name = "default:water_source"})) do 
	minetest.remove_node(v)end end)
	end
wae.bookban = function(tab,node)
	
end
wae.eggsmash = function(user, pointed_thing, itemstack)
	local ppos = user:get_pos()
	local pmeta = user:get_meta()
	local noi = minetest.get_node(pointed_thing.under)
	local nodename = noi.name
	if(nodename == "wae:"..wae.quirks[1].."_eggcorn")then
		pmeta:set_int("score",pmeta:get_int("score")+1)
		minetest.chat_send_all(user:get_player_name())
		minetest.chat_send_all(pmeta:get_int("score"))
	elseif(nodename == "wae:"..wae.quirks[2].."_eggcorn")then
		wae.eggeffect_deluge(user:get_player_name(),4)
	
	elseif(nodename == "wae:"..wae.quirks[3].."_eggcorn")then
		pmeta:set_int("score",pmeta:get_int("score")+2)
		minetest.chat_send_all(pmeta:get_int("score"))
	elseif(nodename == "wae:"..wae.quirks[4].."_eggcorn")then
		pmeta:set_int("score",pmeta:get_int("score")+1)
		wae.eggeffect_entomb(user:get_player_name(),3)
	elseif(nodename == "wae:"..wae.quirks[5].."_eggcorn")then
		
		for k,v in ipairs(minetest.find_nodes_in_area({x=ppos.x-8,y=ppos.y,z=ppos.z-8},{x=ppos.x+8,y=ppos.y,z=ppos.z+8},"group:eggy")) do
			minetest.remove_node(v)
		end
		pmeta:set_int("score",pmeta:get_int("score")+1)
	elseif(nodename == "wae:"..wae.quirks[6].."_eggcorn")then
		pmeta:set_int("score",pmeta:get_int("score")+3)
		minetest.chat_send_all(pmeta:get_int("score"))
	elseif(nodename == "wae:"..wae.quirks[7].."_eggcorn")then
		pmeta:set_int("score",pmeta:get_int("score")+math.random(1,6))
		minetest.chat_send_all(pmeta:get_int("score"))
	end
	minetest.set_node(pointed_thing.under, {name = "wae:smashed_egg"})
end