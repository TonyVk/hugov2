fx_version 'bodacious'
game 'gta5'

description 'ESX safezone'

version '1.0.0'

client_scripts {
  '@PolyZone/client.lua',
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/main.lua'
}