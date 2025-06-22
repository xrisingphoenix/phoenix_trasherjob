
if Config.UseNewESX then
	ESX = exports["es_extended"]:getSharedObject()
else
	local ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
	end)
end

function getRandomReward()
    local totalWeight = 0
    for _, reward in ipairs(Config.RewardList) do
        totalWeight = totalWeight + reward.chance
    end

    local randomWeight = math.random(1, totalWeight)
    local cumulativeWeight = 0

    for _, reward in ipairs(Config.RewardList) do
        cumulativeWeight = cumulativeWeight + reward.chance
        if randomWeight <= cumulativeWeight then
            return reward
        end
    end
end

RegisterServerEvent("trash:getreward")
AddEventHandler("trash:getreward", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addAccountMoney(Config.Moneytype, Config.Reward)
    local random = math.random(1, 100)
    if random < Config.Chance then 
        local reward = getRandomReward()
        local item = reward.item
        local amount = math.random(reward.amount[1], reward.amount[2])
        
        TriggerClientEvent('esx:showNotification', xPlayer.source, Translation[Config.Locale]['found_trash'])
		
        xPlayer.addInventoryItem(item, amount)
    end
end)

RegisterServerEvent("getbonus")
AddEventHandler("getbonus", function(bonus)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney(Config.Moneytype, bonus)
	local name = xPlayer.getName()
	if Config.Webhook ~= "" then
		local webhook = Config.Webhook
		local information = {
			{
				["color"] = '6684876',
				["author"] = {
					["icon_url"] = 'https://i.ibb.co/DgtFmvr6/ps-logo-1-circle.png',
					["url"] = 'https://discord.com/invite/CUXK7CWx3P',
					["name"] = 'Phoenix Studios',
				},
				
				['url'] = 'https://github.com/xrisingphoenix/phoenix_trasherjob',
				["title"] = 'Trasher Job',
		
				["description"] = name .. " has done the Job and got the Bonus of "..bonus.." $",
		
				["footer"] = {
					["text"] = os.date('%d/%m/%Y [%X] • PHOENIX STUDIOS'),
					["icon_url"] = 'https://i.ibb.co/60rCYFmk/logo2.png',
				}
			}
		}
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'PHOENIX STUDIOS', embeds = information, avatar_url = 'https://i.ibb.co/mV504dFz/ps-logo-2-circle.png' }), {['Content-Type'] = 'application/json'}) 
	end
end)

RegisterServerEvent("trash:takebail")
AddEventHandler("trash:takebail", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney(Config.Moneytype, Config.Bail)
end)


RegisterServerEvent("givebailback")
AddEventHandler("givebailback", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney(Config.Moneytype, Config.Bail)
end)

RegisterServerEvent("givecurrentbon")
AddEventHandler("givecurrentbon", function(type, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney(type, amount)
end)

local timer = {}

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		timer[k] = {}
	 end
end)

RegisterServerEvent("ps_trasherjob:starttimer")
AddEventHandler("ps_trasherjob:starttimer", function(label)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.EnableCooldown then
		Citizen.CreateThread(function()
			-- timer[label][xPlayer.identifier] = {}
			-- Citizen.Wait(Config.ServerCooldown)
			-- timer[label][xPlayer.identifier] = nil
			timer[label] = {}
			Citizen.Wait(Config.ServerCooldown)
			timer[label] = nil
		end)
	end
end)

ESX.RegisterServerCallback('ps_trasherjob:istimer', function(source, cb, k)
	local xPlayer = ESX.GetPlayerFromId(source)
	-- print(timer[k][xPlayer.identifier])
	-- print("if "..k.. ' == '..json.encode(timer[k][xPlayer.identifier]))
	if timer[k][xPlayer.identifier] ~= nil then 
		cb(true)
	else 
		cb(false)
	end
end)
