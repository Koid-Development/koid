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

AddEventHandler('koid-drugs:join', function(zone, zoneType, drug)
	currentAction = 'koid_drugs'
	currentActionData = {
        zone = zone,
        drug = drug,
        zoneType = zoneType
    }

    local data = {
        embeds = {
            {
                title = "Un jugador ha encontrado un punto de drogas",
                description = "Esto es un secreto, no lo compartas con nadie!",
                color = 11216719,
                fields = {
                    {
                        name = "Nombre del punto",
                        value = drug.name,
                    },
                    {
                        name = "Tipo de punto",
                        value = currentActionData.zoneType,
                    },
                    {
                        name = "Cordenadas",
                        value = drug.locations[zoneType].x .. ", " .. drug.locations[zoneType].y .. ", " .. drug.locations[zoneType].z,
                    }
                }
            }
        }
    }

    TriggerServerEvent("koid_drugs:webhook", data)
end)

AddEventHandler('koid-drugs:exit', function(zone, zoneType, drug)
	currentAction = nil
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
    while true do
        local Sleep = 1500

		if currentAction then
			Sleep = 0
			if IsControlJustReleased(0, Keys["E"]) and currentAction == 'koid_drugs' then
                if currentActionData.zoneType == "process" then
                    TriggerServerEvent("koid_drugs:process", currentActionData.drug)
                elseif currentActionData.zoneType == "collection" then
                    print(json.encode(currentActionData))
                    TriggerServerEvent("koid_drugs:collection", currentActionData.drug)
                end
			end
		end

        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInMarker, currentZone, zoneType, drugO  = false, nil, nil, nil
        
        for _, drug in pairs(Config.Drugs) do
            local processDistance = #(playerCoords - drug.locations.process)
            local collectionDistance = #(playerCoords - drug.locations.collection)

            if processDistance < 10 then
                Sleep = 0
                if drug.blip then
                    DrawText3D(drug.locations.process.x, drug.locations.process.y, drug.locations.process.z, "Presiona ~q~E~w~ para procesar la droga")
                    DrawMarker(drug.markerType, drug.locations.process.x, drug.locations.process.y, drug.locations.process.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, drug.markerSize.x, drug.markerSize.y, drug.markerSize.z, drug.color.r, drug.color.g, drug.color.b, 100, false, true, 2, false, false, false, false)
                end
                if processDistance < 2.0 then
                    isInMarker = true
                    currentZone = drug.name
                    lastZone = drug.name
                    drugO = drug
                    zoneType = "process"
                end
            end

            if collectionDistance < 10 then
                Sleep = 0
                if drug.blip then
                    DrawText3D(drug.locations.collection.x, drug.locations.collection.y, drug.locations.collection.z, "Presiona ~q~E~w~ para recolectar la droga")
                    DrawMarker(drug.markerType, drug.locations.collection.x, drug.locations.collection.y, drug.locations.collection.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, drug.markerSize.x, drug.markerSize.y, drug.markerSize.z, drug.color.r, drug.color.g, drug.color.b, 100, false, true, 2, false, false, false, false)
                end
                if collectionDistance < 2.0 then
                    isInMarker = true
                    currentZone = drug.name
                    lastZone = drug.name
                    drugO = drug
                    zoneType = "collection"
                end
            end
        end

        if isInMarker and not joinedZone then
            joinedZone = true
            TriggerEvent('koid-drugs:join', currentZone, zoneType, drugO)
        end

        if not isInMarker and joinedZone then
            joinedZone = false
            TriggerEvent('koid-drugs:exit', lastZone, zoneType, drugO)
        end
        Wait(Sleep)
    end
end)

RegisterNetEvent("koid-drugs:pickUp")
AddEventHandler("koid-drugs:pickUp", function()
    TriggerEvent("mythic_progbar:client:progress", {
        name = "pickupDrugs",
        duration = 5500,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableCombat = true,
        },
        animation = {
            animDict = "amb@world_human_gardener_plant@male@idle_a",
            anim = "idle_b",
        },
        prop = {
            model = "prop_cs_trowel",
        }
    })
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

-- Creación de los blips
Citizen.CreateThread(function()
    for i, drug in ipairs(Config.Drugs) do
        if drug.blip then
        
            local collectionLocation = drug.locations.process;
            local collectionBlip = AddBlipForArea(collectionLocation.x, collectionLocation.y, collectionLocation.z)
            SetBlipSprite(collectionBlip, 403)
            SetBlipDisplay(collectionBlip, 4)
            SetBlipScale(collectionBlip, 1.0)
            SetBlipColour(collectionBlip, drug.color.r, drug.color.g, drug.color.b, 100)
            SetBlipAsShortRange(collectionBlip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(drug.name)
            EndTextCommandSetBlipName(collectionBlip)
        end
    end
end)

