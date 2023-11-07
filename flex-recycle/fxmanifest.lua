fx_version "bodacious"
game "gta5"
lua54 "yes"

author "flexiboi"
description "Flex-recycle"
version "1.0.0"

this_is_a_map 'yes'

shared_scripts {
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/nl.lua',
}

server_scripts {
    'server/main.lua',
}

client_scripts {
	'client/*.lua',
}

dependencies {
	'qb-core'
}

files {
    'prop_glasbol_01a.ytyp',
    'prop_glasbol_01a.ydr',
}

data_file 'DLC_ITYP_REQUEST' 'prop_glasbol_01a.ytyp'
data_file 'DLC_ITYP_REQUEST' 'prop_glasbol_01a.ydr'