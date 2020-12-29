--------------MAIN PROGRAM ----------------------
-- initialize LFS
node.LFS.get("_init")()
-- load modules
local cancelPin = require "cancelpin"

-- load program
local app = require "app"

-- check if app was loaded
if not app then
    print("ERROR app not found")
    return
end

-- check if cancellation pin is set
if not cancelPin.check() then
    print("ABORTING cancel pin set")
    wifi.sta.clearconfig()
    file.remove("eus_params.lua")
    print("Factory reset complete")
end

-- start the main program
if app.run then
    app.run()
else
    print("ERROR app does not implement run() method")
end

