-- Variables
local isEscorting = false
local QRCore = exports['qr-core']:GetCoreObject()

-- Functions
exports('IsHandcuffed', function()
    return isHandcuffed
end)

local function loadAnimDict(dict) -- interactions, job,
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

local function IsTargetDead(playerId)
    local retval = false
    QRCore.Functions.TriggerCallback('sheriff:server:isPlayerDead', function(result)
        retval = result
    end, playerId)
    Wait(100)
    return retval
end

-- Events
RegisterNetEvent('sheriff:client:SetOutVehicle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)
    end
end)

RegisterNetEvent('sheriff:client:PutInVehicle', function()
    local ped = PlayerPedId()
    if isHandcuffed or isEscorted then
        local vehicle = QRCore.Functions.GetClosestVehicle()
        if DoesEntityExist(vehicle) then
			for i = GetVehicleMaxNumberOfPassengers(vehicle), 1, -1 do
                if IsVehicleSeatFree(vehicle, i) then
                    isEscorted = false
                    TriggerEvent('hospital:client:isEscorted', isEscorted)
                    ClearPedTasks(ped)
                    DetachEntity(ped, true, false)

                    Wait(100)
                    SetPedIntoVehicle(ped, vehicle, i)
                    return
                end
            end
		end
    end
end)

RegisterNetEvent('sheriff:client:SearchPlayer', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
        TriggerServerEvent("sheriff:server:SearchPlayer", playerId)
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:SeizeCash', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("sheriff:server:SeizeCash", playerId)
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:SeizeDriverLicense', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("sheriff:server:SeizeDriverLicense", playerId)
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)


RegisterNetEvent('sheriff:client:RobPlayer', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        local playerPed = GetPlayerPed(player)
        local playerId = GetPlayerServerId(player)

        if IsEntityPlayingAnim(playerPed, 'mech_busted@arrest', 'hands_up_transition', 3) then
            QRCore.Functions.Progressbar("robbing_player", Lang:t("progressbar.robbing"), math.random(5000, 7000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                local plyCoords = GetEntityCoords(playerPed)
                local pos = GetEntityCoords(ped)
                if #(pos - plyCoords) < 2.5 then
                    TriggerServerEvent("inventory:server:OpenInventory", "otherplayer", playerId)
                    TriggerEvent("inventory:server:RobPlayer", playerId)
                else
                    QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
                end
            end, function() -- Cancel
                QRCore.Functions.Notify(Lang:t("error.canceled"), 'error')
            end)
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:JailCommand', function(playerId, time)
    TriggerServerEvent("sheriff:server:JailPlayer", playerId, tonumber(time))
end)

RegisterNetEvent('sheriff:client:BillCommand', function(playerId, price)
    TriggerServerEvent("sheriff:server:BillPlayer", playerId, tonumber(price))
end)

RegisterNetEvent('sheriff:client:JailPlayer', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialogInput = LocalInput(Lang:t('info.jail_time_input'), 11)
        if tonumber(dialogInput) > 0 then
            TriggerServerEvent("sheriff:server:JailPlayer", playerId, tonumber(dialogInput))
        else
            QRCore.Functions.Notify(Lang:t("error.time_higher"), 'error')
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:BillPlayer', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        local dialogInput = LocalInput(Lang:t('info.jail_time_input'), 11)
        if tonumber(dialogInput) > 0 then
            TriggerServerEvent("sheriff:server:BillPlayer", playerId, tonumber(dialogInput))
        else
            QRCore.Functions.Notify(Lang:t("error.amount_higher"), 'error')
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:PutPlayerInVehicle', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("sheriff:server:PutPlayerInVehicle", playerId)
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:SetPlayerOutVehicle', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("sheriff:server:SetPlayerOutVehicle", playerId)
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:EscortPlayer', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("sheriff:server:EscortPlayer", playerId)
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:KidnapPlayer', function()
    local player, distance = QRCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) then
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("sheriff:server:KidnapPlayer", playerId)
            end
        end
    else
        QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
    end
end)

