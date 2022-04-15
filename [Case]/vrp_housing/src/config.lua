Config = {
  
    --Licenta
    license = "EvFqPgUMrEeMGgCUgYtrQbbbPClrjFKkMGgCUgYvFq",
    ip = "188.25.155.112",
  
    AllowHouseSales = false,               -- can players sell their house after purchase?
    SpawnOffset = vector3(0.0,0.0,0.0),   -- global house spawn offset (location + SpawnOffset) (use negative z-value to lower the shells position)
                                          -- note: if you already have houses spawned, I wouldn't go changing this. Will result in furniture dissappearing.
                                          
    UsingVSync = false,    -- Really only applies if you're using the modified vSync provided, else set false.
  
    -- MENUS
    UsingNativeUI     = true,
  
    -- BLIPS/MARKERS/3DTEXT
    UseHelpText       = false,  -- if using HelpText (instead of 3DText).
    Use3DText         = true,   -- if using 3DText (instead of HelpText).
    UseMarkers        = false,  -- if you want markers.
    UseBlips          = true,   -- if you want blips.
  
    -- RENDER DISTANCE
    MarkerDistance    = 10.0,
    TextDistance3D    = 10.0,
    HelpTextDistance  = 2.0,
    InteractDistance  = 2.0,
  
    -- BLIP COLORS/SPRITES
    UseZoneSprites    = true,  -- if you want to set the blip sprite by zone.
    UseZoneColoring   = true,  -- if you want to set the blip color by zone.
  
    BlipEmptyColor      = 1,     -- must be set regardless of option above.
    BlipOwnerColor      = 2,     -- must be set regardless of option above.
    BlipOwnedColor      = 5,     -- must be set regardless of option above.
    ZoneBlipColors      = {      -- set house blip colors based on zone. Optional.
      [9] = {
        EmptyColor  = 0,
        OwnerColor  = 0,
        OwnedColor  = 0,
      }, 
      [205] = {      
        EmptyColor  = 0,
        OwnerColor  = 0,
        OwnedColor  = 0,
      }
    },
  
    BlipEmptySprite   = 375,    -- must be set regardless of option above.
    BlipOwnerSprite   = 492,     -- must be set regardless of option above.
    BlipOwnedSprite   = 492,    -- must be set regardless of option above.
    ZoneBlipSprites   = {       -- set house blip colors sprites on zone. Optional.
      [9] = {
        EmptySprite  = 350,
        OwnerSprite  = 40,
        OwnedSprite  = 40,
      }, 
      [205] = {
        EmptySprite  = 350,
        OwnerSprite  = 40,
        OwnedSprite  = 40,
      }
    },
  
    HideOwnBlips    = false,    -- hide blips for players owned houses?
    HideSoldBlips   = false,    -- hide blips for other player houses?
    HideEmptyBlips  = false,    -- hide blips for empty houses/for sale houses?
  
    -- OWNER STUFF
    RemoveFurniture  = true,  -- Remove all furniture on sale.
    RefundFurniture  = true,  -- Only if RemoveFurniture enabled.
    RefundPercent    = 50,    -- percent of price to refund for furniture.
  
    --InventoryRaiding
    InventoryRaiding = true,
  }