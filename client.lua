local createdBlips = {}

Citizen.CreateThread(function()
    if Config.debug then
        RegisterCommand("clearBlips", function()
            RemoveAllCreatedBlips()
        end, false)
        for _, location in pairs(Config.Location) do
            local radiusBlip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, location.coords.x, location.coords
            .y, location.coords.z, location.radius)
            Citizen.InvokeNative(0x662D364ABF16DE2F, radiusBlip, GetHashKey(location.blipColor))
            table.insert(createdBlips, {radiusBlip = radiusBlip })
        end
    end
end)

function RemoveAllCreatedBlips()
    for _, blipEntry in ipairs(createdBlips) do
        if blipEntry.radiusBlip then
            RemoveBlip(blipEntry.radiusBlip)
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
        Citizen.Wait(1000)
        local playerCoords = GetEntityCoords(PlayerPedId())
        for _, location in pairs(Config.Location) do
            local dist = GetDistanceBetweenCoords(playerCoords, location.coords.x, location.coords.y, location.coords.z,
                true)
            if dist < location.radius then
                CheckAndRemovePeds(location)
                break
            end
        end
    end
end)

function CheckAndRemovePeds(location)
    local allPeds = GetGamePool('CPed')
    local pedstoremoveHashes = {}
    local exemptedDeadPedHashes = {}

    for _, modelName in ipairs(location.Pedstoremove) do
        table.insert(pedstoremoveHashes, GetHashKey(modelName))
    end

    for _, modelName in ipairs(location.DeadPedExemptions or {}) do
        table.insert(exemptedDeadPedHashes, GetHashKey(modelName))
    end

    for i = 1, #allPeds do
        local ped = allPeds[i]
        if IsEntityAPed(ped) and ped ~= PlayerPedId() and not IsPedAPlayer(ped) then
            local pedModelHash = GetEntityModel(ped)
            local pedCoords = GetEntityCoords(ped)
            local dist = GetDistanceBetweenCoords(pedCoords, location.coords.x, location.coords.y, location.coords.z, true)
            local isDeadOrDying = IsPedDeadOrDying(ped, true)
            local shouldBeRemovedAnyways = table.contains(exemptedDeadPedHashes, pedModelHash)

            if dist < location.radius and table.contains(pedstoremoveHashes, pedModelHash) and (not isDeadOrDying or shouldBeRemovedAnyways) then
                DeleteEntity(ped)
            end
        end
    end
end