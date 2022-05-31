Config = {}

Config.JailPositions = {
	["Cell"] = { ["x"] = 1769.4444580078, ["y"] = 2495.3098144531, ["z"] = 45.846488952637, ["h"] = 120.04 }
}

Config.Cutscene = {
	["PhotoPosition"] = { ["x"] = 402.91567993164, ["y"] = -996.75970458984, ["z"] = -99.000259399414, ["h"] = 186.22499084473 },

	["CameraPos"] = { ["x"] = 402.88830566406, ["y"] = -1003.8851318359, ["z"] = -97.419647216797, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },

	["PolicePosition"] = { ["x"] = 402.91702270508, ["y"] = -1000.6376953125, ["z"] = -99.004028320313, ["h"] = 356.88052368164 }
}

Config.PrisonWork = {
	["DeliverPackage"] = { ["Pos"] = vector3(1027.2347412109, -3101.419921875, -38.999870300293), ["h"] = 267.89135742188 },

	["Packages"] = {
		[1] = { ["Pos"] = vector3(1003.6661987305, -3108.4221191406, -38.999866485596), ["state"] = true },
		[2] = { ["Pos"] = vector3(1006.0420532227, -3103.0024414063, -38.999866485596), ["state"] = true },
		[3] = { ["Pos"] = vector3(1015.7958374023, -3102.8337402344, -38.99991607666), ["state"] = true },
		[4] = { ["Pos"] = vector3(1012.8907470703, -3108.2907714844, -38.999912261963), ["state"] = true },
		[5] = { ["Pos"] = vector3(1018.2017822266, -3109.1982421875, -38.999897003174), ["state"] = true },
		[6] = { ["Pos"] = vector3(1018.0194091797, -3096.5700683594, -38.999897003174), ["state"] = true },
		[7] = { ["Pos"] = vector3(1015.6422119141, -3091.7392578125, -38.999897003174), ["state"] = true },
		[8] = { ["Pos"] = vector3(1010.7862548828, -3096.6135253906, -38.999897003174), ["state"] = true },
		[9] = { ["Pos"] = vector3(1005.7819824219, -3096.8415527344, -38.999897003174), ["state"] = true },
		[10] = { ["Pos"] = vector3(1003.4543457031, -3096.7048339844, -38.999897003174), ["state"] = true }
	}
}

Config.Teleports = {
	["Prison Work"] = { 
		["Pos"] = vector3(992.51770019531, -3097.8413085938, -38.995861053467), 
		["h"] = 81.15771484375, 
		["goal"] = { 
			"Jail" 
		} 
	},

	["Boiling Broke"] = { 
		["Pos"] = vector3(1847.7629394531, 2586.1491699219, 45.672050476074), 
		["h"] = 269.50, 
		["goal"] = { 
			"Security" 
		} 
	},

	["Jail"] = { 
		["Pos"] = vector3(1800.6979980469, 2483.0979003906, -122.68814849854), 
		["h"] = 271.75274658203, 
		["goal"] = { 
			"Prison Work", 
			"Security", 
			"Visitor" 
		} 
	},

	["Security"] = { 
		["Pos"] = vector3(1706.7625732422, 2581.0793457031, -69.407371520996), 
		["h"] = 267.72802734375, 
		["goal"] = { 
			"Jail",
			"Boiling Broke"
		} 
	},

	["Visitor"] = {
		["Pos"] = vector3(1699.7196044922, 2574.5314941406, -69.403930664063), 
		["h"] = 169.65020751953, 
		["goal"] = { 
			"Jail" 
		} 
	}
}