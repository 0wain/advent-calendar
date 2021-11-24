-- The order in which the doors are shown, to keep things random and fun!
AdventCalendar.Config.DoorOrder = {15, 19, 21, 5, 8, 7, 2, 3, 9, 11, 1, 17, 18, 20, 24, 13, 22, 6, 25, 16, 12, 23, 4, 14, 10}

-- The title for the panel
AdventCalendar.Config.Title = "Christmas Advent Calendar"

-- All the possible rewards
AdventCalendar.Config.Rewards = {
	{
		name = "Coal", -- The name of the reward
		action = function(ply) -- The action
			-- Do nothing
		end,
		chance = 35 -- How many times to add it to the prize pool. The higher the number the better the chance
	},
	{
		name = "Explosion",
		action = function(ply)
			local vPoint = ply:GetPos()
			local effectdata = EffectData()
			effectdata:SetStart(vPoint)
			effectdata:SetOrigin(vPoint)
			effectdata:SetScale(1)
			util.Effect("Explosion", effectdata)
			
			ply:Kill()
		end,
		chance = 25
	},
	{
		name = "$15,000",
		action = function(ply)
			ply:addMoney(15000)
		end,
		chance = 40
	},
	{
		name = "$40,000",
		action = function(ply)
			ply:addMoney(40000)
		end,
		chance = 25
	},
	{
		name = "Crossbow",
		action = function(ply)
			ply:Give("weapon_crossbow")
		end,
		chance = 15
	},
	{
		name = "1,000,000 Health Points",
		action = function(ply)
			ply:SetHealth(1000000)
		end,
		chance = 1
	}
}
