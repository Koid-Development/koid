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

Config.localWeight = {
    bread = 20,
    water = 20,
	raisin = 20,
	vine = 40,
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
