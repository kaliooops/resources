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
vRPclient = Tunnel.getInterface("vRP", "vrp_inventoryhud")
local entity

function playScreenEffect(name, duration)
  if duration < 0 then -- loop
    StartScreenEffect(name, 0, true)
  else
    StartScreenEffect(name, 0, true)
  end
end

RegisterNetEvent("Inventory:ArmourMe")
AddEventHandler("Inventory:ArmourMe", function()
	ExecuteCommand("e adjust")
	SetPedArmour(GetPlayerPed(-1), 100)     --32
	SetPedComponentVariation(PlayerPedId(), 9, 30, 0, 0)
end)

RegisterNetEvent("Inventory:Iarba")
AddEventHandler("Inventory:Iarba", function()
	iarba()
end)

RegisterNetEvent("Inventory:Juice1")
AddEventHandler("Inventory:Juice1", function()
	juice1()
end)

RegisterNetEvent("Inventory:Juice2")
AddEventHandler("Inventory:Juice2", function()
	juice2()
end)

RegisterNetEvent("Inventory:Cola")
AddEventHandler("Inventory:Cola", function()
	juice2()
end)

RegisterNetEvent("Inventory:Medical")
AddEventHandler("Inventory:Medical", function()
	drogmedicinal()
end)

RegisterNetEvent("Inventory:Medicamente")
AddEventHandler("Inventory:Medicamente", function()
	paracetamol()
end)

RegisterNetEvent("Inventory:Tigara")
AddEventHandler("Inventory:Tigara", function()
	cigarettee()
end)

RegisterNetEvent("Inventory:Pizza")
AddEventHandler("Inventory:Pizza", function()
	eat()
end)

RegisterNetEvent("Inventory:Gogoasa")
AddEventHandler("Inventory:Gogoasa", function()
	eat()
end)

function eat()
	playanim("mp_player_inteat@burger", "mp_player_int_eat_burger",48)
	Citizen.Wait(GetAnimDuration("mp_player_inteat@burger", "mp_player_int_eat_burger")*1000)
end
function drink()
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
end
function drinkalcool()
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	playMovement("MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
	playScreenEffect("DrugsTrevorClownsFight", 120)
	Wait(60000)
	resetMovement(false)
	StopScreenEffect("DrugsTrevorClownsFight")
end
function droga()
	playMovement("MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
	playScreenEffect("DMT_flight", 120)   
	Wait(60000)
	resetMovement(false)
	StopScreenEffect("DMT_flight")
end
function drogmedicinal()
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	playScreenEffect("Rampage", 120)
	CreateThread(function()
		for i=1, 120 do 
			Wait(1000)
			if GetEntityHealth(PlayerPedId()) > 120 then
				SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
			end
		end
	end)
	Wait(120000)
	StopScreenEffect("Rampage")

end
function juice1()
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 10)
end

function juice2()
	local player = GetPlayerPed(-1)
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	SetPedArmour(player, GetPedArmour(player) + 10)
end

function cigarettee()
	loadprop("ng_proc_cigarette01a",0,0,0.05)
	playanim("mp_player_int_uppersmoke","mp_player_int_smoke",48)
	Citizen.Wait(GetAnimDuration("mp_player_int_uppersmoke","mp_player_int_smoke")*1000)
	removeAttachedProp()
	Citizen.Wait(100)
	removeAttachedProp()
	Citizen.Wait(300)
	removeAttachedProp()
	SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 15)
end
function iarba()
	if GetEntityHealth(PlayerPedId()) > 120 then
		SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 15)
		loadprop("prop_cigar_03",-0.1,0,0)	
		playanim("mp_player_int_uppersmoke","mp_player_int_smoke",48)
		Citizen.Wait(GetAnimDuration("mp_player_int_uppersmoke","mp_player_int_smoke")*1000)
		removeAttachedProp()
		Citizen.Wait(100)
		removeAttachedProp()
		Citizen.Wait(300)
		removeAttachedProp()
		playMovement("MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false)
		playScreenEffect("DrugsMichaelAliensFight", 120)
		Wait(60000)
		resetMovement(false)
		StopScreenEffect("DrugsMichaelAliensFight")
		removeAttachedProp()
		Citizen.Wait(100)
		removeAttachedProp()
		Citizen.Wait(300)
		removeAttachedProp()
	end

end
function emergencia()
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)

end
function paracetamol()
	playanim("mp_player_intdrink","loop_bottle",48)
	Citizen.Wait(GetAnimDuration("mp_player_intdrink","loop_bottle")*1000)
	SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) + 30)

end

RegisterNetEvent("minge")
AddEventHandler("minge", function()
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BALL"), 15, false)
end)

function stopScreenEffect(name)
  StopScreenEffect(name)
end

function playMovement(clipset,blur,drunk,fade,clear)
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

function resetMovement(fade)
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