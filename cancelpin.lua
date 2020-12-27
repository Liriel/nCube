cancelpin = {}

local isInitialized = false
local config = require "config"

function init()
    if not isInitialized then
        local pin = config.CANCEL_PIN
        print("setting up input pin "..config.CANCEL_PIN)
        -- set mode to input
        gpio.mode(config.CANCEL_PIN,gpio.INPUT, gpio.PULLUP)
        isInitialized = true
    end
end

cancelpin.check = function ()
    init()
    -- TODO: error handling?
    return gpio.read(config.CANCEL_PIN) == 1
end

return cancelpin