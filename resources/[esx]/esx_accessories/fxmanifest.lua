fx_version 'bodacious'
game 'gta5'


description 'ESX Accessories'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
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

dependencies {
	'es_extended',
	'esx_skin',
	'esx_datastore'
}