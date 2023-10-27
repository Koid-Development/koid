Config = {}

Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
Config.Payment = 'bank'
Config.TestTime = 30
Config.Debug = false -- no tocar, es para que pueda probarlo mientras lo programo.

-- Configurar tipos de tiendas de vehiculos
Config.Shops = {
    {
        name = 'Tienda de vehiculos altas velocidades',
        description = 'En este concesionario podrás encontrar los vehiculos más veloces de toda la ciudad!',
        pos = vec3(-33.942856, -1102.008789, 26.415405),
        preview = vec3(-43.279121, -1099.938477, 26.415405), previewHeading = 68.031494,
        category = {
            'sports', 'suv', 'bmw', 'audi', 'honda', 'lexus', 'mazda', 'toyota'
        },
        blip = {
            color = 3,
            sprite = 355,
        },
        delivery = {
            pos = vec3(-27.863733, -1082.571411, 26.600708),
            heading = 68.031494,
        }
    },
    {
        name = 'Tienda de vehiculos maritimos!',
        description = 'Aquí podrás encontrar los mejores yates y botes para navegar con toda tranquilidad donde quieras!',
        pos = vec3(-898.958252, -1333.107666, 1.595581),
        preview = vec3(-891.520874, -1349.736206, -0.176929), previewHeading = -201.259842,
        category = 'boats',
        cameraDistance = 10.0,
        blip = {
            color = 3,
            sprite = 355,
        },
        delivery = {
            pos = vec3(-897.191223, -1350.026367, 1.595581),
            heading = 5.669291,
        }
    }
}

Config.Translation = {
    purchase = "Comprar",
    currency = "€"
}

Config.Vehicles = {
    {
        name = 'Sultan RS',
        model = 'sultanrs',
        price = 100000,
        category = 'sports',
    },
    {
        name = 'Sultan',
        model = 'sultan',
        price = 100000,
        category = 'sports',
    },
    {
        name = 'Qucik BOi',
        model = 'speeder',
        price = 50000,
        category = 'boats'
    }
}