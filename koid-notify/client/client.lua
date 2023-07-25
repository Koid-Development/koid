local koidcore = exports["koid-core"]:getSharedObject()

function sendDataToFront(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end


local activeNotification = false
function sendNotification(title, message, duration)
    while activeNotification do
        Citizen.Wait(350)
    end

    sendDataToFront('notification', {
        title = koidcore.Utils:toHTML(title) or 'INFORMATION',
        message = koidcore.Utils:toHTML(message) or message,
        duration = duration or 3500
    })
end

RegisterNetEvent('koid-notify:sendNotification', function (data)
    local timeout = data.duration or 3500
    if activeNotification then
        SetTimeout(timeout, function ()
            sendNotification(data.title, data.message, data.duration)
        end)
    else
        sendNotification(data.title, data.message, data.duration)
    end
end)

RegisterNUICallback('activeNotification', function (active)
    activeNotification = active;
end)

function triggerNotify(title, message, duration)
    TriggerEvent('koid-notify:sendNotification', {
        title = title,
        message = message,
        duration = duration or 4500
    })
end

exports('sendNotify', function (title, message, timeout)
    triggerNotify(title, message, timeout)
end)

RegisterCommand('testnotify', function ()
    triggerNotify('Test', 'This is a test notification', 4500)
end)