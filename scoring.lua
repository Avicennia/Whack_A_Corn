local thismod = minetest.get_current_modname()
local wac = _G[thismod]

function wac.player_gameid(player)
	local pos = player:get_pos()
	for _ = 1, 4 do
		pos.y = pos.y - 1
		local id = minetest.get_meta(pos):get_float("wac_id")
		if id and id ~= 0 then return id end
	end
end


function wac.player_score(player, gameid, adjust)
	local key = "wac_score_" .. gameid
	local meta = player:get_meta()
	local score = meta:get_float(key)
	if adjust and adjust ~= 0 then
		score = score + adjust
		meta:set_float(key, score)
		wac.updatehuds()
	end
	return score
end

local huds = {}

local function updatehud(player, nums, names)
	local pname = player:get_player_name()
	local hud = huds[pname]
	if not hud then
		if names == "" and nums == "" then return end
		huds[pname] = {
			nums = nums,
			names = names,
			numid = player:hud_add({
				hud_elem_type = "text",
				position = {x=0, y=0.6},
				text = nums,
				number = 0xFFFF80,
				alignment = {x=-1, y=1},
				offset = {x=48, y=0}
			}),
			nameid = player:hud_add({
				hud_elem_type = "text",
				position = {x=0, y=0.6},
				text = names,
				number = 0xFFFF80,
				alignment = {x=1, y=1},
				offset = {x=52, y=0}
			})
		}
		return
	end
	if hud.nums ~= nums then
		hud.nums = nums
		player:hud_change(hud.numid, "text", nums)
	end
	if hud.names ~= names then
		hud.names = names
		player:hud_change(hud.nameid, "text", names)
	end
end

minetest.register_on_leaveplayer(function(player)
	huds[player:get_player_name()] = nil
end)

local endians = {["1"] = "st", ["2"] = "nd", ["3"] = "rd"}

function wac.updatehuds()
	local players = {}
	local games = {}
	for _, player in pairs(minetest.get_connected_players()) do
		local id = wac.player_gameid(player)
		if id then
			local g = games[id]
			if not g then
				g = {}
				games[id] = g
			end
			g[#g + 1] = {
				n = player:get_player_name(),
				s = wac.player_score(player, id)
			}
			players[player] = g
		else
			updatehud(player, "", "")
		end
	end
	for _, g in pairs(games) do
		table.sort(g, function(a, b) return a.s > b.s end)
		local pos = 0
		local ls = g[1].s + 1
		for _, e in ipairs(g) do
			if e.s < ls then
				ls = e.s
				pos = pos + 1
			end
			e.p = pos
		end
	end
	for player, game in pairs(players) do
		local pname = player:get_player_name()
		local nums = {}
		local names = {}
		for _, e in ipairs(game) do
			nums[#nums + 1] = e.s
			local t = e.n
			if e.n == pname then
				t = t .. " [=== " .. e.p
					.. (endians[tostring(e.p):sub(-1)] or "th")
					.. " ===]"
			end
			names[#names + 1] = t
		end
		updatehud(player, table.concat(nums, "\n"), table.concat(names, "\n"))
	end
end

local function autohud()
	minetest.after(1, autohud)
	wac.updatehuds()
end
autohud()