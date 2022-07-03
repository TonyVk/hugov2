fx_version 'adamant'
game 'gta5'

ui_page "html/index.html"

client_scripts {
    'config.lua',
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server/main.lua'
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/img/*.PNG',
    'html/img/*.jpg',
    'html/css/*.css',
    'html/img/fonts/*.ttf',
    'html/img/fonts/*.otf',
    'html/img/fonts/*.woff',
}