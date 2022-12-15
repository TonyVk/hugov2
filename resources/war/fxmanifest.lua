fx_version 'bodacious'
game 'gta5'

server_scripts {
    '@es_extended/locale.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    '@es_extended/config.lua',
    '@es_extended/config.weapons.lua',
}

client_scripts {
    '@es_extended/locale.lua',
    'client/main.lua',
    '@es_extended/config.lua',
    '@es_extended/config.weapons.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/score.png',
    'ui/kill.png',
    'ui/death.png',
    'ui/time.png'
}