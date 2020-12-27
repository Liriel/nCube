-- load modules
local config = require "config"
local cancelPin = require "cancelpin"
local wifiHelper = require "webhelper"

local app = {}

function Main()
    -- check if cancellation pin was set
    if not cancelPin.check() then
        print("ABORTING cancel pin set")
    else
        print("running main program")

        -- your code

        print("operations done - going to sleep")
        -- deep sleep for interval seconds (argument is microseconds)
        node.dsleep(config.INTERVAL * 1000000)
    end
end

onFail = function()
    print("operations failed - going to sleep")
    node.dsleep(config.INTERVAL * 1000000)
end

app.run = function()
    print("--- my program ---")
    wifiHelper.init(Main, onFail)
end

return app
