local htmlEntities = module("lib/htmlEntities")

local cfg = module("cfg/identity")
local lang = vRP.lang

local sanitizes = module("cfg/sanitizes")

-- cbreturn user identity
function vRP.getUserIdentity(user_id, cbr)
	local task = Task(cbr)

	local rows = exports.ghmattimysql:executeSync("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	data = {firstname = rows[1].firstName, name = rows[1].secondName, age = rows[1].age}
  task({data})
end

-- cbreturn user_id by registration or nil
function vRP.getUserByRegistration(registration, cbr)
  local task = Task(cbr)

  task()
end

-- cbreturn user_id by phone or nil
function vRP.getUserByPhone(phone, cbr)
  local task = Task(cbr)

  task()
end

function vRP.generateStringNumber(format) -- (ex: DDDLLL, D => digit, L => letter)
  local abyte = string.byte("A")
  local zbyte = string.byte("0")

  local number = ""
  for i=1,#format do
    local char = string.sub(format, i,i)
    if char == "D" then number = number..string.char(zbyte+math.random(0,9))
    elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
    else number = number..char end
  end

  return number
end

-- cbreturn a unique registration number
function vRP.generateRegistrationNumber(cbr)
  local task = Task(cbr)

  local function search()
    -- generate registration number
    local registration = vRP.generateStringNumber("DDDLLL")
    vRP.getUserByRegistration(registration, function(user_id)
      if user_id ~= nil then
        search() -- continue generation
      else
        task({registration})
      end
    end)
  end

  search()
end

-- cbreturn a unique phone number (0DDDDD, D => digit)
function vRP.generatePhoneNumber(cbr)
  local task = Task(cbr)

  local function search()
    -- generate phone number
    local phone = vRP.generateStringNumber(cfg.phone_format)
    vRP.getUserByPhone(phone, function(user_id)
      if user_id ~= nil then
        search() -- continue generation
      else
        task({phone})
      end
    end)
  end

  search()
end

-- city hall menu

local cityhall_menu = {name=lang.cityhall.title(),css={top="75px", header_color="rgba(0,125,255,0.75)"}}

function checkName(theText)
	local foundSpace, valid = false, true
	local spaceBefore = false
	local current = ''
	for i = 1, #theText do
		local char = theText:sub( i, i )
		if char == ' ' then 
			if i == #theText or i == 1 or spaceBefore then 
				valid = false
				break
			end
			current = ''
			spaceBefore = true
		elseif ( char >= 'a' and char <= 'z' ) or ( char >= 'A' and char <= 'Z' ) then 
			current = current .. char
			spaceBefore = false
		else 
			valid = false
			break
		end
	end
	
	if (valid == true)  then
		return true
	else
		return false
	end
end

local function ch_identity(player,choice)
  local user_id = vRP.getUserId(player)
  local name1 = ""
  local name2 = ""
  if user_id ~= nil then
    vRP.prompt(player,lang.cityhall.identity.prompt_firstname(),"",function(player,firstname)
      if string.len(firstname) >= 2 and string.len(firstname) < 50 then
		    local name1 = firstname
        firstname = sanitizeString(firstname, sanitizes.name[1], sanitizes.name[2])
        vRP.prompt(player,lang.cityhall.identity.prompt_name(),"",function(player,name)
          if string.len(name) >= 2 and string.len(name) < 50 then
			      local name2 = name
            name = sanitizeString(name, sanitizes.name[1], sanitizes.name[2])
            vRP.prompt(player,lang.cityhall.identity.prompt_age(),"",function(player,age)
              age = parseInt(age)
				      if age >= 16 and age <= 150 then
					      if (checkName(name1)) then
						      if (checkName(name2)) then
                    if vRP.tryPayment(user_id,cfg.new_identity_cost) then
								      exports.ghmattimysql:execute("UPDATE vrp_users SET firstName = @firstname, secondName = @name, age = @age WHERE id = @user_id", {
                        user_id = user_id, 
                        firstname = firstname, 
                        name = name, 
                        age = age
                      }, function()end)
                      TriggerEvent("Achievements:UP_Current_Progress", user_id, "La biroul primariei, se poate creea un buletin.")
								      --if(vRP.tryGetInventoryItem(user_id,"id_doc",1,false))then
								      --	vRP.giveInventoryItem(user_id,"id_doc",1,true)
								      --else
								      --	vRP.giveInventoryItem(user_id,"id_doc",1,true)
								      --end
                      vRPclient.notify(player,{lang.money.paid({cfg.new_identity_cost})})
                      vRP.closeMenu(player)
							      else
								      vRPclient.notify(player,{lang.money.not_enough()})
							      end
						      else
							      vRPclient.notify(player,{lang.common.invalid_value()})
						      end
					      else
						      vRPclient.notify(player,{lang.common.invalid_value()})
					      end
				      else
					      vRPclient.notify(player,{lang.common.invalid_value()})
				      end
            end)
          else
            vRPclient.notify(player,{lang.common.invalid_value()})
          end
        end)
      else
        vRPclient.notify(player,{lang.common.invalid_value()})
      end
    end)
  end
end

cityhall_menu[lang.cityhall.identity.title()] = {ch_identity,lang.cityhall.identity.description({cfg.new_identity_cost})}

local function cityhall_enter()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.openMenu(source,cityhall_menu)
  end
end

local function cityhall_leave()
  vRP.closeMenu(source)
end

local function build_client_cityhall(source) -- build the city hall area/marker/blip
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local x,y,z = table.unpack(cfg.city_hall)

    vRPclient.addBlip(source,{x,y,z,cfg.blip[1],cfg.blip[2],lang.cityhall.title()})
    vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,125,255,125,150})
    vRPclient.addMarkerSign(source,{20,x,y,z-1.35,0.60,0.60,0.60,0,125,255,150,150,1,false,0})
    vRPclient.addMarkerNames(source,{x,y,z+0.520, "~b~Identitate", 1, 1.2})
    vRP.setArea(source,"vRP:cityhall",x,y,z,1,1.5,cityhall_enter,cityhall_leave)
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_cityhall(source)
  end
end)
