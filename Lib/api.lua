local http = require("socket.http")

json = require "Lib/json"

url = "http://reden.alwaysdata.net//api/"

function AllMap()

    levels = http.request(url.."Levels")

    levels=json.decode(levels)
    
    return levels
end

function Map(id)

    local url = url .. "Level/"..tostring(id)
    
    if(id ~= nil) then
        level = http.request(url)

        levels=json.decode(level)
        
        return levels
    else
        return "error"
    end
end