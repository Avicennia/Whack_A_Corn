local thismod = minetest.get_current_modname()
local wac = _G[thismod]


function wac.jump_smash(lua, obj)
	obj = obj or lua.object
	lua.jumpcorn = nil
	obj:set_properties({
		textures = {thismod .. ":smashed_egg"},
		collisionbox = {0, 0, 0, 0, 0, 0},
		automatic_rotate = 0
	})
	obj:set_yaw(0)
end

function wac.jump_whack(user, obj)
	local lua = obj and obj.get_luaentity and obj:get_luaentity()
	local corn = lua and lua.jumpcorn
	local ndef = corn and minetest.registered_items[corn]
	local quirk = ndef and ndef.wac_quirk
	if not quirk then return end
	local npos = obj:get_pos()

	if user then
		if ndef.description and nodecore and nodecore.show_touchtip then
			nodecore.show_touchtip(user, ndef.description)
		end

		local value = quirk.value or 1
		if type(value) == "function" then value = value(user, npos) end

		wac.player_score(user, wac.player_gameid(user), value)
		wac.scoreparticles(vector.add(user:get_pos(), user:get_look_dir()), value)
	end

	wac.jump_smash(lua, obj)

	if quirk.fx then quirk.fx(user, npos) end

	return true
end

minetest.register_entity(thismod .. ":jumpcorn", {
	on_activate = function(self, data)
		self.jumpcorn = data
		local obj = self.object
		obj:set_velocity({x = 0, y = 6.5, z = 0})
		obj:set_acceleration({x = 0, y = -8, z = 0})
		obj:set_yaw(math.random() * math.pi * 2)
		obj:set_properties({
			hp_max = 1,
			physical = false,
			collide_with_objects = false,
			collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			visual = "wielditem",
			visual_size = {x = 0.5, y = 0.5},
			textures = {data},
			spritediv = {x = 1, y = 1},
			initial_sprite_basepos = {x = 0, y = 0},
			is_visible = true,
			static_save = false,
			automatic_rotate = (math.random() - 0.5) * 10,
			glow = -1
		})
		local def = minetest.registered_items[data]
		local quirk = def and def.wac_quirk
		self.wac_tick = quirk and quirk.tick
	end,
	on_step = function(self, dtime)
		if self.wac_tick then self:wac_tick(dtime) end

		local vel = self.object:get_velocity()
		if vel.y > 0 then return end

		local pos = self.object:get_pos()
		if self.jumpcorn then pos.y = pos.y + 0.75 end
		local node = minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		if def and not def.walkable then return end

		if self.jumpcorn then return self.object:remove() end

		pos.y = pos.y + 0.5
		node = minetest.get_node(pos)
		if node.name == "air" then
			minetest.set_node(pos, {name = thismod .. ":smashed_egg"})
		end

		return self.object:remove()
	end,
	on_punch = function(self, puncher)
		if not puncher or not puncher.is_player
		or not puncher:is_player() then return end

		local pos = puncher:get_pos()
		pos.y = pos.y + puncher:get_properties().eye_height
		if vector.distance(pos, self.object:get_pos()) > 2 then return end

		wac.jump_whack(puncher, self.object)
	end
})

function wac.find_corns(pos, radius, each, ...)
	for _, obj in pairs(minetest.get_objects_inside_radius(pos, radius)) do
		local lua = obj.get_luaentity and obj:get_luaentity()
		if lua and lua.jumpcorn then each(lua, obj, ...) end
	end
end

minetest.register_abm({
	label = "Spawn flying eggcorns",
	nodenames = {"wac:resigned_grass"},
	interval = 1,
	chance = 100,
	action = wac.jumpspawner("jumpcorn", function(_, v) return v.wac_quirk and v.wac_quirk.rarity end)
})