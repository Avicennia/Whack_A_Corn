local thismod = minetest.get_current_modname()
local wac = _G[thismod]

wac.find_nodes = function(pos, min, max, ...)
	min = {
		x = pos.x - (min.x or min[1] or 0),
		y = pos.y - (min.y or min[2] or 0),
		z = pos.z - (min.z or min[3] or 0)
	}
	max = {
		x = pos.x + (max.x or max[1] or 0),
		y = pos.y + (max.y or max[2] or 0),
		z = pos.z + (max.z or max[3] or 0)
	}
	return minetest.find_nodes_in_area(min, max, ...)
end

-- Functions, Variables, and supporting shared references are stored here.
-- Just for the sake of slightly better separation of components.

wac.array_rand = function(t)
	math.random(1,#t);math.random(1,#t);local res = math.random(1,#t)
	return t[res]
end
--	--	--	--	--	--	PARTICLES	--	--	--	--	--	--
wac.spewparticles = function(pos,tex)
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
wac.dimond_focused_lazer = function(pos,tex)
	if(pos)then
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
			vertical = true,
			texture = tex,
			glow = 2
		})
		minetest.sound_play({name ="lbeam"},{
			pos = pos,
			gain = 50.0, -- default
			max_hear_distance = 32,
		})
	end
end
wac.warr_ham = function(pos)
	minetest.sound_play({name ="warrhammerwave"},{
		pos = pos,
		gain = 50.0, -- default
		max_hear_distance = 32,})
end
wac.tumbleparticles = function(pos,tex)
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

wac.anynode = function(...)
	local t = {...}
	for _, name in ipairs(t) do
		if minetest.registered_nodes[name] then
			return name
		end
	end
	error("No nodes found from " .. table.concat(t, ", "))
end

--	--	--	--	--	--	PARTICLES	--	--	--	--	--	--	^^

wac.bookban = function()

end

--	--	--	--	--	--	PLAYER RECOGNITION	--	--	--	--	--	--
wac.boundchk = function(names)
	-- ^ Function to check for players that meet criteria to be considered "present" in the play area.
	-- Two tables, one to store positions of players, and one to store the name of the node beneath them;
	-- players that have [wac:resigned_grass] beneath them, under typical circumstances should only be those in
	-- an ongoing game or playfield, as this node is intended only to be spawned in for the playfield.
	local post = {}
	local post_nunder = {}
	local nb = {}
	for _,v in ipairs(names)do
		-- Not explicitly visible here is that names and positions should be synchronized
		-- with the numerical order of the array storing player names upon login in [init.lua].
		local vp = minetest.get_player_by_name(v):get_pos()
		local e = minetest.get_node({x=vp.x,y=vp.y-1,z=vp.z}).name
		table.insert(post,vp)
		table.insert(post_nunder,e)
	end
	--minetest.chat_send_all(minetest.serialize(post))
	--minetest.chat_send_all(minetest.serialize(post_nunder))
	for n = 1, #names, 1 do
		if(post_nunder[n] == thismod .. ":resigned_grass")then
				table.insert(nb,n)
				table.insert(nb,names[n])
			else for k,v in ipairs(wac.attends)do
				if(names[n] == v) then
					table.remove(wac.attends, k)
					minetest.chat_send_all("Player "..names[n].." went out of bounds!")
					local pmeta = minetest.get_player_by_name(v):get_meta()
					pmeta:set_int("score",0)
				end
			end
		end
	end
	return nb -- Returns a table containing an index and name for every player with [wac:resigned_grass] under their feet.
end
wac.nameiter = function(name,tab) -- Returns a table of BOOL values after comparing "name" to
                                  -- every value indexed in table <tab>.
	local tablerv = {}
	for n=1, #tab, 1 do
		if(tab[n] == name)then
			table.insert(tablerv,true)
		else table.insert(tablerv,false)
		end
	end
	return tablerv
end
wac.tabcomp = function(tl,td)
	local rv = 0
	if(#td/2 == #tl)then
		rv = "equal"
	elseif(#td/2 > #tl)then
		rv = "larger"
	elseif(#td/2 < #tl)then
		rv = "smaller"
	else rv[1] = "und" end
return rv
end
wac.tappend = function(tl,td)
	for n=2, #td, 2 do
		table.insert(tl,td[n])
	end
end
wac.ttris = function(tl,td) -- Checks for name duplicates before adding the names from a table to a legacy table [tl]
	local n = 0
	for _,v in ipairs(td) do
		if(v ~= tl[n] and type(v) == "string")then
			n = n + 1
			tl[n] = v
		end
	end
end

wac.tabtfchk = function(tab)
	local numtab = {}
	for n=1, #tab, 1 do
		if(tab[n] == true)then
			table.insert(numtab,n)
		else table.insert(numtab, 0)
		end
	end
	return numtab
end
function wac.dupchk(name,tab)
	local rv = {name,0,"white"}
	for _,v in ipairs(tab) do
		if(v == name and rv[2] == 0)then
			rv[2] = rv[2] + 1
		elseif(v == name and rv[2] > 1)then
			rv[2] = rv[2] + 1; rv[3] = "yellow"
		end
	end
	return rv
end
function wac.duptrunc(tn,tl)
	if(tn[2] > 1 and tn[3] == "yellow")then
		for _ = 1, tn[2]-1 do
			for k,v in ipairs(tl)do
				if(v == tn[1])then
					table.remove(tl,k)
					minetest.chat_send_all("Player "..tn[1].." duplicate name removed.")
				end
			end
		end
	end
end

--	--	--	--	--	--	PLAYER RECOGNITION	--	--	--	--	--	--