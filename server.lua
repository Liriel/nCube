local controllers = {}
-- register controllers
controllers.api = require("apicontroller")

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
  from, to, controller, action, args = string.find(req.url, "/(%a+)/(%a+)/?(.*)")
  
  -- invoke controller
  if(controllers[controller])then
    print("looking for action ", action, controllers[controller][action],type(controllers[controller][action]))
    if(controllers[controller][action] and
       type(controllers[controller][action]) == "function")then
      
      -- each controller action must call res:finish()
      controllers[controller][action](res, args)
    else
      res:finish("controller action not found", 404)
    end
  
  -- check if a static file should be served
  elseif(controller == "static") then
    print("sending static file ", action)
    SendFile(action, res)

  -- send default file
  else
    SendFile("index.html", res)
  end
end)
