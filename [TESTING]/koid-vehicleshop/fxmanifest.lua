fx_version 'adamant'

author 'Koid Development'
description 'Koid Vehicle Shop'
game 'gta5'

lua54 'yes'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

shared_scripts {
    '@es_extended/imports.lua',
    'shared/config.lua',
}

ui_page 'web/dist/index.html'

files {
    'web/dist/**'
}
