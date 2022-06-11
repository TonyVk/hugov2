Config	=	{}

-- 0 (Explode After Countdown) | 1 (Explode once the veh reaches a set speed) | 2 (Remote Detonate on Key Press) | 3 (Detonate after veh is entered and timer ends) |
-- 4 (Detonate Immediately After the vehicle is entered)
Config.DetonationType = 4
Config.ProgressBarType = 1 -- 0 (Disable) | 1 (ProgressBars) | 2 (MythicProgressBars)
Config.UsingMythicNotifications = false -- false (Default ESX Notifications) | true (Mythic Notifications Enabled)
Config.TimeTakenToArm = 15 -- in seconds 
Config.TimeUntilDetonation = 10 -- in seconds
Config.TriggerKey = 47 -- If using type 2
Config.maxSpeed = 50 -- if using type 1
Config.Speed = 'KPH' -- if using type 2

--Gepek
 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 0


-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	bread = 125,
	water = 330,
	WEAPON_COMBATPISTOL = 1000, -- poid poir une munnition
	black_money = 1, -- poids pour un argent
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 180000, --Off-road
    [10] = 300000, --Industrial
    [11] = 70000, --Utility
    [12] = 100000, --Vans
    [13] = 0, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 300000, --Commercial
    [21] = 0, --Trains
}