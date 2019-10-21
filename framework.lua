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

wac.scoreparticles = function(pos, score)
	score = tostring(score)
	local scale = #score + 1
	local txr = "[combine:" .. (scale * 8) .. "x" .. (scale * 6)
	for i = 0, #score do
		local j = (i == 0) and 0 or (tonumber(score:sub(i, i)) + 1)
		txr = txr .. ":" .. (i * 8) .. "," .. (#score * 3)
			.. "=wac_numeric.png\\^[verticalframe\\:11\\:" .. j
	end
	minetest.add_particlespawner({
		amount = 25,
		time = 0.1,
		minpos = {x=pos.x-2, y=pos.y, z=pos.z-2},
		maxpos = {x=pos.x+2, y=pos.y+2, z=pos.z+2},
		minvel = {x=0, y=0, z=0},
		maxvel = {x=0, y=0, z=0},
		minacc = {x=0, y=0.5, z=0},
		maxacc = {x=0.1, y=1, z=0.1},
		minexptime = 0.3,
		maxexptime = 0.6,
		minsize = 2 * scale,
		maxsize = 2 * scale,
		collisiondetection = false,
		collision_removal = false,
		vertical = false,
		texture = txr,
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

--	--	--	--	--	--	PLAYER RECOGNITION	--	--	--	--	--	--

--	--	--	--	--	--	PLAYER RECOGNITION	--	--	--	--	--	--