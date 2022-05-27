fx_version 'cerulean'
game 'gta5'

client_scripts{
	"client/main.lua"
}

server_scripts{
    '@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	"server/main.lua"
}

ui_page "index.html"

files {
    "index.html"
}