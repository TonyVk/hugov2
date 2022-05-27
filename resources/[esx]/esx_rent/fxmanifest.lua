fx_version 'cerulean'
game 'gta5'

description 'ESX rent'

version '1.0.0'

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'config.lua',
  'server/main.lua'
}

client_scripts {
  'config.lua',
  'client/main.lua'
}