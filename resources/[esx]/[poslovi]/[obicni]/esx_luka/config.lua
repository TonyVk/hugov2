
Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 10
Config.TruckPrice	= 0
Config.Locale       = 'hr'
Config.Posao 		= "luka"

Config.Oprema = {
	Koord = vector3(947.9345703125, -2935.1958007812, 5.901162147522),
	Heading = 180.79
}

Config.SpawnVozilaPed = {
	Koord = vector3(936.14404296875, -2936.7863769531, 5.901162147522),
	Heading = 89.33
}

Config.ZaposliSe = {
	Pos   = vector3(947.9345703125, -2935.1958007812, 5.901162147522),
	Size  = {x = 3.0, y = 3.0, z = 3.0},
	Color = {r = 101, g = 65, b = 104},
	Type  = 29,
	Sprite = 68,
	BColor = 47
}

Config.Controls = {
	["direction"] = {
	  codes = {175,174,173,172},
	  text = "Smjer",
	},
	["height"] = {
	  codes = {207,208},
	  text = "Visina",
	}
}

Config.Uniforms = {
	EUP = false,
	uniforma = { 
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 0,
			['torso_1'] = 89,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 36,   ['pants_2'] = 0,
			['shoes'] = 35,
			['helmet_1'] = 5,  ['helmet_2'] = 0,
			['glasses_1'] = 19,  ['glasses_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 0,
			['torso_1'] = 0,   ['torso_2'] = 11,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 68,
			['pants_1'] = 30,   ['pants_2'] = 2,
			['shoes'] = 26,
			['helmet_1'] = 19,  ['helmet_2'] = 0,
			['glasses_1'] = 15,  ['glasses_2'] = 0
		}
	},
	EUPuniforma = { 
		male = {
			ped = 'mp_m_freemode_01',
			props = {
				{ 0, 61, 2 },
				{ 1, 16, 10 },
				{ 2, 0, 0 },
				{ 6, 0, 0 },
			},
			components = {
				{ 1, 1, 1 },
				{ 11, 3, 6 },
				{ 3, 64, 1 },
				{ 10, 1, 1 },
				{ 8, 91, 1 },
				{ 4, 50, 4 },
				{ 6, 52, 4 },
				{ 7, 1, 1 },
				{ 9, 4, 3 },
				{ 5, 49, 1 },
			}
		},
		female = {
			ped = 'mp_f_freemode_01',
			props = {
				{ 0, 61, 1 },
				{ 1, 0, 0 },
				{ 2, 0, 0 },
				{ 6, 0, 0 },
			},
			components = {
				{ 1, 1, 1 },
				{ 11, 118, 1 },
				{ 3, 82, 1 },
				{ 10, 1, 1 },
				{ 8, 55, 1 },
				{ 4, 5, 2 },
				{ 6, 27, 1 },
				{ 7, 1, 1 },
				{ 9, 6, 3 },
				{ 5, 49, 1 },
			}
		}
	}
}

mLibs = exports["meta_libs"]