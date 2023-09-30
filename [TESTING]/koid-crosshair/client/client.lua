local open = false

RegisterCommand("crosshairs", function ()
    if not open then 
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'openMenu'
        })
        open = true
    end
end)



RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    open = false
end)


RegisterNUICallback("loadData" , function(data, cb)
    for k,v in pairs(Config.Crosshairs) do 
        SendNUIMessage({
            action = 'Load',
            imagenes = v.img,
            valor = v.name, 
            label = v.label
        })
    end
end)
