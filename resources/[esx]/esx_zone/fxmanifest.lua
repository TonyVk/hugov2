fx_version 'bodacious'
game 'gta5'


description 'ESX Zone'

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