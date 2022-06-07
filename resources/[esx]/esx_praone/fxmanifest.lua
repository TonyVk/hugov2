fx_version 'bodacious'
game 'gta5'


description 'ESX Car Wash'

version '1.0.0'

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/hr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/hr.lua',
	'config.lua',
	'client/main.lua'
}

dependency 'es_extended'