ESX = exports['es_extended']:getSharedObject()

function sendDataToFront(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

RegisterNetEvent('esx_anuncios:sendAnuncio')
AddEventHandler('esx_anuncios:sendAnuncio', function(job, theme, message)
	sendDataToFront('announce', {
		displaying = true,
		job = job,
		color = theme,
		message = message
	})
end)