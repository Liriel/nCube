lights = require("lights")

local apicontroller = {}

apicontroller.on = function (res)
  lights.SetColor(255, 0, 244, 0)
  res:finish("OK")
end

apicontroller.effect = function(res, effect)
  lights.Effect(effect)
  res:finish("OK")
end

apicontroller.off = function (res)
  lights.SetColor(0, 0, 0, 0)
  res:finish("OK")
end

apicontroller.set = function(res, color)
  
  print(color)
  -- split the color in its components
  if(color:len() ~= 8) then
    res:finish("invalid color. format: 0xRRGGBBWW", 400)
    return
  end

  if(not pcall(function()tonumber(color, 16)end)) then
    res:finish("invalid color. format: 0xRRGGBBWW", 400)
    return
  end

  r = tonumber(color:sub(1,2), 16)
  g = tonumber(color:sub(2,4), 16)
  b = tonumber(color:sub(4,6), 16)
  w = tonumber(color:sub(6,8), 16)

  lights.SetColor(r,g,b,w)
  res:finish("OK")
end

return apicontroller
