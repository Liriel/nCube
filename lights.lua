
local lights = {}
local effects = {}
local effectTimer = tmr.create()

ws2812.init(ws2812.MODE_SINGLE)
local buffer = ws2812.newBuffer(12, 4)
ws2812_effects.init(buffer)

-- fills the buffer completely with a random color and changes this color constantly
effects.random = function()
  effectTimer:stop()
  ws2812_effects.set_color(0,0,0,255)
  ws2812_effects.set_mode("random_dot")
  ws2812_effects.start()
end

-- animates through the full color spectrum
effects.rainbow = function()
  effectTimer:stop()
  ws2812_effects.set_mode("rainbow")
  ws2812_effects.start()
end

-- stop running effect
effects.stop = function(effect)
  ws2812_effects.stop()
  effectTimer:stop()
end

-- fade in from bottom to top
effects.grow = function()
  ws2812_effects.stop()
  local i = 0
  local idx = 1
  lights.SetColor(0,0,0,0)
  effectTimer:register(50, tmr.ALARM_AUTO, 
    function() 
      i = i + 5
      if(i>255) then i = 5; idx = idx + 1 end
      if(idx > 4) then 
        effectTimer:stop()
        return
      end

      buffer:set(idx, {0, 0, 0, i})
      buffer:set(idx + 4, {0, 0, 0, i})
      buffer:set(idx + 8, {0, 0, 0, i})
      ws2812.write(buffer)
  end)
  effectTimer:start()
end

-- fade in
effects.fadein = function()
  ws2812_effects.stop()
  local i = 5
  lights.SetColor(0,0,0,0)
  effectTimer:register(25, tmr.ALARM_AUTO, 
    function() 
      i = i + 5
      if(i > 255) then 
        effectTimer:stop()
        return
      end

      lights.SetColor(0,0,0,i)
  end)
  effectTimer:start()
end

-- LCARS
effects.lcars = function()
  ws2812_effects.stop()
  local i = 1
  local inc = 1
  local f = 0
  lights.SetColor(0,0,0,0)
  effectTimer:register(100, tmr.ALARM_AUTO, 
    function() 
      i = i + inc
      if(i >= 4 or i <= 1) then 
        inc = inc * -1 
      end

      if(i <= 1) then 
        f = f + 1 
        if(f>2) then f = 0 end
      end

      buffer:fill(0,0,0,0)
      buffer:set(i + f * 4, {0, 255, 0, 0})
      ws2812.write(buffer)
  end)
  effectTimer:start()
end

-- running dots from bottom to top
effects.strip = function()
  ws2812_effects.stop()
  local i = 1
  lights.SetColor(0,0,0,0)
  effectTimer:register(200, tmr.ALARM_AUTO, 
    function() 
      i = i + 1
      if(i > 4) then 
        i = 1 
        buffer:fill(0,0,0,0)
      end

      buffer:set(i, {0, 255, 255, 0})
      ws2812.write(buffer)
  end)
  effectTimer:start()
end


lights.SetColor = function(r, g, b, w) 
  buffer:fill(r, g, b, w)
  ws2812.write(buffer)
end

-- start an effect
lights.Effect = function(effect)
  if(effects[effect] and type(effects[effect] == "function"))then
    effects[effect]()
  end
end

return lights
