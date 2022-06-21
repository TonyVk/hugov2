fx_version 'bodacious'
game 'gta5'

client_scripts {
	"client/functions.lua",
	"client/main.lua"
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server/main.lua"
}

shared_scripts {
	"config.lua"
}