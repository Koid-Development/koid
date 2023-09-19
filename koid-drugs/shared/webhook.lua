-- URL del webhook 
local webhookURL = "https://discord.com/api/webhooks/1152316520999948423/vUDOJRlLxedJlqNsrIZtar5r4mibIVMK8IOixvPvr0HWDt_SxVMjLINr1dzWAWyr7fGl"

local koid_drugs = {}

function koid_drugs.sendWebhook(content)
    PerformHttpRequest(webhookURL, function(err, text, headers) 
        print('Response: ', text)
    end, 'POST', json.encode(content), { ['Content-Type'] = 'application/json' })
end 

exports('koid_drugs', koid_drugs)