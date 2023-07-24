--[[
    AUTHOR: Joordih - joordih.me 2023 © All rights reserved
    GITHUB: https://github.com/HarpyLMAO
    CREATED AT: 24/07/2023
    PROJECT: koid-core | fxmanifest.lua
--]]

fx_version 'adamant'
game 'gta5'

author 'Koid Development | koid.tech'
description 'Koid essentials library'

client_scripts {
    'config.lua',
    'shared/KoidCore.lua',
    'shared/Utils/Utils.lua',
    'shared/Player/Player.lua',
    'shared/Game/Game.lua',
}

shared_scripts {
    '@es_extended/imports.lua'
}

exports {
    'getSharedObject'
}
