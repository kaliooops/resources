DisableVehicleDistantlights(true)
SetPedPopulationBudget(0)
SetVehiclePopulationBudget(0)
SetRandomEventFlag(false)
local scenarios = {
    'WORLD_VEHICLE_ATTRACTOR',
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_BICYCLE_BMX',
    'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
    'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
    'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
    'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
    'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
    'WORLD_VEHICLE_BICYCLE_ROAD',
    'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
    'WORLD_VEHICLE_BIKER',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BROKEN_DOWN',
    'WORLD_VEHICLE_BUSINESSMEN',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
    'WORLD_VEHICLE_CONSTRUCTION_SOLO',
    'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
    'WORLD_VEHICLE_DRIVE_SOLO',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_EMPTY',
    'WORLD_VEHICLE_MARIACHI',
    'WORLD_VEHICLE_MECHANIC',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_PARK_PARALLEL',
    'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
    'WORLD_VEHICLE_PASSENGER_EXIT',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_QUARRY',
    'WORLD_VEHICLE_SALTON',
    'WORLD_VEHICLE_SALTON_DIRT_BIKE',
    'WORLD_VEHICLE_SECURITY_CAR',
    'WORLD_VEHICLE_STREETRACE',
    'WORLD_VEHICLE_TOURBUS',
    'WORLD_VEHICLE_TOURIST',
    'WORLD_VEHICLE_TANDL',
    'WORLD_VEHICLE_TRACTOR',
    'WORLD_VEHICLE_TRACTOR_BEACH',
    'WORLD_VEHICLE_TRUCK_LOGS',
    'WORLD_VEHICLE_TRUCKS_TRAILERS',
    'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
}
for i, v in pairs(scenarios) do
    SetScenarioTypeEnabled(v, false)
end


SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
SetRandomBoats(false) -- Stop random boats from spawning in the water.
SetCreateRandomCops(false) -- disable random cops walking/driving around.
SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
SetPedPopulationBudget(0)    