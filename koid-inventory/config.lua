Config = {}
Config.Locale = "es"
Config.IncludeWeapons = true -- Incluir armas en el inventario
Config.IncludeAccounts = true -- Incluir cuentas (banco, dinero negro...)
Config.ExcludeAccountsList = {"bank"}-- Cuentas a excluir del inventario
Config.OpenControl = 289 -- Tecla abrir inventario. Editar html/js/config.js para cambiar la tecla de cierre
Config.HotBar = 37 -- Tecla para activar la barra de acceso rápido.

-- Lista de objetos usables (Para cerrar el inventario una vez usados)
Config.CloseUiItems = {"sportlunch", 
                    "protein_shake", 
                    "powerade", 
                    "fixkit", 
                    "blowtorch",
                    "c4_bank",
                    "raspberry",
                    "clip",
                    "cocaine",
                    "meth", 
                    "coke_streak", 
                    "weedseed",
                    "beer"
}

Config.ItemCategories = {
	Weapons = {
		"WEAPON_PISTOL",
		"WEAPON_SMG",
		"WEAPON_SNSPISTOL",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_COMPACTRIFLE",
		"WEAPON_MINIGUN",
		"WEAPON_HEAVYSHOTGUN",
		"WEAPON_COMBATMG",
		"WEAPON_SMOKEGRENADE",
		"WEAPON_BZGAS",
		"WEAPON_STUNGUN",
		"WEAPON_MARKSMANPISTOL",
		"WEAPON_CARBINERIFLE",
		"WEAPON_COMBATPDW",
		"WEAPON_DBSHOTGUN",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYSNIPER",
		"WEAPON_MUSKET",
		"WEAPON_ADVANCEDRIFLE",
		"WEAPON_MARKSMANRIFLE",
		"WEAPON_STICKYBOMB",
		"WEAPON_ASSAULTSHOTGUN",
		"WEAPON_COMBATPISTOL",
		"WEAPON_DOUBLEACTION",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_MACHINEPISTOL",
		"WEAPON_SNIPERRIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_MOLOTOV",
		"WEAPON_GUSENBERG"
	},
	Consumables = {
		"COCACOLA",
	},
	Drugs = {
		"CLOTH",
		"COCAINE",
		"CANNABIS"
	}
}

Config.localWeight = {
    WEAPON_SMG = 15000,
	WEAPON_PISTOL = 30,
	WEAPON_SNSPISTOL = 10000,
	WEAPON_SPECIALCARBINE = 15000,
	WEAPON_COMPACTRIFLE = 15000,
	WEAPON_MINIGUN = 45000,
	WEAPON_HEAVYSHOTGUN = 15000,
	WEAPON_COMBATMG = 25000,
	WEAPON_SMOKEGRENADE = 1000,
	WEAPON_BZGAS = 1000,
	WEAPON_STUNGUN = 15000,
	WEAPON_MARKSMANPISTOL = 15000,
	WEAPON_CARBINERIFLE = 15000,
	WEAPON_COMBATPDW = 15000,
	WEAPON_DBSHOTGUN = 15000,
	WEAPON_APPISTOL = 15000,
	WEAPON_HEAVYSNIPER = 20000,
	WEAPON_MUSKET = 15000,
	WEAPON_ADVANCEDRIFLE = 15000,
	WEAPON_MARKSMANRIFLE = 15000,
	WEAPON_STICKYBOMB = 5000,
	WEAPON_ASSAULTSHOTGUN = 15000,
	WEAPON_COMBATPISTOL = 15000,
	WEAPON_DOUBLEACTION = 15000,
	WEAPON_VINTAGEPISTOL = 15000,
	WEAPON_MACHINEPISTOL = 15000,
	WEAPON_SNIPERRIFLE = 20000,
	WEAPON_ASSAULTRIFLE = 20000,
	WEAPON_MOLOTOV = 5000,
	WEAPON_GUSENBERG = 15000
}
