lights = require("lights")

function SendFile(fileName, res)
  -- no need check if file exists - open returns nil for nonexistent files
  if file.open(fileName, "r") then
    buf = file.read()
    while(buf)do
      res:send(buf)
      buf = file.read()
    end
    file.close()
    res:finish()
  else
    res:finish(nil, 404)
  end
end


require("httpserver").createServer(80, function(req, res)
  -- analyse method and url
  print("+R", req.method, req.url, node.heap())
  from, to, controller, action, args = string.find(req.url, "/(.+)/(.+)/?(.*)")
  
  -- invoke api controller
  if(controller == "api")then
    if(action == "on") then
      lights.SetColor(255, 0, 255)
    elseif (action == "off") then
      lights.SetColor(0, 0, 0)
    end
    res:finish("OK")
  else
    SendFile("index.html", res)
  end
end)
