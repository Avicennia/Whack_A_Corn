local thismod = minetest.get_current_modname()

minetest.register_entity(thismod .. ":jumptool", {
	on_activate = function(self, data)
		self.item = data
		local obj = self.object
		obj:set_velocity({x = 0, y = 8, z = 0})
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
	end,
	on_step = function(self, dtime)
		if self.wac_tick then self:wac_tick(dtime) end

		local vel = self.object:get_velocity()
		if vel.y > 0 then return end

		local pos = self.object:get_pos()
		if self.jumpcorn then pos.y = pos.y + 0.5 end
		local node = minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		if def and not def.walkable then return end

		return self.object:remove()
	end,
	on_punch = function(self, puncher)
		if not puncher or not puncher.is_player
		or not puncher:is_player() then return end

		if self.item then
			local inv = puncher:get_inventory()
			for i = 1, inv:get_size("main") do
				if inv:get_stack("main", i):get_name() == self.item then return end
			end
			inv:add_item("main", self.item)
		end

		return self.object:remove()
	end
})

minetest.register_abm({
	label = "Spawn flying tools",
	nodenames = {"wac:resigned_grass"},
	interval = 1,
	chance = 2000,
	action = function(pos)
		return wac.pickrand(
			minetest.registered_items,
			function(_, v) return v.wac_tool_rarity end,
			function(name)
				return minetest.add_entity(pos, thismod .. ":jumptool", name)
			end
		)
	end
})