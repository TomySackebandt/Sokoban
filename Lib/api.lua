local http = require("socket.http")

json = require "Lib/json"


function AllMap()

    levels = http.request("http://127.0.0.1:8000/api/Levels")

    levels=json.decode(levels)
    
    return levels
end

function Map(id)

    local url = "http://127.0.0.1:8000/api/Level/"..tostring(id)

    print(url)

    if(id ~= nil) then
        level = http.request(url)

        levels=json.decode(level)
        
        return levels
    else
        return "error"
    end
end