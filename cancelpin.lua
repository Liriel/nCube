cancelpin = {}

local isInitialized = false

function init()
    if not isInitialized then
        -- set mode to input
        gpio.mode(1,gpio.INPUT, gpio.PULLUP)
        isInitialized = true
    end
end

cancelpin.check = function ()
    init()
    -- TODO: error handling?
    return gpio.read(1) == 1
end

return cancelpin
