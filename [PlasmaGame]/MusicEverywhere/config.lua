Config = {}

Config.DistanceToVolume = 100.0 -- The distance that will be with the volume at 1.0, so if the volume is 0.5 the distance will be 15.0, if the volume is 0.2 the distance will be 6.

Config.PlayToEveryone = true -- The music in car will be played to everyone? Or just for the people that are in that vehicle? If false the DistanceToVolume will not do anything

Config.ItemInVehicle = false -- Put here, if you want the radio to be an item, inside "", like "radio". With or false you will need to do /carradio

Config.CommandVehicle = "som" -- Only will work if Config.ItemInVehicle == false

Config.Permissao = "Admin"

Config.Zones = {
	{
		name = "Mechanic Zone", -- The name of the radio, it doesn't matter
		coords = vector3(-1151.34, -2010.42, 13.19), -- the position where the music is played
		range = 30.0, -- the range that music can be heard
		volume = 0.1, --default volume? min 0.00, max 1.00
		deflink = "https://www.youtube.com/watch?v=n4pr7j-kTO0",-- the default link, if nill it won't play nothing
		isplaying = true, -- will the music play when the server start?
		loop = true,-- when does the music stop it will repaeat?
		deftime = 0, -- where does the music starts? 0 and it will start in the beginning
		changemusicblip = vector3(-1141.75, -2010.79, 13.19) -- where the player can change the music
	}
}