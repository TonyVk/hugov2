Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 5
Config.SpeedMultiplier = 3.6
Config.Locale          = 'hr'

Config.Prices = {
	dmv         = 200,
	drive       = 500,
	drive_bike  = 1000,
	drive_truck = 4000
}

Config.VehicleModels = {
	drive       = 'fiat600',
	drive_bike  = 'sanchez',
	drive_truck = 'mule3'
}

Config.SpeedLimits = {
	residence = 50,
	town      = 80,
	freeway   = 120
}

Config.Zones = {

	DMVSchool = {
		Pos   = vector3(229.951, 378.180, 105.041),
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = vector3(217.409, 377.75, 107.0),
		Heading = 165.0,
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = vector3(215.979, 373.06, 105.137),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('next_point_speed', Config.SpeedLimits['residence']), 5000)
		end
	},

	{
		Pos = vector3(213.71, 366.33, 105.70),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText(_U('stop_for_ped'), 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(5000)
				SetPedAsNoLongerNeeded(Pedara)
				FreezeEntityPosition(vehicle, false)
				DrawMissionText(_U('good_lets_cont'), 5000)
			end)
		end
	},

	{
		Pos = vector3(152.0, 365.90, 109.005),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = vector3(83.72, 350.230, 112.00),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('residence')

			Citizen.CreateThread(function()
				DrawMissionText(_U('good_turn_right'), 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(6000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText(_U('good_turn_right'), 5000)
			end)
		end
	},

	{
		Pos = vector3(183.82060241699, 422.88900756836, 116.47601318359),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},


	{
		Pos = vector3(21.644109725952, 467.00408935547, 144.18783569336),
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	

	{
		Pos = vector3(-342.76580810547, 485.97830200195, 110.78680419922), -- propusti
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = vector3(-114.47964477539, 426.45791625977, 111.17050170898), -- propusti
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = vector3(-38.002239227295, 278.33700561523, 103.77765655518), -- propusti
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = vector3(-202.74403381348, 264.24600219727, 90.104232788086), -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = vector3(-229.00816345215, 141.53797912598, 67.755897521973), -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = -251.0588684082, y = -24.996055603027, z = 47.554836273193}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = -97.632301330566, y = -103.97104644775, z = 55.829494476318}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = -41.129199981689, y = 15.070151329041, z = 70.010185241699}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 261.35177612305, y = -80.336372375488, z = 68.00577545166}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 377.89135742188, y = -123.63385009766, z = 63.092247009277}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 497.85827636719, y = 58.174831390381, z = 93.547706604004}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 381.83856201172, y = 135.09777832031, z = 101.09600067139}, -- crveno
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},


	{																			-- pjesak
		Pos = {x = 56.734359741211, y = 258.77877807617, z = 107.63293457031},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText(_U('stop_for_ped'), 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(5000)
				SetPedAsNoLongerNeeded(Pedara)
				FreezeEntityPosition(vehicle, false)
				DrawMissionText(_U('good_lets_cont'), 5000)
			end)
		end
	},


	{
		Pos = {x = 206.53721618652, y = 357.89456176758, z = 104.13980102539}, -- propusti
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(6000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 216.41, y = 372.491, z = 107.809},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('gratz_stay_alert'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 213.853, y = 390.09, z = 107.321},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}
