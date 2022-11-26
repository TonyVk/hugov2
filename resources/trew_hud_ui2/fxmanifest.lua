fx_version 'bodacious'
game 'gta5'


description 'Trew HUD UI'

ui_page 'html/ui.html'




files {
	'html/ui.html',
	'html/main.css',
	'html/app.js',
	
	'html/img/*.png',

	'html/img/weapons/*.png',
	
	'html/sounds/seatbelt-buckle.ogg',
	'html/sounds/seatbelt-unbuckle.ogg',

	'html/sounds/car-indicators.ogg'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'config.lua',
	'client/client.lua',
	'client/hansolo.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/br.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua',
	'server/milleniumfalcon.lua'
}

dependencies {
	'es_extended'
}