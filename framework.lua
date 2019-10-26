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

wac.anynode = function(...)
	local t = {...}
	for _, name in ipairs(t) do
		if minetest.registered_nodes[name] then
			return name
		end
	end
	error("No nodes found from " .. table.concat(t, ", "))
end

wac.pickrand = function (list, rarityfunc, picked)
	local total = 0
	local items = {}
	for k, v in pairs(list) do
		local r = rarityfunc(k, v)
		if r and r > 0 then
			total = total + 1 / r
			items[#items + 1] = {k = k, v = v, p = 1 / r}
		end
	end
	total = total * math.random()
	for _, x in pairs(items) do
		total = total - x.p
		if total <= 0 then
			return picked(x.k, x.v, x.p)
		end
	end
end

-- Functions, Variables, and supporting shared references are stored here.
-- Just for the sake of slightly better separation of components.

--	--	--	--	--	--	PARTICLES	--	--	--	--	--	--

local function unpackrange(t)
	return {
		x = t.x or t[1] or 0,
		y = t.y or t[2] or 0,
		z = t.z or t[3] or 0
	}, {
		x = t.x or t[4] or t[1] or 0,
		y = t.y or t[5] or t[2] or 0,
		z = t.z or t[6] or t[3] or 0
	}
end
local function smarticles(def)
	if def.posrange then
		def.minpos, def.maxpos = unpackrange(def.posrange)
	end
	if def.offset then
		local min, max = unpackrange(def.offset)
		def.minpos = vector.add(def.minpos, min)
		def.maxpos = vector.add(def.maxpos, max)
	end
	if def.velrange then
		def.minvel, def.maxvel = unpackrange(def.velrange)
	end
	if def.accrange then
		def.minacc, def.maxacc = unpackrange(def.accrange)
	end
	if def.exprange then
		def.minexptime = def.exprange[1]
		def.maxexptime = def.exprange[2] or def.exprange[1]
	end
	if def.sizerange then
		def.minsize = def.sizerange[1]
		def.maxsize = def.sizerange[2] or def.sizerange[1]
	end
	return minetest.add_particlespawner(def)
end

wac.dimond_focused_lazer = function(pos, tex)
	if not pos then return end
	smarticles({
		amount = 29,
		time = 1,
		offset = pos,
		posrange = {0, -1, 0, 0, 10, 0},
		accrange = {-0.1, 0, -0.1, 0.1, 0, 0.1},
		exprange = {0.1, 0.5},
		sizerange = {40},
		vertical = true,
		texture = tex,
		glow = 2
	})
	minetest.sound_play("wac_lbeam", {
		pos = pos,
		gain = 1,
		max_hear_distance = 32
	})
end

wac.warr_ham = function(pos)
	minetest.sound_play("wac_warrhammerwave", {
		pos = pos,
		gain = 1,
		max_hear_distance = 32
	})
end

wac.tumbleparticles = function(pos,tex)
	smarticles({
		amount = 40,
		time = 2,
		offset = pos,
		posrange = {-0.8, 0, -0.8, 0.8, 0, 0.8},
		accrange = {0, 0.5, 0, 0.1, 1, 0.1},
		exprange = {0.3, 0.6},
		sizerange = {1, 5},
		collisiondetection = false,
		collision_removal = false,
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
			.. "=wac_fx_numeric.png\\^[verticalframe\\:11\\:" .. j
	end
	smarticles({
		amount = 25,
		time = 0.1,
		offset = pos,
		posrange = {-2, -0.5, -2, 2, 1.5, 2},
		exprange = {0.3, 0.6},
		sizerange = {2 * scale},
		texture = txr,
		glow = 2
	})
end

--	--	--	--	--	--	PARTICLES	--	--	--	--	--	--	^^