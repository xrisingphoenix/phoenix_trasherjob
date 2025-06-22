
if Config.UseNewESX then
    ESX = exports["es_extended"]:getSharedObject()
else
    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end

AddEventHandler('onClientResourceStart', function(ressourceName)
    if(GetCurrentResourceName() ~= ressourceName) then 
        return 
    end 
    print("" ..ressourceName.." started sucessfully")
end)

local count = 1
local curr_label
local endstufe = false
local curr_bonus = 0
local clothing = false

local timer = {}

step2 = false 
step3 = false
endstep = false

step6 = true
busy = false
busy2 = false
blipactive = false
delete = false
spawnprop = false
inhand = false
pressed = false
trashinhand = false
zuruecklegen = false
busy3 = false
step5 = false
text = false

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		timer[k] = {}
	 end
end)


function starttimer(k)
    if Config.EnableCooldown then
        timer[k][GetPlayerName(PlayerId())] = {}
        Citizen.Wait(Config.ClientCooldown)
        timer[k][GetPlayerName(PlayerId())] = nil
    end
end

function endjob()
    RemoveBlip(FirstBlip)
    DeleteEntity(Prop)
    DeleteEntity(garbagebag)
    curr_bonus = 0
    busy = false
    busy2 = false
    delete = false
    spawnprop = false
    inhand = false
    pressed = false
    trashinhand = false
    zuruecklegen = false
    busy3 = false
    step5 = false
    text = false
    step6 = false
end 

function startjob()
    step6 = true
    blipactive = false
    delete = false
    spawnprop = false
    inhand = false
    pressed = false
    trashinhand = false
    zuruecklegen = false
    busy3 = false
    step5 = false
    text = false
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        for k, v in pairs(Config.StartMission) do 
            local player = PlayerPedId()
            local playercoords = GetEntityCoords(player)
            local dst = Vdist(playercoords, v.startcoords.x , v.startcoords.y, v.startcoords.z)
            if dst < 3 then 
                if not Config.UseOxTarget then
                    DrawText3D(v.startcoords.x , v.startcoords.y, v.startcoords.z, Translation[Config.Locale]['start_mission_text'])
                end
                if IsControlJustReleased(0, 38) and not Config.UseOxTarget then 
                    if not IsPedInAnyVehicle(player, false) then
                        openmenu()
                    else
                        Config.MSG(Translation[Config.Locale]['cant_do_in_vehicle'])
                    end     
                end
            end 
        end 
    end
end)

