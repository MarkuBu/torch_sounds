
local torch_sounds = {}


local function torch_on(pos)
	local hpos = minetest.hash_node_position(pos)
	local torch = torch_sounds[hpos]
	if not torch then
		torch = {}
		torch_sounds[hpos] = torch
		torch.handle = minetest.sound_play("torch_burning",
				{pos=pos, max_hear_distance=5, gain=0.2, loop=true})
		torch.timer = minetest.get_node_timer(pos)
		torch.timer:start(5.0)
	end
	--print(dump(minetest.get_node(pointed_thing.above)),dump(node), dump(pos), dump(torch_sounds))
end


local function torch_off(pos)
	local hpos = minetest.hash_node_position(pos)
	local torch = torch_sounds[hpos]
	if torch.handle then
		minetest.sound_stop(torch.handle)
	end
	torch_sounds[hpos] = nil
end

local function torch_timeout(pos, elapsed)
	local hpos = minetest.hash_node_position(pos)
	local torch = torch_sounds[hpos]
	if torch.handle then
		print("Timer")
	end
end

minetest.override_item("default:torch", {
	sounds = {
		dug = {name = "place_torch", gain = 0.5},
		dig = {name = "place_torch", gain = 0.5},
		place = {name = "place_torch", gain = 0.5}
	},
	--~ on_construct = torch_on,

	--~ on_destruct = torch_off,

	--~ on_timer = torch_timeout,
})

minetest.override_item("default:torch_wall", {
	sounds = {
		dug = {name = "place_torch", gain = 0.5},
		dig = {name = "place_torch", gain = 0.5},
		place = {name = "place_torch", gain = 0.5}
	},
	--~ on_construct = torch_on,

	--~ on_destruct = torch_off,

	--~ on_timer = torch_timeout,
})


--[[
local count_torches = 0
minetest.register_lbm({
  name = "torches_sounds:ignite_torches",
  run_at_every_load = true,
  nodenames = {"default:torch", "default:torch_wall"},
  action = function(pos, node)
  local hpos = minetest.hash_node_position(pos)
  local torch = torch_sounds[hpos]
  if not torch then
    torch = {}
    torch_sounds[hpos] = torch
    -- minetest.after(math.random()+math.random(1,5), function(pos)
    torch.handle = minetest.sound_play("torch_burning",
    {pos=pos, max_hear_distance=1, gain=0.1, loop=true})
    --  end)
  end
  -- count_torches = count_torches + 1
  --  print(count_torches)
  --print(dump(minetest.get_node(pos)),dump(node), dump(pos), dump(torch_sounds))
  end,
})]]--
