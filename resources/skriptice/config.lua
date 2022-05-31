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

Config.Locale				= 'hr'