RegisterNetEvent('sheriff:client:CuffPlayerSoft', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QRCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                TriggerServerEvent("sheriff:server:CuffPlayer", playerId, true)
                -- HandCuffAnimation()
            else
                QRCore.Functions.Notify(Lang:t("error.vehicle_cuff"), 'error')
            end
        else
            QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('sheriff:client:CuffPlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QRCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.5 then
            QRCore.Functions.TriggerCallback('QRCore:HasItem', function(result)
                if result then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(PlayerPedId()) then
                        TriggerServerEvent("sheriff:server:CuffPlayer", playerId, false)
                        -- HandCuffAnimation()
                    else
                        QRCore.Functions.Notify(Lang:t("error.vehicle_cuff"), 'error')
                    end
                else
                    QRCore.Functions.Notify(Lang:t("error.no_cuff"), 'error')
                end
            end, Config.HandCuffItem)
        else
            QRCore.Functions.Notify(Lang:t("error.none_nearby"), 'error')
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('sheriff:client:GetEscorted', function(playerId)
    local ped = PlayerPedId()
    QRCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('sheriff:client:DeEscort', function()
    isEscorted = false
    TriggerEvent('hospital:client:isEscorted', isEscorted)
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('sheriff:client:GetKidnappedTarget', function(playerId)
    local ped = PlayerPedId()
    QRCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or isHandcuffed then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                -- RequestAnimDict("nm")

                -- while not HasAnimDictLoaded("nm") do
                --     Wait(10)
                -- end
                AttachEntityToEntity(ped, dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
                -- TaskPlayAnim(ped, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
                ClearPedTasksImmediately(ped)
            end
            TriggerEvent('hospital:client:isEscorted', isEscorted)
        end
    end)
end)

RegisterNetEvent('sheriff:client:GetKidnappedDragger', function(playerId)
    QRCore.Functions.GetPlayerData(function(PlayerData)
        if not isEscorting then
            draggerId = playerId
            local dragger = PlayerPedId()
            -- RequestAnimDict("missfinale_c2mcs_1")

            -- while not HasAnimDictLoaded("missfinale_c2mcs_1") do
            --     Wait(10)
            -- end
            -- TaskPlayAnim(dragger, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
            isEscorting = true
        else
            local dragger = PlayerPedId()
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('hospital:client:SetEscortingState', isEscorting)
        TriggerEvent('qr-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

RegisterNetEvent('sheriff:client:GetCuffed', function(playerId, isSoftcuff)
    local ped = PlayerPedId()
    if not isHandcuffed then
        isHandcuffed = true
        TriggerServerEvent("sheriff:server:SetHandcuffStatus", true)
        ClearPedTasksImmediately(ped)
        if Citizen.InvokeNative(0x8425C5F057012DAB,ped) ~= GetHashKey("WEAPON_UNARMED") then
            SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
        end
        if not isSoftcuff then
            cuffType = 16
            -- GetCuffedAnimation(playerId)
            QRCore.Functions.Notify(Lang:t("info.cuff"), 'primary')
        else
            cuffType = 49
            -- GetCuffedAnimation(playerId)
            QRCore.Functions.Notify(Lang:t("info.cuffed_walk"), 'primary')
        end
    else
        isHandcuffed = false
        isEscorted = false
        TriggerEvent('hospital:client:isEscorted', isEscorted)
        DetachEntity(ped, true, false)
        TriggerServerEvent("sheriff:server:SetHandcuffStatus", false)
        ClearPedTasksImmediately(ped)
        SetEnableHandcuffs(ped, false)
        DisablePlayerFiring(ped, false)
        SetPedCanPlayGestureAnims(ped, true)
        DisplayRadar(true)
        if cuffType == 49 then
            FreezeEntityPosition(ped, false)
        end
        -- TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
        QRCore.Functions.Notify(Lang:t("success.uncuffed"), 'success')
    end
end)

-- Threads
CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Wait(1)
        if isEscorted or isHandcuffed then
            DisableControlAction(0, 0x295175BF, true) -- Disable break
            DisableControlAction(0, 0x6E9734E8, true) -- Disable suicide
            DisableControlAction(0, 0xD8F73058, true) -- Disable aiminair
            DisableControlAction(0, 0x4CC0E2FE, true) -- B key
            DisableControlAction(0, 0xDE794E3E, true) -- Cover
            DisableControlAction(0, 0x06052D11, true) -- Cover
            DisableControlAction(0, 0x5966D52A, true) -- Cover
            DisableControlAction(0, 0xCEFD9220, true) -- Cover
            DisableControlAction(0, 0xC75C27B0, true) -- Cover
            DisableControlAction(0, 0x41AC83D1, true) -- Cover
            DisableControlAction(0, 0xADEAF48C, true) -- Cover
            DisableControlAction(0, 0x9D2AEA88, true) -- Cover
            DisableControlAction(0, 0xE474F150, true) -- Cover
            DisableControlAction(0, 0xB2F377E8, true) -- Attack
			DisableControlAction(0, 0xC1989F95, true) -- Attack 2
			DisableControlAction(0, 0x07CE1E61, true) -- Melee Attack 1
			DisableControlAction(0, 0xF84FA74F, true) -- MOUSE2
			DisableControlAction(0, 0xCEE12B50, true) -- MOUSE3
			DisableControlAction(0, 0x8FFC75D6, true) -- Shift
			DisableControlAction(0, 0xD9D0E1C0, true) -- SPACE
            DisableControlAction(0, 0xF3830D8E, true) -- J
            DisableControlAction(0, 0x80F28E95, true) -- L
            DisableControlAction(0, 0xDB096B85, true) -- CTRL
            DisableControlAction(0, 0xE30CD707, true) -- R
        end

        if isHandcuffed then
            -- if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not QRCore.Functions.GetPlayerData().metadata["isdead"] then
            --     loadAnimDict("mp_arresting")
            --     TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            -- end
        end

        if cuffType == 16 and isHandcuffed then  -- soft cuff
            SetEnableHandcuffs(ped, true)
            DisablePlayerFiring(ped, true)
            SetPedCanPlayGestureAnims(ped, false)
            DisplayRadar(false)
        end

        if cuffType == 49 and isHandcuffed then  -- hard cuff
            SetEnableHandcuffs(ped, true)
            DisablePlayerFiring(ped, true)
            SetPedCanPlayGestureAnims(ped, false)
            DisplayRadar(false)
            FreezeEntityPosition(ped, true)
        end

        if not isHandcuffed and not isEscorted then
            Wait(2000)
        end
    end
end)
