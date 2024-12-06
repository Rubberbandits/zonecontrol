local AddCSLuaFile = AddCSLuaFile
local module = module
local error = error
local string = string
local GM = GM
local file = file
local pairs = pairs
local include = include
local AddCSLuaFile = AddCSLuaFile
local SERVER = SERVER
local CLIENT = CLIENT

AddCSLuaFile()

module("includes")

function is_clientside(file_name)
    return string.StartsWith(file_name, "cl_")
end

function is_shared(file_name)
    return string.StartsWith(file_name, "sh_")
end

function directory(path, recursive)
    local path = string.format("%s/gamemode/%s", GM.FolderName, path)
    if SERVER and not file.IsDir(path, "LUA") then
        return error(string.format("invalid path to directory: %s", path), 0)
    end

    local files = file.Find(string.format("%s/*.lua", path), "LUA", "namedesc")
    for _, name in pairs(files) do
        if SERVER then
            if is_clientside(name) or is_shared(name) then
                AddCSLuaFile(path.."/"..name)
            end

            if not is_clientside(name) then
                include(path.."/"..name)
            end
        elseif CLIENT then
            include(path.."/"..name)
        end
    end
end