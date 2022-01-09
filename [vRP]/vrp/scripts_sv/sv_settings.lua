local defaultBG = "https://i.imgur.com/BY8TVOY.png" -- Aici pui linku default
local defaultColor = "255,0,0"

RegisterServerEvent("saveMenuPos")
AddEventHandler("saveMenuPos",function(menuTopBottom,menuLeftRight)
    local user_id = vRP.getUserId(source)
    exports.ghmattimysql:execute("UPDATE vrp_users SET menuTopBottom=@menuTopBottom,menuLeftRight=@menuLeftRight WHERE id = @id",{['id'] = user_id, ['menuTopBottom'] = menuTopBottom, ['menuLeftRight'] = menuLeftRight}, function() end)
end)

function tvRP.setPhoneColor(user_id,color)
    local usrs = vRP.getUserSource(user_id)
    colorz = tostring(color)
    exports.ghmattimysql:execute("UPDATE vrp_users SET BgColor = @BgColor WHERE id = @id",{["@id"] = user_id,["@BgColor"] = colorz}, function(data) end)
    vRPclient.setMenuColor(usrs,{colorz})
end
  
function tvRP.setPhoneBg(user_id,background)
    local usrs = vRP.getUserSource(user_id)
    bg = tostring(background)
    exports.ghmattimysql:execute("UPDATE vrp_users SET phoneBg = @phoneBg WHERE id = @id",{["@id"] = user_id,["@phoneBg"] = bg}, function(data) end)
    vRPclient.setBGImage(usrs,{bg})
end

local function ch_changeBg(player,choice)
    local user_id = vRP.getUserId(player)
    vRP.prompt(player,"Seteaza imaginea telefonului:","RESET pentru a reseta",function(player,raspuns)
        local raspuns = tostring(raspuns)
        if raspuns ~= nil and raspuns ~= "" then
            tvRP.setPhoneBg(user_id,raspuns)
            vRPclient.notify(player,{"[TELEFON]\nAi schimbat background-ul cu "..raspuns})
        elseif raspuns == "RESET" or raspuns == "reset" or raspuns == "Reset" then
            tvRP.setPhoneBg(user_id,defaultBG)
            vRPclient.notify(player,{"[TELEFON]\nTi-ai resetat poza telefonului."})
        else
            vRPclient.notify(player,{"~r~Ai anulat schimbarea de background!"})
        end
    end)
end

local function ch_changeColor(player,choice)
    local user_id = vRP.getUserId(player)
    vRP.prompt(player,"Seteaza culoarea telefonului","RESET pentru a reseta (Culoarea trebuie sa fie tip RGB)",function(player,theColor)
        local theColor = tostring(theColor)
        if ( theColor ~= nil and theColor:len() >= 5 and theColor:len() <= 12 ) then
            if ( theColor ~= "RESET" ) then
                tvRP.setPhoneColor(user_id,theColor)
                vRPclient.notify(player,{"[TELEFON]\nAi schimbat culoarea telefonului cu: "..theColor})
            else
                vRPclient.notify(player,{"[TELEFON]\nAi resetat culoarea telefonului!"})
                tvRP.setPhoneColor(user_id,defaultColor)
            end
        else
            vRPclient.notify(player,{"~r~Ai anulat schimbarea culorii!"})
        end
    end)
end

local function ch_changePos(player,choice)
    local user_id = vRP.getUserId(player)
    vRPclient.setPosition(player,{1})
end

-- vRP.registerMenuBuilder("main", function(add, data)
-- 	local user_id = vRP.getUserId(data.player)
-- 	if user_id ~= nil then
-- 		local choices = {}
-- 		local stat = {}
-- 		choices["Setari telefon"] = {function(player,choice)
-- 			vRP.buildMenu("Setari telefon", {player = player}, function(menu)
-- 				menu.name = "Setari telefon"
-- 				menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
-- 				menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu

--         		menu["Seteaza Fundal"] = {ch_changeBg}
--         		menu["Pozitie Telefon"] = {ch_changePos}
--                 menu["Schimba culoare Tematica"] = {ch_changeColor}
				
--                 vRP.openMenu(player,menu)
-- 			end)
-- 		end, "Setari telefon"}
-- 		add(choices)
-- 	end
-- end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	Debug.pbegin("playerSpawned_player_state")
	if first_spawn then
		exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id",{["user_id"] = user_id}, function(rows)
			if #rows > 0 then
    			local theColor = tostring(rows[1].BgColor)
    			local background = tostring(rows[1].phoneBg)
    			local menuTopBottom = rows[1].menuTopBottom
    			local menuLeftRight = rows[1].menuLeftRight	
    			vRPclient.setBGImage(source,{background})
    			vRPclient.setMenuColor(source,{theColor})
    			vRPclient.setPhonePos(source,{menuTopBottom,menuLeftRight})
			end
		end)
	end
	Debug.pend()
end)