-- load modules
local lights = require "lights"
local app = {}

function Main()
    -- unload wifi helper
    require("wifihelper").dispose()
    package.loaded["wifihelper"] = nil

    print("running main program")
    lights.Effect("grow")
    lights = nil

    require("server").run()
end

onFail = function()
    lights.SetColor(255, 0, 0, 0)
    print("wifi configuration failed")
end

app.run = function()
    -- check if we need to configure wifi
    if(wifi.sta.status() == wifi.STA_IDLE and not file.exists("eus_params.lua"))then
      -- todo register callback
      lights.Effect("random")
      enduser_setup.start(function()
        -- stopping EUS does not free port 80
        node.restart()
      end, onFail)
    else
      -- show the "configuring wifi effect"
      lights.Effect("lcars")
      if(wifi.sta.status() == wifi.STA_GOTIP)then
        Main()
      else
        require("wifihelper").init(Main, onFail)
      end
    end
end

return app
