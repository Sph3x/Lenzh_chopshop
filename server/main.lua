ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("lenzh_chopshop:rewards")
AddEventHandler("lenzh_chopshop:rewards", function()
  Rewards()
end)

function Rewards(rewards)
  local xPlayer = ESX.GetPlayerFromId(source)
  	if not xPlayer then return; end

    for k,v in pairs(Config.Items) do
  		local randomCount = math.random(0, 3)
  		xPlayer.addInventoryItem(v, randomCount)
  	end
end

RegisterServerEvent('lenzh_chopshop:sell')
AddEventHandler('lenzh_chopshop:sell', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.Itemsprice[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)


	if xItem.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
		return
	end

	price = ESX.Math.Round(price * amount)

	if Config.GiveBlack then
		xPlayer.addAccountMoney('black_money', price)
	else
		xPlayer.addMoney(price)
	end

	xPlayer.removeInventoryItem(xItem.name, amount)

	TriggerClientEvent('esx:showNotification', source, _U('sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)
