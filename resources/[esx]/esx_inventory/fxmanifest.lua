fx_version 'adamant'
games { 'gta5' }

version "1.0"

ui_page "html/ui.html"

client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "locales/en.lua",
  "client/player.lua",
  "config.lua"
}

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@es_extended/locale.lua",
  "server/main.lua",
  "server/steal.lua",
  "locales/en.lua",
  "config.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/en.js",
  -- IMAGES
  "html/img/bullet.png",
  "html/img/logo.png",
  -- ICONS
  'html/img/items/*.png',
  'html/img/*.png'

}

