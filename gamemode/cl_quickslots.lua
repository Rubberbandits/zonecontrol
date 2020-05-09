kingston = kingston or {}
kingston.quickslot = kingston.quickslot or {}
kingston.quickslot.binds = kingston.quickslot.binds or {}

function kingston.quickslot.use(key)
	local data = kingston.quickslot.is_bound(key)
	if !data then return end
	
	data:BindUsed()
end

function kingston.quickslot.get_binds()
	return kingston.quickslot.binds
end

function kingston.quickslot.is_bound(key)
	for k,v in next, kingston.quickslot.get_binds() do
		if v.key == key then
			return v
		end
	end
end

function kingston.quickslot.set_bind(index, key)
	kingston.quickslot.binds[index].key = key
end

function kingston.quickslot.create_bind(data)
	kingston.quickslot.binds[#kingston.quickslot.binds + 1] = data
end

local function get_quickslot_press(ply, key)
	if !IsFirstTimePredicted() then return end
	
	kingston.quickslot.use(key)
end
hook.Add("PlayerButtonUp", "STALKER.GetQuickslotPress", get_quickslot_press)

local function remove_bind_items()
	for k,v in next, kingston.quickslot.binds do
		if v.BoundItem then
			v.BoundItem = nil
		end
	end
end
hook.Add("CharacterLoaded", "STALKER.RemoveBindItems", remove_bind_items)

if !kingston.quickslot.binds_created then
	for i = 1, 4 do
		local bind = {
			BindUsed = function(bind)
				local item = bind.BoundItem
				if !item then return end
				if !item.QuickUse then return end
				
				item:QuickUse()
			end,
		}
		kingston.quickslot.create_bind(bind)
	end
	
	kingston.quickslot.binds_created = true
end