function openmenu()
    local hasjob = false
    if not Config.Job.enable then 
        hasjob = true 
    else 
        if Config.Job.name == ESX.PlayerData.job.name then 
            hasjob = true 
        end
    end
    if hasjob then
        lib.registerContext({
            id = 'trash_1', 
            title = Translation[Config.Locale]['trasherjob_blip'],
            icon = 'user',
            options = {
                {
                    icon = 'fa-solid fa-truck-moving',
                    iconColor = 'green',
                    title = Translation[Config.Locale]['menu_start_job'],
                    description = Translation[Config.Locale]['menu_start_job_desc'],
                    arrow = true,
                    onSelect = function()
                        if not busy then
                            openzonemenu()
                        else 
                            Config.MSG(Translation[Config.Locale]['already_startet_mission']) 
                        end
                    end, 
                },
                {
                    icon = 'fa-solid fa-ban',
                    iconColor = 'red',
                    title = Translation[Config.Locale]['menu_end_job'],
                    description = Translation[Config.Locale]['menu_end_job_desc'],
                    arrow = true,
                    onSelect = function()
                        if busy then 
                            if not IsPedInAnyVehicle(PlayerPedId(), false) and busy then 
                                oxstop = false
                                local playercoords = GetEntityCoords(PlayerPedId())
                                local vehiclecoords = GetEntityCoords(missionvehicle)
                                local distance = Vdist(playercoords, vehiclecoords)
                                if distance < 100 and DoesEntityExist(missionvehicle) then
                                    if Config.Bail > 0 then
                                        showPictureNotification('CHAR_CHEF', string.format(Translation[Config.Locale]['back_bail'], Config.Bail), 'Chef', '')
                                        TriggerServerEvent("trash:givebailback")
                                    end
                                    if count > #Config.Zones[curr_label] then
                                        showPictureNotification('CHAR_CHEF', string.format(Translation[Config.Locale]['picturenotify_bonus_desc'], curr_bonus), Translation[Config.Locale]['picturenotify_bonus_title'], '')
                                        TriggerServerEvent("getbonus", curr_bonus)
                                    end
                                    DeleteEntity(missionvehicle)
                                    DeleteEntity(Prop)
                                    count = 1
                                    Config.MSG(Translation[Config.Locale]['canceled_mission'])
                                    busy = false
                                    endstufe = false
                                    step2 = false
                                    endjob()
                                    RemoveBlip(FirstBlip)
                                    Citizen.CreateThread(function()
                                        starttimer(curr_label)
                                    end)
                                    -- TriggerServerEvent("ps_trasherjob:starttimer", curr_label)
                                else 
                                    if Config.Bail > 0 then
                                        local dialog = lib.inputDialog(Translation[Config.Locale]['truck_not_there'], {
                                            {type = 'checkbox', label = Translation[Config.Locale]['truck_not_there_desc']},
                                            }
                                        )
                                        if dialog ~= nil then 
                                            if dialog[1] then 
                                                Config.MSG(Translation[Config.Locale]['trasher_not_nearby'])
                                                DeleteEntity(missionvehicle)
                                                DeleteEntity(Prop)
                                                Config.MSG(Translation[Config.Locale]['canceled_mission'])
                                                busy = false
                                                endjob()
                                                endstufe = false
                                                step2 = false
                                                RemoveBlip(FirstBlip)
                                                Citizen.CreateThread(function()
                                                    starttimer(curr_label)
                                                end)
                                                -- TriggerServerEvent("ps_trasherjob:starttimer", curr_label) -- ToDO
                                                count = 1
                                            end
                                        end
                                    else 
                                        endstufe = false
                                        step2 = false
                                        DeleteEntity(missionvehicle)
                                        DeleteEntity(Prop)
                                        Config.MSG(Translation[Config.Locale]['canceled_mission'])
                                        busy = false
                                        endjob()
                                        RemoveBlip(FirstBlip)
                                        Citizen.CreateThread(function()
                                            starttimer(curr_label)
                                        end)
                                        -- TriggerServerEvent("ps_trasherjob:starttimer", curr_label)
                                    end
                                end
                            else 
                                Config.MSG(Translation[Config.Locale]['cant_do_in_vehicle'])
                            end 
                        else
                            Config.MSG(Translation[Config.Locale]['job_not_started']) 
                        end
                    end,
                },
                {
                    icon = 'fa-solid fa-shirt',
                    iconColor = 'white',
                    title = Translation[Config.Locale]['menu_change_clothing'],
                    description = Translation[Config.Locale]['menu_change_clothing_desc'],
                    arrow = true,
                    onSelect = function()
                        applyclothing()
                    end, 
                },
            }
        })
        lib.showContext('trash_1')
    else 
       Config.MSG(Translation[Config.Locale]['dont_have_job']) 
    end
end

function applyclothing()
    local playerPed = PlayerPedId()
    RequestAnimDict("clothingshirt")
    while not HasAnimDictLoaded("clothingshirt") do 
        Citizen.Wait(25)
    end 
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 1.0, -1.0, -1, 1, 1, true, true, true)
    Citizen.Wait(2000)
    ClearPedTasks(playerPed)
    if not clothing then
        clothing = true
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if skin.sex == 0 then
                SetPedComponentVariation(playerPed, 11, Config.Clothing['male']['Torso'].id , Config.Clothing['male']['Torso'].txt , 2)  -- Torso
                SetPedComponentVariation(playerPed, 8, Config.Clothing['male']['TShirt'].id , Config.Clothing['male']['TShirt'].txt , 2) -- Shirt
                SetPedComponentVariation(playerPed, 3, Config.Clothing['male']['Arms'].id , Config.Clothing['male']['Arms'].txt , 2) -- Arms
                SetPedComponentVariation(playerPed, 4, Config.Clothing['male']['Pants'].id , Config.Clothing['male']['Pants'].txt , 2) -- Pants
                SetPedComponentVariation(playerPed, 6, Config.Clothing['male']['Shoes'].id , Config.Clothing['male']['Shoes'].txt , 2) -- Shoes
                SetPedPropIndex(playerPed, 0, Config.Clothing['male']['Hat'].id , Config.Clothing['male']['Hat'].txt, true) -- Hat
            else 
                SetPedComponentVariation(playerPed, 11, Config.Clothing['female']['Torso'].id , Config.Clothing['female']['Torso'].txt , 2)  -- Torso
                SetPedComponentVariation(playerPed, 8, Config.Clothing['female']['TShirt'].id , Config.Clothing['female']['TShirt'].txt , 2) -- Shirt
                SetPedComponentVariation(playerPed, 3, Config.Clothing['female']['Arms'].id , Config.Clothing['female']['Arms'].txt , 2) -- Arms
                SetPedComponentVariation(playerPed, 4, Config.Clothing['female']['Pants'].id , Config.Clothing['female']['Pants'].txt , 2) -- Pants
                SetPedComponentVariation(playerPed, 6, Config.Clothing['female']['Shoes'].id , Config.Clothing['female']['Shoes'].txt , 2) -- Shoes
                SetPedPropIndex(playerPed, 0, Config.Clothing['female']['Hat'].id , Config.Clothing['female']['Hat'].txt, true) -- Hat
            end 
        end)
    else 
        clothing = false
        resetclothes()
    end
    lib.showContext('trash_1')
