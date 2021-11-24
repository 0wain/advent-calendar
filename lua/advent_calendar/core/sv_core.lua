function AdventCalendar.Core.PickReward()
	local rewardPool = {}

	for k, v in pairs(AdventCalendar.Config.Rewards) do
		for i=1, v.chance do
			table.insert(rewardPool, k)
		end
	end

	return AdventCalendar.Config.Rewards[table.Random(rewardPool)]
end

hook.Add("PlayerInitialSpawn", "AdventCalendar:NetworkCurrentDay", function(ply)
	AdventCalendar.OpenedDoors[ply:SteamID64()] = {}

	AdventCalendar.Core.GetOpenedDoors(ply, function(data)
		for k, v in pairs(data or {}) do
			AdventCalendar.OpenedDoors[ply:SteamID64()][v.door] = true
		end

		net.Start("AdventCalendar:CurrentDay")
			net.WriteInt(AdventCalendar.CurrentDay, 32)
			net.WriteTable(AdventCalendar.OpenedDoors[ply:SteamID64()])
		net.Send(ply)
	end)

end)

net.Receive("AdventCalendar:OpenToday", function(_, ply)
	if AdventCalendar.OpenedDoors[ply:SteamID64()][AdventCalendar.CurrentDay] then return end

	local reward = AdventCalendar.Core.PickReward()
	if not reward then return end

	if reward.canGet then
		while reward.canGet do
			if reward.canGet(ply) then break end
			reward = AdventCalendar.Core.PickReward()
		end
	end

	reward.action(ply)

	AdventCalendar.OpenedDoors[ply:SteamID64()][AdventCalendar.CurrentDay] = true
	AdventCalendar.Core.RegisterDoorOpening(ply, reward.name)
	AdventCalendar.Msg("Advent Calendar", Color(246, 70, 99), ply:Name().." has just opened "..reward.name)
end)
