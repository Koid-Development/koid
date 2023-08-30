--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 29/08/2023
    PROJECT: koid | fxmanifest.lua
--]]

fx_version 'adamant'
game 'gta5'

author 'Koid Development | koid.tech'
description 'Koid inventory'

ui_page "html/ui.html"

shared_scripts {
  '@es_extended/imports.lua',
  "@es_extended/locale.lua",
  "locales/*.lua",
  'config.lua'
}

client_scripts {
  "client/main.lua",
  "client/player.lua",
  "client/clothing.lua"
}

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "server/main.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  'html/img/items/*.png',
  "html/fonts/*.ttf",
}

dependencies {
	"es_extended"
}