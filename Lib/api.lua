local http = require("socket.http")

json = require "lib/json"

function AllMap()

    levels = http.request("http://127.0.0.1:8000/api/Levels")

    levels=json.decode(levels)
    
    return levels
end

function Map(id)

    level = http.request("http://127.0.0.1:8000/api/Level/"..id)

    levels=json.decode(level)
    
    return levels
end