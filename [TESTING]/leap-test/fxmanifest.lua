fx_version('cerulean')
game('gta5')

author 'Koid Development'

client_scripts({
    'src/client/*.lua',
})

server_scripts({
    'src/server/*.lua',
})

dependency('leap')