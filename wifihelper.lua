local config = require "eus_params"

local web = {}
local rdyCallback = nil
local errCallback = nil

web.isReady = false

-- Define WiFi station event callbacks 
wifi_connect_event = function(T) 
    print("Connection to AP("..T.SSID..") established!")
    print("Waiting for IP address...")
    if disconnect_ct ~= nil then disconnect_ct = nil end  
end

wifi_got_ip_event = function(T) 
    -- Note: Having an IP address does not mean there is internet access!
    -- Internet connectivity can be determined with net.dns.resolve().    
    print("Wifi connection is ready! IP address is: "..T.IP)
    web.isReady = true
    if(rdyCallback) then rdyCallback() end
end
  
wifi_disconnect_event = function(T)
    if T.reason == wifi.eventmon.reason.ASSOC_LEAVE then 
        --the station has disassociated from a previously connected AP
        return 
    end
    -- total_tries: how many times the station will attempt to connect to the AP. Should consider AP reboot duration.
    local total_tries = 75
    print("\nWiFi connection to AP("..T.SSID..") has failed!")

    --There are many possible disconnect reasons, the following iterates through 
    --the list and returns the string corresponding to the disconnect reason.
    for key,val in pairs(wifi.eventmon.reason) do
        if val == T.reason then
        print("Disconnect reason: "..val.."("..key..")")
        break
        end
    end

    if disconnect_ct == nil then 
        disconnect_ct = 1 
    else
        disconnect_ct = disconnect_ct + 1 
    end
    if disconnect_ct < total_tries then 
        print("Retrying connection...(attempt "..(disconnect_ct+1).." of "..total_tries..")")
    else
        wifi.sta.disconnect()
        print("Aborting connection to AP!")
        disconnect_ct = nil  
        if(errCallback) then errCallback() end
    end
end

web.init = function(readyCallback, errorCallback)
    rdyCallback = readyCallback
    errCallback = errorCallback
    -- Register WiFi Station event callbacks
    wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, wifi_connect_event)
    wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, wifi_got_ip_event)
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, wifi_disconnect_event)

    local sta_config=wifi.sta.getconfig(true)
    if sta_config then
        print(string.format("\tCurrent station config\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", (sta_config.ssid or ""), (sta_config.pwd or ""), (sta_config.bssid or ""), (sta_config.bssid_set and "true" or "false")))
        if sta_config.ssid ~= config.wifi_ssid or sta_config.pwd ~= config.wifi_password then
            print "Wifi settings updated - reconfiguring"
            wifi.setmode(wifi.STATION)
            wifi.sta.config({ssid=config.wifi_ssid, pwd=config.wifi_password})
        else
            print("Reconnecting to WiFi access point...", wifi.sta.status())
            if(wifi.sta.status() == wifi.STA_GOTIP) then 
              readyCallback() 
            elseif(wifi.sta.status() == wifi.STA_IDLE) then 
              wifi.sta.connect()
            end
        end
    else
        wifi.setmode(wifi.STATION)
        wifi.sta.config({ssid=config.wifi_ssid, pwd=config.wifi_password})
    end
end

web.dispose = function()
    wifi.eventmon.unregister(wifi.eventmon.STA_CONNECTED)
    wifi.eventmon.unregister(wifi.eventmon.STA_GOT_IP)
    wifi.eventmon.unregister(wifi.eventmon.STA_DISCONNECTED)
end

return web
