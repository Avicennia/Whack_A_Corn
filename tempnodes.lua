minetest.register_entity("wac:reverter", {
	initial_properties = {
		hp_max = 1,
		physical = false,
		collide_with_objects = false,
		collisionbox = { 0, 0, 0, 0, 0, 0 },
		is_visible = false,
	},
	get_staticdata = function(self)
		self.data = self.data or {}
		return minetest.serialize(self.data)
	end,
	on_activate = function(self, sdata)
		self.object:set_armor_groups({immortal = 1})
		self.data = sdata and minetest.deserialize(sdata) or {}
	end,
	on_step = function(self, dtime)
		local data = self.data or {}
		data.ttl = (data.ttl or 0) - dtime
		if data.ttl > 0 then return end

		for _, v in pairs(self.data.nodes or {}) do
			local node = minetest.get_node(v.pos)
			if node.name == v.temp then
				minetest.set_node(v.pos, {name = v.orig})
			end
		end
		self.object:remove()
	end
})

function wac.tempnodes(ttl, list)
	local centroid = {x = 0, y = 0, z = 0}
	local div = 0
	local did = {}
	for _, v in pairs(list) do
		local node = minetest.get_node(v.pos)
		if node.name == v.orig then
			minetest.set_node(v.pos, {name = v.temp})
			did[#did + 1] = v
			centroid = vector.add(centroid, v.pos)
			div = div + 1
		end
	end
	if div < 1 then return end
	centroid = vector.multiply(centroid, 1 / div)
	local ent = minetest.add_entity(centroid, "wac:reverter"):get_luaentity()
	ent.data = {ttl = ttl, nodes = did}
end