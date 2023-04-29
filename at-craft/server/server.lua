local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('at-craft:server:toggleItem', function(give, item, amount)
	local src = newsrc or source
	if give == 0 or give == false then
		if HasItem(src, item, amount or 1) then -- check if you still have the item
			if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount or 1) then
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount or 1)
				if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
			end
		else TriggerEvent("at-craft:server:DupeWarn", item, src) end -- if not boot the player
	else
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount or 1)
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
		end
	end
end)

RegisterServerEvent('at-craft:GetItem', function(data)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	if Player.Functions.AddItem(data.item, data.craftable[data.tablenumber]["amount"] or 1) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[data.item], "add", data.craftable[data.tablenumber]["amount"] or 1)
		if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[data.item].label.."^7(^2x^6"..(data.craftable[data.tablenumber]["amount"] or 1).."^7)'") end
		for k, v in pairs(data.craftable[data.tablenumber][data.item]) do
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v)
			Player.Functions.RemoveItem(tostring(k), v)
			if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[k].label.."^7(^2x^6"..v.."^7)'") end
		end
	end
TriggerClientEvent("at-craft:craftmenu", src, data)
end)


RegisterNetEvent("at-craft:server:DupeWarn", function(item, newsrc)
	local src = newsrc or source
	local P = QBCore.Functions.GetPlayer(src)
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Tried to remove item ^7('^3"..item.."^7')^2 but it wasn't there^7")
	DropPlayer(src, "Kicked for attempting to duplicate items")
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Dropped from server for item duplicating^7")
end)

-- [[CRAFTING EVENTS]] --

-- Beretta Handgun
RegisterNetEvent('at-craft:server:makeweaponpistol', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem("metalscrap", 50)
    Player.Functions.RemoveItem("iron", 50)
    Player.Functions.AddItem("weapon_pistol", 1)
end)

-- Pistol Ammo
RegisterNetEvent('at-craft:server:makepistolammo', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem("metalscrap", 50)
    Player.Functions.RemoveItem("iron", 50)
    Player.Functions.AddItem("pistol_ammo", 5)
end)

-- Pistol Clip
RegisterNetEvent('at-craft:server:makepistolclip', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.RemoveItem("metalscrap", 50)
    Player.Functions.RemoveItem("iron", 50)
    Player.Functions.AddItem("pistol_extendedclip", 1)
end)

----