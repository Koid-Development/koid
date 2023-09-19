local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local joinedZone, lastZone
local currentAction, currentActionData = nil, {}

AddEventHandler('koid-drugs:joinMoneyWash', function(zone, zoneType)
	currentAction = 'koid_moneywash'
	currentActionData = {
        zone = zone,
        zoneType = zoneType
    }
end)

AddEventHandler('koid-drugs:exitMoneyWash', function(zone, zoneType)
	currentAction = nil
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do
        local Sleep = 1500

		if currentAction then
			Sleep = 0
			if IsControlJustReleased(0, Keys["E"]) and currentAction == 'koid_moneywash' then
                print("e")
                TriggerServerEvent("koid-drugs:washMoney")
			end
		end

        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInMarker, currentZone, zoneType = false, nil, nil
        
        local moneyWashDistance = #(playerCoords - Config.Other.MoneyWash.location)

        if moneyWashDistance < 7 then
            Sleep = 0
            DrawText3D(Config.Other.MoneyWash.location.x, Config.Other.MoneyWash.location.y, Config.Other.MoneyWash.location.z, "Presiona ~q~E~w~ para procesar lavar dinero")
            DrawMarker(Config.Other.MoneyWash.markerType, Config.Other.MoneyWash.location.x, Config.Other.MoneyWash.location.y, Config.Other.MoneyWash.location.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Other.MoneyWash.markerSize.x, Config.Other.MoneyWash.markerSize.y, Config.Other.MoneyWash.markerSize.z, Config.Other.MoneyWash.color.r, Config.Other.MoneyWash.color.g, Config.Other.MoneyWash.color.b, 100, false, true, 2, false, false, false, false)
            if moneyWashDistance < 2.0 then
                isInMarker = true
                currentZone = Config.Other.MoneyWash.name
                lastZone = Config.Other.MoneyWash.name
                zoneType = "process"
            end
        end

        if isInMarker and not joinedZone then
            joinedZone = true
            TriggerEvent('koid-drugs:joinMoneyWash', currentZone, zoneType)
        end

        if not isInMarker and joinedZone then
            joinedZone = false
            TriggerEvent('koid-drugs:exitMoneyWash', lastZone, zoneType)
        end
        Wait(Sleep)
    end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end