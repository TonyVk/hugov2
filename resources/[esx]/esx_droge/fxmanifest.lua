fx_version 'bodacious'

game 'gta5'

description 'ESX droge'

version '1.0.0'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}