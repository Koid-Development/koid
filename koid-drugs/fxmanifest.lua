--[[
    AUTHOR: Loba, Mino & Joordih - joordih.me | koid.tech 2023 © All rights reserved
    GITHUB: https://github.com/KoidDevelopment
    CREATED AT: 13/09/2023
    PROJECT: koid | fxmanifest.lua
--]]

fx_version 'adamant'
game 'gta5'

description 'Koid Drugs'
version '1.0.0'

client_scripts {
    'client/*.lua',
}

shared_scripts {
    'config.lua',
    'shared/webhook.lua',
}

server_scripts {
    'server/*.lua',
}

