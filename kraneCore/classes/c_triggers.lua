kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")

RegisterNetEvent("KRANE_CLASSES:Load")
AddEventHandler("KRANE_CLASSES:Load", function(modelhash)
    kraneUtility.Force_Model_Load(modelhash)
end)