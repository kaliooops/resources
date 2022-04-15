
RegisterNetEvent("winter_misiuni:get_new_mision")
AddEventHandler("winter_misiuni:get_new_mision", function(mission)
    TriggerEvent("winter_mision_handler:set_mission", mission)
end)

RegisterNetEvent("winter_misiuni:finish_mission")
AddEventHandler("winter_misiuni:finish_mission", function(mission)
    
end)


RegisterNetEvent("winter_misiuni_handler:ArtificiiAprinse")
AddEventHandler("winter_misiuni_handler:ArtificiiAprinse", function()

	print("ai aprins" .. Artificii_Aprinse)
	Artificii_Aprinse = Artificii_Aprinse + 1 --gotta love global scope

end)

RegisterNetEvent("winter_misiuni_handler:RentCondus")
AddEventHandler("winter_misiuni_handler:RentCondus", function()

	plimbare_masina_rent = plimbare_masina_rent + 1

end)

RegisterNetEvent("winter_misiuni_handler:obtine_bani")
AddEventHandler("winter_misiuni_handler:obtine_bani", function(amount)

	bani_obtinuti = bani_obtinuti + (amount)

end)