Config = {}

Config.Locale = 'en'

Config.serverLogo = 'https://i.imgur.com/AcgDL9f.png'

Config.font = {
	name 	= 'Montserrat',
	url 	= 'https://fonts.googleapis.com/css?family=Montserrat:300,400,700,900&display=swap'
}

Config.date = {
	format	 	= 'withHours',
	AmPm		= false
}

Config.voice = {

	levels = {
		default = 12.0,
		shout = 19.0,
		whisper = 1.0,
		current = 0
	},
	
	keys = {
		distance 	= '~',
	}
}


Config.vehicle = {
	speedUnit = 'KMH',
	maxSpeed = 320,

	keys = {
		seatbelt 	= 'G',
		cruiser		= 'CAPS',
		signalLeft	= 'LEFT',
		signalRight	= 'RIGHT',
		signalBoth	= 'DOWN',
	}
}

Config.Zracni = {
	{auto = "rs7r", height = 0.09},
	{auto = "tr22", height = 0.07},
	{auto = "r820", height = 0.11},
	{auto = "rmodm4gts", height = 0.07},
	{auto = "f8t", height = 0.10},
	{auto = "sc18", height = 0.09},
	{auto = "rs6", height = 0.10},
	{auto = "rmodmk7", height = 0.11},
	{auto = "laferrari", height = 0.04},
	{auto = "mk1rabbit", height = 0.08},
	{auto = "supra2", height = 0.07}
}

Config.ui = {
	showServerLogo		= false,

	showJob		 		= true,

	showWalletMoney 	= true,
	showBankMoney 		= false,
	showBlackMoney 		= false,
	showSocietyMoney	= false,

	showDate 			= false,
	showLocation 		= false,
	showVoice	 		= false,

	showHealth			= true,
	showArmor	 		= true,
	showStamina	 		= true,
	showHunger 			= true,
	showThirst	 		= true,

	showMinimap			= true,

	showWeapons			= true,	
}