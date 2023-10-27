local ESX = exports['es_extended']:getSharedObject()

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

function includes(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

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

local inRangeForDealer = false

Citizen.CreateThread(function()
    while true do
        local dealerCoords = vector3(Config.Other.DrugDealer.location.x, Config.Other.DrugDealer.location.y, Config.Other.DrugDealer.location.z)
        local coords = GetEntityCoords(PlayerPedId())
        local dealerNpc = #(coords - dealerCoords)

        inRangeForDealer = false
        if dealerNpc <= 2.0 then
            inRangeForDealer = true
        end

        Wait(500)
    end
end)

Citizen.CreateThread(function ()
    while true do
        local Sleep = 1500
        if inRangeForDealer then
            Sleep = 0
            local location = Config.Other.DrugDealer.location
            DrawText3D(location.x, location.y, location.z, "Presiona ~q~E~w~ para hablar con el dealer")
            if IsControlJustReleased(0, Keys["E"]) then
                TriggerEvent('koid-drugs:dealerInteract')
            end
        end
        Citizen.Wait(Sleep)
    end
end)

Citizen.CreateThread(function()
    local model = Config.Other.DrugDealer.npc

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local npc = CreatePed(4, model, Config.Other.DrugDealer.location.x, Config.Other.DrugDealer.location.y, Config.Other.DrugDealer.location.z - 1, Config.Other.DrugDealer.location.w, false, true)
    
    SetEntityInvincible(npc, true)
    SetEntityHasGravity(npc, false)
    FreezeEntityPosition(npc, true)
    SetPedAlertness(npc, 0)
    SetPedCanRagdoll(npc, false)
    SetPedCanBeTargetted(npc, false) 
    SetPedFleeAttributes(npc, 0, 0)
    SetPedDropsWeaponsWhenDead(npc, false)
    SetPedCombatAttributes(npc, 46, true)
    SetPedIsDrunk(npc, true)

    SetModelAsNoLongerNeeded(model)
end)

AddEventHandler('koid-drugs:dealerInteract', function()
    local elements = {
        head = {'Droga', 'Precio', 'Tu cantidad', 'Vender'},
        rows = {}
    }

    local allowedItems = {  
        "marijuana_p",
        "cocaine_p", 
        "meth_p",
        "opium_p",
        "mdma_p",
        "lsd_p",
        "fentanyl_p",
        "crystal_p",
        "poper_p",
        "tusi_p"
    } 

    local filteredInventory = {}

    -- ESX.TriggerServerCallback('koid-drugs:getPlayerInventory', function(inventory)
    --     for k, item in pairs(json.decode(inventory)) do
    --         if includes(allowedItems, item.label) then
    --             print(item.label .. " is allowed")
    --             table.insert(filteredInventory, {
    --                 label = item.label,
    --                 count = item.count
    --             })
    --         end
    --     end
    -- end, GetPlayerServerId(PlayerId()))

    ESX.TriggerServerCallback('koid-drugs:getPlayerInventory', function(inventory)
        for k, item in pairs(json.decode(inventory)) do
            local itemName = k
            local itemCount = item

            if includes(allowedItems, itemName) then
                table.insert(filteredInventory, {
                    label = itemName,
                    count = itemCount
                })
            end
        end

        for k, item in ipairs(filteredInventory) do
            print(item.label .. " lmao")
            for i, drug in ipairs(Config.Drugs) do
                print(item.label .. " + " .. drug.processed.item)
                if item.label == drug.processed.item then
                    local price = math.random(drug.sell.min, drug.sell.max) * item.count
                    table.insert(elements.rows, {
                        data = {item.label, price, item.count},
                        cols = {
                            item.label, price .. " $", item.count, '{{VENDER|venderButton}}'
                        }
                    })

                    print(json.encode(elements))
                end
            end
        end

        ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'drugDealer', elements, function(data, menu)
            if data.value == 'venderButton' then
                local item = data.data[1]
                local price = data.data[2]
                local count = data.data[3]
    
                TriggerServerEvent('koid-drugs:sell', item, price, count)
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
    end, GetPlayerServerId(PlayerId()))


    -- -- Asegura que filteredInventory y Config.Drugs estén definidos y no estén vacíos
    -- if filteredInventory and next(filteredInventory) and Config.Drugs and next(Config.Drugs) then
    --     for k, item in pairs(filteredInventory) do
    --         if type(item) == "table" and item.name then
    --             for i, drug in pairs(Config.Drugs) do
    --                 if type(drug) == "table" and drug.item then
    --                     print(item.name .. " + " .. drug.item)
    --                     if item.name == drug.item then
    --                         local price = math.random(drug.sell.min, drug.sell.max) * (item.count or 1)
    --                         table.insert(elements.rows, {
    --                             data = item,
    --                             cols = {
    --                                 {item.name, price, item.count or 1, '{{VENDER|venderButon}}'}
    --                             }
    --                         })
    --                     end
    --                 end
    --             end
    --         end
    --     end
    -- else
    --     print("filteredInventory o Config.Drugs están vacíos o no definidos")
    -- end
end)