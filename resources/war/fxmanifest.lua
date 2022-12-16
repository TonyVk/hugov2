fx_version 'bodacious'
game 'gta5'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/score.png',
    'ui/kill.png',
    'ui/death.png',
    'ui/time.png'
}