class Main {
    local ESX = exports['es_extended']:getSharedObject();

    constructor = function()
        startMessage([[
             __    ____   __   ____
            (  )  (  __) / _\ (  _ \
            / (_/\ ) _) /    \ ) __/
            \____/(____)\_/\_/(__)
        ]])
    end

    function startMessage(<string> message) {
        print(message);
    }
}

Main();