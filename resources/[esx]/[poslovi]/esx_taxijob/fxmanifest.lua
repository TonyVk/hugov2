fx_version 'bodacious'
game 'gta5'


description 'ESX Taxi Job'

version '1.0.2'

client_scripts {
	'@es_extended/locale.lua',
	'locales/hr.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/hr.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'es_extended'