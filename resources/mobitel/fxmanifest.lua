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
  "index.html",
  "mobitel.png",
  "papiric.png",
  "fonts/ARCADE.TTF",
  "fonts/PENCIL.TTF",
  "zvukovi/sms.mp3",
  "zvukovi/zvonjava.mp3",
  "zvukovi/pozivanje.ogg"
}