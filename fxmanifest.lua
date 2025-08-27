fx_version 'cerulean'
game 'gta5'

author 'Kenzie'
description 'QBCore Custody Script (UK Style)'
version '1.0.0'

shared_script '@qb-core/shared.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- if you add DB saving later
    'server.lua'
}
