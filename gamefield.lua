local thismod = minetest.get_current_modname()
local wac = _G[thismod]

local width = 15
local height = 4

function wac.gamefield_fits(pos, test)
	local bt = {}
	for name, def in pairs(minetest.registered_nodes) do
		if def.buildable_to then
			bt[name] = true
		end
	end
	local dpos = {}
	for y = 0, height - 1 do
		dpos.y = y
		for x = -width, width do
			dpos.x = x
			for z = -width, width do
				if test(x, y, z) then
					dpos.z = z
					local p = vector.add(pos, dpos)
					local node = minetest.get_node_or_nil(p)
					if (not node) or (not bt[node.name]) then
						return minetest.log(minetest.pos_to_string(p) .. node.name)
					end
				end
			end
		end
	end
	return true
end

function wac.gamefield_create(pos)
	local now = minetest.get_us_time() / 1000000
	local wacid = minetest.get_gametime() + now - math.floor(now)
	minetest.log("new whack-a-corn game " .. wacid .. " at " .. minetest.pos_to_string(pos))
	local dpos = {}
	for y = 0, height - 1 do
		dpos.y = y
		for x = -width, width do
			dpos.x = x
			for z = -width, width do
				dpos.z = z
				local p = vector.add(pos, dpos)
				if y > 0 then
					minetest.set_node(p, {name = "air"})
				elseif x == -width or x == width or z == -width or z == width then
					minetest.set_node(p, {name = thismod .. ":stone"})
					minetest.get_meta(p):set_float("wac_id", wacid)
				else
					minetest.set_node(p, {name = thismod .. ":resigned_grass"})
					minetest.get_meta(p):set_float("wac_id", wacid)
				end
			end
		end
	end
	minetest.add_particlespawner({
		amount = width * width * height,
		time = 1,
		minpos = {x=pos.x-width-0.5, y=pos.y+0.5, z=pos.z-width-0.5},
		maxpos = {x=pos.x+width+0.5, y=pos.y+height-0.5, z=pos.z+width+0.5},
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
		texture = "dev_tex.png",
		glow = 2
	})
end