end

function resetclothes()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function openzonemenu()
    local _options = {}
    if Config.EnableZones then
        for k,v in pairs(Config.Zones) do

            local o_read = false
            local desc = string.format(Translation[Config.Locale]['choose_this_tour'], tostring(#v))
      
            if timer[k][GetPlayerName(PlayerId())] then
                o_read = true
                desc = Translation[Config.Locale]['already_done_tour']
            end
            _options[#_options+1] = {
                title = k,
                description = desc,
                icon = 'fa-solid fa-route', 
                disabled = o_read,
                onSelect = function()
                    if not busy then 
                        local dialog = lib.inputDialog(Translation[Config.Locale]['menu_start_job'], {
                            {type = 'checkbox', label = string.format(Translation[Config.Locale]['check_start_this_tour'], k)},
                            }
                        )
                        if dialog ~= nil then 
                            if dialog[1] then 
                                _startjob(v,k)
                            end 
                        end
                    end
                end,
                arrow = not o_read
            }
        end
        
        lib.registerContext({
            id = 'trash_2',
            title = Translation[Config.Locale]['menu_choose_zone'],
            menu = "trash_1",
            options = _options
            })
        lib.showContext('trash_2')
    else 
        lib.registerContext({
            id = 'trash_2',
            title = Translation[Config.Locale]['menu_choose_zone'],
            menu = "trash_1",
            options = {
                {
                    title = Translation[Config.Locale]['default'],
                    description = Translation[Config.Locale]['menu_start_job'],
                    icon = 'fa-solid fa-route', 
                    onSelect = function()
                        if not busy then 
                            _startjob(v,k)
                        end
                    end,
                    arrow = true
                }
            }
            })
        lib.showContext('trash_2')
    end
end

function _startjob(data, label)
    curr_label =  label
    busy = true
    startjob()
    busy2 = true
    busy3 = true
    local player = PlayerPedId()
    for k,v in pairs(Config.StartMission) do
        local car = GetHashKey(v.vehiclespawnname)
        RequestModel(car)
        while not HasModelLoaded(car) do
            RequestModel(car)
            Citizen.Wait(50)
        end
        vehicle = CreateVehicle(car, v.vehiclespawncoords.x, v.vehiclespawncoords.y, v.vehiclespawncoords.z, v.vehiclespawncoords.w, true, false)
        Config.Fuel(vehicle)
        -- SetVehicleNumberPlateText(vehicle, 'TRASH')
        SetVehicleNumberPlateTextIndex(vehicle, 1)
        Config.MSG(Translation[Config.Locale]['sucessfully_started_mission'])
        if Config.Bail > 0 then
            showPictureNotification('CHAR_CHEF', string.format(Translation[Config.Locale]['took_bail'], Config.Bail), 'Chef', '')
            TriggerServerEvent("trash:takebail")
        end
        Citizen.CreateThread(function()
            while true do 
                    Citizen.Wait(0)
                    if busy and not spawnprop then
                        spawnprop = true
                        local playerPed = PlayerPedId()
                        local nowcoords = GetEntityCoords(playerPed)
                        missionvehicle = vehicle
                        RequestModel(GetHashKey("prop_cs_bin_03"))
                        while not HasModelLoaded("prop_cs_bin_03") do 
                            Citizen.Wait(1)
                        end
                    end
                    if busy then
                        if not blipactive then
                            blipactive = true
                            if Config.EnableZones then 
                                results = Config.Zones[curr_label][count]
                            else
                                results = Config.SpawnProps[math.random(#Config.SpawnProps)]
                            end
                            Prop = CreateObject(GetHashKey("prop_cs_bin_03"), results.x, results.y, results.z -1.0, Config.VisibleforOtherPlayer, false, false)
                            SetEntityHeading(Prop, results.w)
                            FreezeEntityPosition(Prop, true)
                            FirstBlip = AddBlipForCoord(results.x, results.y, results.z)
                            SetBlipSprite(FirstBlip, 1)
                            SetBlipScale(FirstBlip, 0.9)
                            SetBlipColour(FirstBlip, 2)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(Translation[Config.Locale]['prop_blip_name'])
                            EndTextCommandSetBlipName(FirstBlip)
                            SetBlipRoute(FirstBlip, true)
                            delete = false
                            step5 = true
                        end
                    end
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if busy2 and step5 and step6 then                              
            DrawMarker(0, results.x, results.y, results.z + 0.85, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.1, 232,224,6, 150, 1, 0, 2, 0, 0, 0, 0) -- gelb
            local playerPed = PlayerPedId()
            local jetztcoords = GetEntityCoords(playerPed)
            local distanz = Vdist(jetztcoords, results.x, results.y, results.z)
            if distanz < 2 and not text then 
                DrawText3D(results.x, results.y, results.z , Translation[Config.Locale]['press_e_to_take_trash'])
            end
            
        end
        if busy3 and step5 and step6 and not inhand then 
            
            local playerPed = PlayerPedId()
            local nowcoords = GetEntityCoords(playerPed)
            local propdistance = Vdist(nowcoords, results.x, results.y, results.z)
            if propdistance < 3 and not delete then 
                if IsControlJustPressed(0, 38) and not pressed then
                    if not IsPedInAnyVehicle(playerPed, false) then
                        Config.MSG(Translation[Config.Locale]['step1'])
                        text = true
                        busy2 = false
                        trashinhand = true
                        pressed = true
                        DeleteEntity(Prop)
                        RequestAnimDict('anim@heists@box_carry@')
                        while not HasAnimDictLoaded('anim@heists@box_carry@') do
                            Citizen.Wait(1)
                        end
                        TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 1.0, -8.0, -1, 49, 0, false, false, false)
                        garbagebag = CreateObject(GetHashKey("prop_cs_bin_03"), 0, 0, 0, true, true, true) -- creates object
                        AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.00, -0.420, -1.290, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                        inhand = true
                    else 
                        Config.MSG(Translation[Config.Locale]['cant_do_in_vehicle'])
                    end 
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
            if trashinhand then 
                local playerPed = PlayerPedId()
                local trunkpos = GetWorldPositionOfEntityBone(missionvehicle, GetEntityBoneIndexByName(missionvehicle, "boot"))
                local playerCoords = GetEntityCoords(playerPed)
                local Distance = Vdist(playerCoords, trunkpos.x , trunkpos.y, trunkpos.z)
                if Distance < 3 then
                    DrawText3D(trunkpos.x , trunkpos.y, trunkpos.z , Translation[Config.Locale]['press_to_take_trunk'])
                    -- shownotify('~g~[E]~s~ Mülltonne entleeren')
                    if IsControlJustReleased(0, 38) then 
                        if not IsPedInAnyVehicle(playerPed, false) then 
                            if Config.UseMiniGame then
                                game = exports["k5_skillcheck"]:skillCheck("easy")
                                if game then 
                                    if Config.UseAnProgbar then
                                        SetVehicleDoorOpen(missionvehicle, 5, false, false)
                                        exports['an_progBar']:run(2,Translation[Config.Locale]['trash_empty'],'#E14127')
                                        Citizen.Wait(2000)
                                        SetVehicleDoorShut(missionvehicle, 5, false)
                                    else 
                                        SetVehicleDoorOpen(missionvehicle, 5, false, false)
                                        Citizen.Wait(2000)
                                        SetVehicleDoorShut(missionvehicle, 5, false)
                                    end
                                    Config.MSG(Translation[Config.Locale]['bring_can_back'])
                                    DeleteEntity(garbagebag)
                                    trash2 = CreateObject(GetHashKey("prop_cs_bin_01_skinned"), 0, 0, 0, true, true, true) -- creates object
                                    AttachEntityToEntity(trash2, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.00, -0.420, -1.290, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                    zuruecklegen = true
                                    trashinhand = false
                                    step2 = true
                                    Citizen.Wait(1000)
                                    step3 = true
                                    endstep = false
                                    -- inhand = false
                                end
                            else 
                                if Config.UseAnProgbar then
                                    SetVehicleDoorOpen(missionvehicle, 5, false, false)
                                    exports['an_progBar']:run(2,Translation[Config.Locale]['trash_empty'],'#E14127')
                                    Citizen.Wait(2000)
                                    SetVehicleDoorShut(missionvehicle, 5, false)
                                else 
                                    SetVehicleDoorOpen(missionvehicle, 5, false, false)
                                    Citizen.Wait(2000)
                                    SetVehicleDoorShut(missionvehicle, 5, false)
                                end
                                Config.MSG(Translation[Config.Locale]['bring_can_back'])
                                DeleteEntity(garbagebag)
                                trash2 = CreateObject(GetHashKey("prop_cs_bin_01_skinned"), 0, 0, 0, true, true, true) -- creates object
                                AttachEntityToEntity(trash2, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 28422), 0.00, -0.420, -1.290, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                zuruecklegen = true
                                trashinhand = false
                                step2 = true
                                Citizen.Wait(1000)
                                step3 = true
                                endstep = false
                            end
                        else 
                            Config.MSG(Translation[Config.Locale]['cant_do_in_vehicle'])
                        end
                    end
                end 
            end
            if step2 then 
                if not endstufe then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local destence = Vdist(playerCoords, results.x, results.y, results.z)
                    if destence < 10 then
                        DrawMarker(0, results.x, results.y, results.z, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.1, 18,222,86, 150, 1, 0, 2, 0, 0, 0, 0)
                        if not endstep then 
                            if destence < 2 then 
                                DrawText3D(results.x, results.y, results.z , Translation[Config.Locale]['press_to_bring_trash_back'])
                                if IsControlJustReleased(0, 38) and step3 then 
                                    if not IsPedInAnyVehicle(playerPed, false) then
                                        endstep = true
                                        DeleteEntity(trash2)
                                        local Prop2 = CreateObject(GetHashKey("prop_cs_bin_01_skinned"), results.x, results.y, results.z - 1.0, false, false, false)
                                        SetEntityHeading(Prop2, results.w)
                                        ClearPedTasks(playerPed)
                                        RemoveBlip(FirstBlip)
                                        
                                        showPictureNotification('CHAR_CHEF', string.format(Translation[Config.Locale]['reward'], Config.Reward), Translation[Config.Locale]['reward_title'], '')
                                        TriggerServerEvent("trash:getreward")
                                        curr_bonus = curr_bonus + Config.BonusPerTrash
                                        if Config.EnableZones then
                                            count = count + 1
                                            if count > #Config.Zones[curr_label] then 
                                                endstufe = true
                                                showPictureNotification('CHAR_CHEF', Translation[Config.Locale]['finished_tour_desc'], Translation[Config.Locale]['finished_tour_title'], '')
                                            else 
                                                pressed = false
                                                blipactive = false
                                                inhand = false
                                                busy2 = true
                                                text = false
                                                step2 = false
                                            end
                                        else
                                            pressed = false
                                            blipactive = false
                                            inhand = false
                                            busy2 = true
                                            text = false
                                            step2 = false
                                        end
                                        Citizen.Wait(5000)
                                        DeleteEntity(Prop2)
                                    else 
                                        Config.MSG(Translation[Config.Locale]['cant_do_in_vehicle'])
                                    end
                                end
                            end 
                        end
                    end
                end
            end 
    end      
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.StartMission) do 
        local Blip = AddBlipForCoord(v.startcoords.x, v.startcoords.y, v.startcoords.z)
        SetBlipSprite(Blip, 318)
        SetBlipDisplay(Blip, 4)
        SetBlipScale(Blip, 0.8)
        SetBlipColour(Blip, 2)
        SetBlipAsShortRange(Blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Translation[Config.Locale]['trasherjob_blip'])
        EndTextCommandSetBlipName(Blip)
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.StartMission) do
        RequestModel(GetHashKey(v.pedname))
        while not HasModelLoaded(GetHashKey(v.pedname)) do
            Wait(25)
        end
        RequestAnimDict("oddjobs@assassinate@guard")
        while not HasAnimDictLoaded("oddjobs@assassinate@guard") do
            Wait(25)
        end
        ped = CreatePed(4, v.pedname, v.startcoords.x, v.startcoords.y, v.startcoords.z -1.0, v.pedheading, false, false)
        SetEntityHeading(ped, v.pedheading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,"oddjobs@assassinate@guard","unarmed_fold_arms", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        if Config.UseOxTarget then 
                exports.ox_target:addLocalEntity(ped,
            {
                name = 'trash',
                icon = 'fa-solid fa-truck-moving', 
                distance = 2.0,
                onSelect = function()
                    openmenu()
                end,
                label = "Trasher Job",  
            })
        end
    end
end)

function showPictureNotification(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

function DrawTextScreen(text)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.5)
	SetTextColour(128, 128, 128, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.4, 0.0155)
end

function shownotify(msg)
	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end 

AddEventHandler('playerDropped', function ()
    endjob()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if busy then 
            DrawTextScreen(string.format(Translation[Config.Locale]['current_trashcan'], count -1, tostring(#Config.Zones[curr_label])))
        end
    end
end)