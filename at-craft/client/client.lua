local QBCore = exports['qb-core']:GetCoreObject()
local Targets = {},  false
local PlayerData = {}
-------------------------------------------------

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerData.gang = GangInfo
end)

-- [[GANG CRAFT LOCATIONS]] --
Citizen.CreateThread(function()  
    exports['qb-target']:AddBoxZone('at_craft', vector3(2522.21, 4103.83, 35.54), 2.9, 1,
    { name='at_craft', heading=0.0, debugPoly=false, minZ=35.50, maxZ=36.50, }, 
    { options = { { event = 'at-craft:craftmenu', icon = 'fa-solid fa-wrench', label = 'Crafting Station', gang = 'aod' }, },
        distance = 1.5
    })
end)
---



-- [[CRAFTING MENU]] --
RegisterNetEvent('at-craft:craftmenu', function(data)
    exports['qb-menu']:openMenu({
        { header = '🛠️ Crafting Station', isMenuHeader = true, },
        { header = 'Beretta Handgun', txt = "Requires:</p>Metal Scrap x50 | Iron x50  ", icon = "fa-solid fa-gun", params = { event = 'at-craft:client:makeweaponpistol' } },
        { header = 'Pistol Ammo', txt = "Requires:</p>Metal Scrap x50 | Iron x50  ", icon = "fa-solid fa-gun", params = { event = 'at-craft:client:makepistolammo' } },
        { header = 'Pistol Extended Clip', txt = "Requires:</p>Metal Scrap x50 | Iron x50  ", icon = "fa-solid fa-gun", params = { event = 'at-craft:client:makepistolclip' } },
        { header = 'Close Menu', txt = '', params = { event = 'qb-menu:closeMenu', } },
    })
end)


-- [[WEAPON EVENTS]] --
-- Beretta Handgun
RegisterNetEvent('at-craft:client:makeweaponpistol', function()
    local ingredients = QBCore.Functions.HasItem({'metalscrap', 'iron'})
    if ingredients then
        QBCore.Functions.Progressbar('making_food', 'Crafting Beretta Handgun..', 4000, false, false, 
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
        { animDict = 'amb@prop_human_parking_meter@male@idle_a', anim = 'idle_a', flags = 8, }, {}, {}, function()
            TriggerServerEvent("at-craft:server:makeweaponpistol")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["metalscrap"], "remove", 50)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["iron"], "remove", 50)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["weapon_pistol"], "add", 1)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('at-craft:client:craft')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('at-craft:client:craft')
        end)
    else	
        QBCore.Functions.Notify('You are missing items..', 'error')
    end
end)


-- Pistol Ammo
RegisterNetEvent('at-craft:client:makepistolammo', function()
    local ingredients = QBCore.Functions.HasItem({'metalscrap', 'iron'})
    if ingredients then
        QBCore.Functions.Progressbar('making_food', 'Crafting Pistol Ammo..', 4000, false, false, 
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
        { animDict = 'amb@prop_human_parking_meter@male@idle_a', anim = 'idle_a', flags = 8, }, {}, {}, function()
            TriggerServerEvent("at-craft:server:makepistolammo")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["metalscrap"], "remove", 50)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["iron"], "remove", 50)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["pistol_ammo"], "add", 5)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('at-craft:client:craft')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('at-craft:client:craft')
        end)
    else	
        QBCore.Functions.Notify('You are missing items..', 'error')
    end
end)


-- Pistol Extended Clip
RegisterNetEvent('at-craft:client:makepistolclip', function()
    local ingredients = QBCore.Functions.HasItem({'metalscrap', 'iron'})
    if ingredients then
        QBCore.Functions.Progressbar('making_food', 'Crafting Pistol Extended Clip..', 4000, false, false, 
        { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
        { animDict = 'amb@prop_human_parking_meter@male@idle_a', anim = 'idle_a', flags = 8, }, {}, {}, function()
            TriggerServerEvent("at-craft:server:makepistolclip")
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["metalscrap"], "remove", 50)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["iron"], "remove", 50)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["pistol_extendedclip"], "add", 1)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('at-craft:client:craft')
        end, function() -- Cancel
            QBCore.Functions.Notify("Okay then", "error")
            TriggerEvent('at-craft:client:craft')
        end)
    else	
        QBCore.Functions.Notify('You are missing items..', 'error')
    end
end)




----

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1500)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Wait(1500)
end)