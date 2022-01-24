
-- pause
AddEventHandler("vRP:pauseChange", function(paused)
  SendNUIMessage({act="pause_change", paused=paused})
end)

-- MENU

function tvRP.openMenuData(menudata)
  SendNUIMessage({act="open_menu", menudata = menudata})
end

function tvRP.closeMenu()
  SendNUIMessage({act="close_menu"})
end

-- PROMPT

function tvRP.prompt(title,default_text)
  SendNUIMessage({act="prompt",title=title,text=tostring(default_text)})
  SetNuiFocus(true)
end


-- muie dgvanix na ca l-am facut si eu ba panarama
function tvRP.setBGImage(background)
  SendNUIMessage({act="setbg",image_url=background})
end

function tvRP.setMenuColor(colors)
    SendNUIMessage({act="menucolor", color=colors})
end

function tvRP.setPhonePos(posX,posY)
        SendNUIMessage({act="setMenuPos",pos={descPos={0,0},menuPos={posX,posY}} })
end
-- REQUEST

function tvRP.request(id,text,time)
  SendNUIMessage({act="request",id=id,text=tostring(text),time = time})
  tvRP.playSound("HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING")
end

-- gui menu events
RegisterNUICallback("menu",function(data,cb)
  if data.act == "close" then
    vRPserver.closeMenu({data.id})
  elseif data.act == "valid" then
    vRPserver.validMenuChoice({data.id,data.choice,data.mod})
  end
end)

RegisterNUICallback("saveMenuPos",function(data,cb)
  -- saveMenuPos
  cb('ok')
  print(data.menuPos[1],data.menuPos[2])
  TriggerServerEvent("saveMenuPos",data.menuPos[1],data.menuPos[2])
end)

-- gui prompt event
RegisterNUICallback("prompt",function(data,cb)
  if data.act == "close" then
    SetNuiFocus(false)
    SetNuiFocus(false)
    vRPserver.promptResult({data.result})
  end
end)

-- gui request event
RegisterNUICallback("request",function(data,cb)
  if data.act == "response" then
    vRPserver.requestResult({data.id,data.ok})
  end
end)

-- ANNOUNCE

-- add an announce to the queue
-- background: image url (800x150)
-- content: announce html content
function tvRP.announce(background,content,contact,time)
  SendNUIMessage({act="announce",background=background,content=content,contact=contact,time=time})
end

-- cfg
RegisterNUICallback("cfg",function(data,cb) -- if NUI loaded after
  SendNUIMessage({act="cfg",cfg=cfg.gui})
end)
SendNUIMessage({act="cfg",cfg=cfg.gui}) -- if NUI loaded before

-- try to fix missing cfg issue (cf: https://github.com/ImagicTheCat/vRP/issues/89)
for i=1,5 do
  SetTimeout(5000*i, function() SendNUIMessage({act="cfg",cfg=cfg.gui}) end)
end

-- PROGRESS BAR

-- create/update a progress bar
function tvRP.setProgressBar(name,anchor,text,r,g,b,value)
  local pbar = {name=name,anchor=anchor,text=text,r=r,g=g,b=b,value=value}

  -- default values
  if pbar.value == nil then pbar.value = 0 end

  SendNUIMessage({act="set_pbar",pbar = pbar})
end

-- set progress bar value in percent
function tvRP.setProgressBarValue(name,value)
  SendNUIMessage({act="set_pbar_val", name = name, value = value})
end

-- set progress bar text
function tvRP.setProgressBarText(name,text)
  SendNUIMessage({act="set_pbar_text", name = name, text = text})
end

-- remove a progress bar
function tvRP.removeProgressBar(name)
  SendNUIMessage({act="remove_pbar", name = name})
end

-- DIV

-- set a div
-- css: plain global css, the div class is "div_name"
-- content: html content of the div
function tvRP.setDiv(name,css,content)
  SendNUIMessage({act="set_div", name = name, css = css, content = content})
end

-- set the div css
function tvRP.setDivCss(name,css)
  SendNUIMessage({act="set_div_css", name = name, css = css})
end

-- set the div content
function tvRP.setDivContent(name,content)
  SendNUIMessage({act="set_div_content", name = name, content = content})
end

function tvRP.setDivColor(name,theColors)
	SendNUIMessage({act="set_div_color",name = name,color = theColors})
end


-- execute js for the div
-- js variables: this is the div
function tvRP.divExecuteJS(name,js)
  SendNUIMessage({act="div_execjs", name = name, js = js})
end

-- remove the div
function tvRP.removeDiv(name)
  SendNUIMessage({act="remove_div", name = name})
end

-- CONTROLS/GUI
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)
        ped = PlayerPedId()
        local health = GetEntityHealth(GetPlayerPed(-1))
        SendNUIMessage({
            show = IsPauseMenuActive(),
            health = GetEntityHealth(ped)-100,
            armor = GetPedArmour(ped),
        })
    end
end)
local paused = false

function tvRP.isPaused()
  return paused
end
isChangingPos = false

