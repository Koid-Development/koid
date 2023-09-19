Config = {}

Config.Other = {
    DrugDealer = {
        items = {
            "marijuana",
            "cocaine",
            "meth",
            "opium",
            "mdma",
            "lsd",
            "fentanyl",
            "crystal",
            "poper",
            "tusi"
        },
        name = "Dealer de drogas",
        npc = "g_m_m_casrn_01",
        location = vector4(-77.4525, 364.1804, 112.4417, 154.7171),
        giveInBlack = true,
        keyForInteract = "E",
    },
    MoneyWash = {
        name = "Lavado de dinero",
        location = vector3(-441.1432, 1595.4407, 358.4680),
        markerType = 1,
        percent = 70,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 }
    }
}

Config.Drugs = {
    {
        name = "Marihuana",
        item = "marijuana",
        processed = {
            name = "Marihuana procesada",
            item = "marijuana_p",
            needed = 5
        },
        locations = {
            collection = vector3(436.6021, 6455.0796, 28.7414),
            process = vector3(1469.6495, 6549.9941, 14.9041),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 500,
            max = 600,
        }
    },
    {
        name = "Cocaina",
        item = "cocaine",
        processed = {
            name = "Cocaina procesada",
            item = "cocaine_p",
            needed = 5
        },
        locations = {
            collection = vector3(-186.7533, 6543.2090, 11.0979),
            process = vector3(-453.4095, 6336.6377, 13.1093),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 600,
            max = 800,
        }
    },
    {
        name = "Methanfetamina",
        item = "meth",
        processed = {
            name = "Methanfetamina procesada",
            item = "meth_p",
            needed = 5
        },
        locations = {
            collection = vector3(-596.4406, 2089.3306, 131.4128),
            process = vector3(1538.6666, 1701.9050, 109.6624),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 500,
            max = 700,
        }
    },
    {
        name = "Opio",
        item = "opium",
        processed = {
            name = "Opio procesada",
            item = "opium_p",
            needed = 5
        },
        locations = {
            collection = vector3(1108.6475, -2256.8630, 30.9380),
            process = vector3(-79.1385, 6210.1455, 31.4648),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 500,
            max = 700,
        }
    },
    {
        name = "Mdma",
        item = "mdma",
        processed = {
            name = "MDMA procesada",
            item = "mdma_p",
            needed = 5
        },
        locations = {
            collection = vector3(608.6702, -468.7119, 26.0376),
            process = vector3(-457.7911, -2265.8230, 8.5158),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 800,
            max = 1000,
        }
    },
    {
        name = "Lsd",
        item = "lsd",
        processed = {
            name = "LSD procesada",
            item = "lsd_p",
            needed = 5
        },
        locations = {
            collection = vector3(-2788.7061, 1419.4701, 100.9273),
            process = vector3(-3253.0244, 1077.4790, 11.0333),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 600,
            max = 800,
        }
    },
    {
        name = "Fentanilo",
        item = "fentanyl",
        processed = {
            name = "Fentanilo procesada",
            item = "fentanyl_p",
            needed = 5
        },
        locations = {
            collection = vector3(1297.7604, 6473.6694, 16.2799),
            process = vector3(-1150.3350, 4940.5396, 222.2686),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 1300,
            max = 1500,
        }
    },
    {
        name = "Cristal",
        item = "crystal",
        processed = {
            name = "Cristal procesada",
            item = "crystal_p",
            needed = 5
        },
        locations = {
            collection = vector3(2894.4216, 3738.0452, 44.1970),
            process = vector3(1417.1313, 6339.3774, 24.3984),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 500,
            max = 700,
        }
    },
    {
        name = "Poper",
        item = "poper",
        processed = {
            name = "Poper procesada",
            item = "poper_p",
            needed = 5
        },
        locations = {
            collection = vector3(1740.5835, -1606.9553, 112.4860),
            process = vector3(2484.2542, 3445.9807, 51.0674),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 400,
            max = 600,
        }
    },
    {
        name = "Tusi",
        item = "tusi",
        processed = {
            name = "Tusi procesada",
            item = "tusi_p",
            needed = 5
        },
        locations = {
            collection = vector3(711.2484, 4185.2754, 41.0827),
            process = vector3(739.6356, 2579.3142, 75.4667),
        },
        blip = true,
        markerType = 1,
        drawDistance = 100.0,
        markerSize = { x = 1.0, y = 1.0, z = 1.0 },
        color = { r = 200, g = 50, b = 200 },
        sell = {
            min = 700,
            max = 900,
        }
    }
}