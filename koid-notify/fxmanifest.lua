--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 24/07/2023
    PROJECT: koid-core | fxmanifest.lua
--]]

fx_version 'adamant'
game 'gta5'

author 'Koid Development'
description 'Koid notifications system'

client_scripts {
    'client/client.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/app.js',
    'html/fonts/agave.ttf',
    'html/js/sounds/entry.ogg',
    'html/js/sounds/exit.ogg',
    'html/css/app.css'
}

shared_scripts {
    '@koid-core/shared/koidcore.lua'
}