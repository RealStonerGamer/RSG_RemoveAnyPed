local VORPutils = {}
local createdBlips = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

Citizen.CreateThread(function()
    if Config.debug then
        RegisterCommand("clearBlips", function()
            RemoveAllCreatedBlips()
        end, false)

        for _, location in pairs(Config.Location) do
            local blip = VORPutils.Blips:SetBlip("test", 'blip_weapon_throwable', 0.2, location.coords.x,
                location.coords.y, location.coords.z)
            table.insert(createdBlips, blip)
            local radius = VORPutils.Blips:AddRadius(location.radius, location.coords.x, location.coords.y,
                location.coords.z, -1282792512)
            table.insert(createdBlips, radius)
        end
    end
end)

function RemoveAllCreatedBlips()
    for _, blip in ipairs(createdBlips) do
        if type(blip) == "number" then
            RemoveBlip(blip)
        elseif type(blip) == "table" then
            if blip.Remove then
                blip:Remove()
            elseif blip.rawblip then
                VORPutils.Blips:RemoveBlip(blip.rawblip)
            else
                print("Error: Could not identify blip format for removal.", blip)
            end
        else
            print("Error: Unexpected blip data type for removal.", blip)
        end
    end
    createdBlips = {} 
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        RemoveAllCreatedBlips()
    end
end)


function table.contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local allPeds = GetGamePool('CPed')
        for _, location in pairs(Config.Location) do
            local pedstoremoveHashes = {}
            for _, modelName in ipairs(location.Pedstoremove) do
                table.insert(pedstoremoveHashes, GetHashKey(modelName))
            end

            for i = 1, #allPeds do
                local ped = allPeds[i]
                if IsEntityAPed(ped) and ped ~= PlayerPedId() and not IsPedAPlayer(ped) then
                    local pedModelHash = GetEntityModel(ped)
                    local pedCoords = GetEntityCoords(ped)
                    local dist = GetDistanceBetweenCoords(pedCoords, location.coords.x, location.coords.y,
                        location.coords.z, true)
                    if dist < location.radius and table.contains(pedstoremoveHashes, pedModelHash) and not IsPedDeadOrDying(ped, true) then
                        DeleteEntity(ped)
                    end
                end
            end
        end
    end
end)
