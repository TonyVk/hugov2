Config						= {}
Config.InfiniteRepairs		= false -- Should one repairkit last forever?
Config.RepairTime			= 20 -- In seconds, how long should a repair take?
Config.IgnoreAbort			= true -- Remove repairkit from inventory even if user aborts repairs?
Config.AllowMecano			= false -- Allow mechanics to use this repairkit?

Config.ServiceExtensionOnEscape	= 0
Config.ServiceLocation = {x =  893.95, y = -286.81, z = 65.1}
Config.ReleaseLocation	= {x = 914.78, y = -316.19, z = 66.2}
Config.ServiceLocations = {
	{ type = "gardening", coords = vector3(888.42, -272.0, 66.59) },
	{ type = "gardening", coords = vector3(867.02, -277.0, 65.59) },
	{ type = "gardening", coords = vector3(876.52, -291.6, 65.59) },
	{ type = "gardening", coords = vector3(885.62, -279.9, 65.59) },
	{ type = "cleaning", coords = vector3(910.66, -296.97, 65.59) },
	{ type = "cleaning", coords = vector3(907.46, -286.67, 65.59) },
	{ type = "cleaning", coords = vector3(866.26, -285.67, 65.59) },
	{ type = "cleaning", coords = vector3(880.16, -288.17, 65.59) },
	{ type = "cleaning", coords = vector3(872.56, -282.67, 65.59) },
}
Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 146, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 119, ['pants_1']  = 3,
			['pants_2']  = 7,   ['shoes_1']  = 12,
			['shoes_2']  = 12,  ['chain_1']  = 0,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 120,  ['pants_1'] = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}

Config.deformationMultiplier = -1					-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch. Visual damage does not sync well to other players.
Config.deformationExponent = 0.4					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
Config.collisionDamageExponent = 0.6				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

Config.damageFactorEngine = 35.0					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
Config.damageFactorBody = 25.0					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
Config.damageFactorPetrolTank = 32.0				-- Sane values are 1 to 200. Higher values means more damage to vehicle. A good starting point is 64
Config.engineDamageExponent = 0.6					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
Config.weaponsDamageMultiplier = 2.00				-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
Config.degradingHealthSpeedFactor = 7				-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
Config.cascadingFailureSpeedFactor = 12.0			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

Config.degradingFailureThreshold = 600.0			-- Below this value, slow health degradation will set in
Config.cascadingFailureThreshold = 300.0			-- Below this value, health cascading failure will set in
Config.engineSafeGuard = 200.0					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

Config.torqueMultiplierEnabled = true				-- Decrease engine torque as engine gets more and more damaged

Config.limpMode = false							-- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
Config.limpModeMultiplier = 0.15					-- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

Config.preventVehicleFlip = true					-- If true, you can't turn over an upside down vehicle

Config.sundayDriver = false						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
Config.sundayDriverAcceleratorCurve = 7.5			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
Config.sundayDriverBrakeCurve = 5.0				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

Config.displayBlips = false						-- Show blips for mechanics locations

Config.compatibilityMode = false					-- prevents other scripts from modifying the fuel tank health to avoid random engine failure with BVA 2.01 (Downside is it disabled explosion prevention)

Config.randomTireBurstInterval = 0				-- Number of minutes (statistically, not precisely) to drive above 22 mph before you get a tire puncture. 0=feature is disabled


-- Class Damagefactor Multiplier
-- The damageFactor for engine, body and Petroltank will be multiplied by this value, depending on vehicle class
-- Use it to increase or decrease damage for each class

Config.classDamageMultiplier = {
	[0] = 	1.0,		--	0: Compacts
			1.0,		--	1: Sedans
			1.0,		--	2: SUVs
			1.0,		--	3: Coupes
			1.0,		--	4: Muscle
			1.0,		--	5: Sports Classics
			1.0,		--	6: Sports
			1.0,		--	7: Super
			0.25,		--	8: Motorcycles
			0.7,		--	9: Off-road
			0.25,		--	10: Industrial
			1.0,		--	11: Utility
			1.0,		--	12: Vans
			1.0,		--	13: Cycles
			0.5,		--	14: Boats
			1.0,		--	15: Helicopters
			1.0,		--	16: Planes
			1.0,		--	17: Service
			0.75,		--	18: Emergency
			0.75,		--	19: Military
			1.0,		--	20: Commercial
			1.0			--	21: Trains
}

Config.Locale				= 'hr'