menuLeftRight = 0
menuTopBottom = 0
--descMenuLeftRight = 0
--descMenuTopBottom = 0
function tvRP.setPosition(type)
    if type == 1 then
        isChangingPos = true
        --tvRP.notify("~y~[TELEFON] ~g~Ai inceput sa muti pozitia telefonului")
        --tvRP.notify("~w~[CONTROLS] ~r~[ARROW UP] ~g~| ~r~[ARROW DWN] ~g~| ~r~[ARROW LEFT] ~g~| ~r~[ARROW RIGHT] ~w~| ~r~[BACKSPACE]")
        TriggerEvent("chatMessage","Ajusteaza pozitia ^1Telefonului^0!")
        TriggerEvent("chatMessage","^3[INFO] ^0--> ^1Sageata Sus: ^0Ridica pozitia telefonului")
        TriggerEvent("chatMessage","^3[INFO] ^0--> ^1Sageata Jos: ^0Coboara pozitia telefonului")
        TriggerEvent("chatMessage","^3[INFO] ^0--> ^1Sageata Dreapta: ^0Muta in dreapta pozitia telefonului")
        TriggerEvent("chatMessage","^3[INFO] ^0--> ^1Sageata Stanga: ^0Muta in stanga pozitia telefonului")
        TriggerEvent("chatMessage","^3[INFO] ^0--> ^1Backspace: ^0Salveaza pozitia telefonului / anuleaza mutarea.")
        -- -- Citizen.CreateThread(function()
        -- --     while true do
        -- --         Wait(0)
        -- --         if IsControlPressed(0,174) then
        -- --             menuLeftRight = menuLeftRight - 1
        -- --             SendNUIMessage({act="event",event="RPLeft",menu=1})
        -- --             Wait(250)
        -- --         elseif IsControlPressed(0,175) then
        -- --             menuLeftRight = menuLeftRight + 1
        -- --             SendNUIMessage({act="event",event="RPRight",menu=1})
        -- --             Wait(250)
        -- --         elseif IsControlPressed(0,173) then -- down
        -- --             menuTopBottom = menuTopBottom + 1
        -- --             SendNUIMessage({act="event",event="RPDown",menu=1})
        -- --             Wait(250)
        -- --         elseif IsControlPressed(0,172) then -- up
        -- --             menuTopBottom = menuTopBottom - 1
        -- --             SendNUIMessage({act="event",event="RPUp",menu=1})
        -- --             Wait(250)
        -- --         elseif IsControlJustPressed(0,177) and isChangingPos then
        -- --             --TriggerServerEvent("saveMenuPos",menuTopBottom,menuLeftRight)
        -- --   SendNUIMessage({act="saveMenuPos"})
        -- --             tvRP.notify("~y~[TELEFON] ~g~Pozitia telefonului a fost salvata!")
        -- --             print(menuTopBottom,menuLeftRight)
        -- --             isChangingPos = false
        -- --             break
        -- --         end

        -- --     end
        -- end)
    --elseif type == 2 then
    --  tvRP.notify("~y~[TELEFON] ~g~Ai inceput sa muti pozitia descrierii de la telefon.")
    --  tvRP.notify("~w~[CONTROLS] ~r~[ARROW UP] ~g~| ~r~[ARROW DWN] ~g~| ~r~[ARROW LEFT] ~g~| ~r~[ARROW RIGHT] ~w~| ~r~[BACKSPACE]")
    --  Citizen.CreateThread(function()
    --      while true do
    --          Wait(0)
--
    --          if IsControlJustPressed(0,174) then
    --              SendNUIMessage({act="event",event="MenuLeft",menu=0})
    --              Citizen.Wait(100)
    --          elseif IsControlJustPressed(0,175) then
    --              SendNUIMessage({act="event",event="MenuRight",menu=0})
    --              Citizen.Wait(100)
    --          elseif IsControlJustPressed(0,173) then -- down
    --              SendNUIMessage({act="event",event="MenuDown",menu=0})
    --              Citizen.Wait(100)
    --          elseif IsControlJustPressed(0,172) then -- up
    --              SendNUIMessage({act="event",event="MenuUp",menu=0})
    --              Citizen.Wait(100)
    --          elseif IsControlJustPressed(0,177) and isChangingPos then
    --              tvRP.notify("~y~[TELEFON] ~r~Ai anulat schimbarea pozitiei!")
    --              isChangingPos = false
    --              break
    --          end
--
    --      end
    --  end)
    end


end


-- gui controls (from cellphone)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    -- menu controls
    if IsControlJustPressed(table.unpack(cfg.controls.phone.open)) and (not tvRP.isInComa() or not cfg.coma_disable_menu) and (not tvRP.isHandcuffed() or not cfg.handcuff_disable_menu) and GetLastInputMethod(0) then vRPserver.openMainMenu({}) end
      if not isChangingPos then
        if IsControlPressed(table.unpack(cfg.controls.phone.up)) then
          SendNUIMessage({act="event",event="UP"})
          Citizen.Wait(150)
        end
          if IsControlPressed(table.unpack(cfg.controls.phone.down)) then
          SendNUIMessage({act="event",event="DOWN"})
          Citizen.Wait(150)
        end
        if IsControlJustPressed(table.unpack(cfg.controls.phone.left)) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="LEFT"}) end
        if IsControlJustPressed(table.unpack(cfg.controls.phone.right)) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="RIGHT"}) end
        if IsControlJustPressed(table.unpack(cfg.controls.phone.select)) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="SELECT"}) end
        if IsControlJustPressed(table.unpack(cfg.controls.phone.cancel)) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="CANCEL"}) end
    
        -- open general menu
    
        -- F5,F6 (default: control michael, control franklin)
        if IsControlJustPressed(table.unpack(cfg.controls.request.yes)) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="F5"}) end
        if IsControlJustPressed(table.unpack(cfg.controls.request.no)) and GetLastInputMethod(0) then SendNUIMessage({act="event",event="F6"}) end
    
        -- pause events
        local pause_menu = IsPauseMenuActive()
        --if pause_menu and not paused then
        --  paused = true
        --  TriggerEvent("vRP:pauseChange", paused)
        --elseif not pause_menu and paused then
        --  paused = false
        --  TriggerEvent("vRP:pauseChange", paused)
        --end
    end
  end
end)

