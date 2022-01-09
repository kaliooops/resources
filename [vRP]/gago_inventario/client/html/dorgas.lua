--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

--xpk_inventario

vRPd = {}

Tunnel.bindInterface("gago_inventario",vRPd)
Proxy.addInterface("gago_inventario",vRPd)

local entity


function vRPd.playScreenEffect(name, duration)
  if duration < 0 then -- loop
    StartScreenEffect(name, 0, true)
  else
    StartScreenEffect(name, 0, true)
  end
end

function vRPd.eat()
	loadprop("prop_cs_burger_01",0,0,0)
	playanim("mp_player_inteat@burger", "mp_player_int_eat_burger",48)
	Citizen.Wait(GetAnimDuration("mp_player_inteat@burger", "mp_player_int_eat_burger")*1000)
	removeAttachedProp()
end
function vRPd.drink()
	loadprop("prop_ld_flow_bottle",0,0,0)
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	removeAttachedProp()
end
function vRPd.drinkalcool()
	loadprop("prop_tequila_bottle",0,0,-0.2)
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	removeAttachedProp()
	vRPd.playMovement("MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
	vRPd.playScreenEffect("DrugsTrevorClownsFight", 120)
	Wait(60000)
	vRPd.resetMovement(false)
	StopScreenEffect("DrugsTrevorClownsFight")
end
function vRPd.droga()
	vRPd.playMovement("MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
	vRPd.playScreenEffect("DMT_flight", 120)   
	Wait(60000)
	vRPd.resetMovement(false)
	StopScreenEffect("DMT_flight")
end
function vRPd.iarba()
	loadprop("prop_cigar_03",-0.1,0,0)
	playanim("mp_player_int_uppersmoke","mp_player_int_smoke",48)
	Citizen.Wait(GetAnimDuration("mp_player_int_uppersmoke","mp_player_int_smoke")*1000)
	removeAttachedProp()
	vRPd.playMovement("MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
	vRPd.playScreenEffect("DMT_flight", 120)   
	Wait(0)
	vRPd.resetMovement(false)
	StopScreenEffect("DMT_flight")
	removeAttachedProp()
end
function vRPd.cigarettee()
	loadprop("ng_proc_cigarette01a",0,0,0.05)
	playanim("mp_player_int_uppersmoke","mp_player_int_smoke",48)
	Citizen.Wait(GetAnimDuration("mp_player_int_uppersmoke","mp_player_int_smoke")*1000)
	removeAttachedProp()

end
function vRPd.iarba()
	loadprop("ng_proc_cigarette01a",0,0,0.05)
	playanim("mp_player_int_uppersmoke","mp_player_int_smoke",48)
	Citizen.Wait(GetAnimDuration("mp_player_int_uppersmoke","mp_player_int_smoke")*1000)
	removeAttachedProp()

end
function vRPd.emergencia()
	loadprop("prop_weed_bottle",0,0,0.05)
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	removeAttachedProp()

end
function vRPd.paracetamol()
	loadprop("prop_weed_bottle",0,0,0.05)
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	removeAttachedProp()

end

function vRPd.stopScreenEffect(name)
  StopScreenEffect(name)
end

function vRPd.playMovement(clipset,blur,drunk,fade,clear)
  RequestAnimSet(clipset)
  while not HasAnimSetLoaded(clipset) do
    Citizen.Wait(0)
  end
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
  end
  if clear then
    ClearPedTasksImmediately(PlayerPedId())
  end
  SetTimecycleModifier("spectator5")
  if blur then 
    SetPedMotionBlur(PlayerPedId(), true) 
  end
  SetPedMovementClipset(PlayerPedId(), clipset, true)
  if drunk then
    SetPedIsDrunk(PlayerPedId(), true)
  end
  if fade then
    DoScreenFadeIn(1000)
  end
  
end

function vRPd.resetMovement(fade)
  -- fade
  if fade then
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
  end

  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(PlayerPedId(), 0)
  SetPedIsDrunk(PlayerPedId(), false)
  SetPedMotionBlur(PlayerPedId(), false)
end

function loadprop(prop,x,y,z)
	local attachModel = GetHashKey(prop)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(0)
	end
	SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263)
	local bone = GetPedBoneIndex(GetPlayerPed(-1), 60309)
	entity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(entity, GetPlayerPed(-1), bone, x, y, z, 0, 0, 0, true, true, false, true, 1, true)
end
function playanim(dict,anim,loop)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
	TaskPlayAnim(GetPlayerPed(-1),dict,anim,5.0, 1.0, 1.0, loop, 0.0, 0, 0, 0)					
end
function removeAttachedProp()
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
    end
end
