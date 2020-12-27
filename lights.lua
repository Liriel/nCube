
local lights = {}

ws2812.init(ws2812.MODE_SINGLE)
local buffer = ws2812.newBuffer(4, 3)

lights.SetColor = function(r, g, b) 
  buffer:fill(r, g, b)
  ws2812.write(buffer)
end

return lights
