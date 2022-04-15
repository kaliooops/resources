# ezFiveM

---

#### Designed To Improve Development Speed


---
The `kranePED` class - peak
```lua
--import
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")

--new ped
KRANE = kranePed:new()
KRANE:Create_Me(x, y, z, heading, model)
KRANE:Set_Name_And_Responsability("Name", "Occupation")
KRANE:Play_Animation(anim_dictionary, anim_name, loop=optional, sync=optional)

```

With just this 4-5 lines of code, you created this:
![img](https://i.imgur.com/88zIIfj.png)

Usually it takes 20-40 lines of code, but this handles performance and from how far it should display, updating only when needed and handles animations and looping perfectly

You can see how by viewing the `classes/c_kranePED.lua`

```lua
    KRANE:Listen_Interactions(function()
        KRANE:Set_Friendly(PlayerPedId())
        KRANE:Bro_Hug()
        Wait(3000)
        KRANE:Trade(function()
            TriggerServerEvent("bro:GiveSomeWeed")
        end)
        Wait(5000)
        KRANE:Idle(KRANE.idle_animation)
    end)

    KRANE:Give_Weapon("WEAPON_PISTOL")
    KRANE:Speak("nice car")
```

This is just another easy way of interacting with the Peds.

`Listen_Interactions` will wait continously for a key press and then callback your function so you can do whatever you want. In the example we just hug and then he gives me some weed, then reverts back to the idling state


```lua
> KRANE:Move_To(x,y,z)
> KRANE:Simulate_Talk({text,text,text})
> KRANE:Drive_To_Coords(x,y,z)
> KRANE:Enter_Car(veh=optional, seat=optional)
```
This functions are very simple to use, it puts a huge layer of exceptions here, in the docs you need to put some numbers, or choose between some numbers(options) which doesnt really matter to you.

---

The Actual Documentation

---

### The Class kranePED

```lua
> KRANE = c_kranePED.new() = initiate a new object

> KRANE:Update_Position()
--[[ 
    will update KRANE.x, KRANE.y, KRANE.z 
    so you don't need to table.unpack each time 
]]

> KRANE:Create_Me(x,y,z, heading, model, isNet=optional) 
--[[
    if isNet is not provided it will asume is local
    will force model to load
    and set personality to Gangster automatically
    gangster = fight decent, drive aggresively
    assign self.ped to be the newly created ped
]]

> KRANE:Set_Name_And_Responsability(name, responsability)
--[[
    Used for the 3D text drawings
    also assigns self.name and self.responsability
]]

> KRANE:Can_Interact()
--[[
    will check if in 1.5m of PED
    if so, when E is pressed
    it will execute callback
]]  

> KRANE:Freeze()

> KRANE:Unfreeze()

> KRANE:Ignore_World()
--[[
    Will not care about ingame events
    eg: pointing gun at entity, hitting
]]

> KRANE:Invincible()

> KRANE:Idle(animation) 
--[[
    Will execute world_human_animations as
    TaskStartScenarionInPlace
    basically a bad and simple animation
]]

> KRANE:Generic_NPC(animation)
--[[
    Will do nothing, it will be
    FROZEN, INVINCIBLE, IGNORING WORLD AND IDLE
]]

> KRANE:Set_Personality(trait)
--[[
    1. scared = bad fighter, coward
    2. gangster = good fighter, aggressiv
    3. bombardier = suicidal, doesnt care about life
]]

> KRANE:Set_Driving_Style(trait)
--[[
    1. normal = normal driving, faster and overtakes
    2. reckless = reckless driving, full speed
]]

> KRANE:Enter_Car(veh=optional, should_drive=optional)
--[[
    if not veh then veh = random_close_veh using c_kraneUtility.lua
    if not should_drive then should_drive = true
    if should_drive == false then take any empty seat
]]

> KRANE:Drive_To_Coords(x,y,z)
--[[
    Abastracting a lot, setting drive style automatically 
    if it doesnt exist, at the destination it will leave vehicle
    (he must leave because otherways he will keep driving around like a moron)
]]

> KRANE:Listen_Interactions(callback)
--[[
    Will wait each second, if you get in range and self:Can_Interact
    and if E is pressed, it will callback()
]]

> KRANE:Simulate_Talk({text, text, text})
--[[
    It will use the 3D Text Display to put text above the PED
    NAME: text 
    it looks and feels like he explains something
    it's very good looking and easy to use
]]

> KRANE:Move_To(x,y,z)
--[[
    a lot of abstractions, basically ped just walks to the coords
    TODO self:Run_To(x,y,z)
]]

> KRANE:Speak(text)
--[[
    Will use the ACTUAL  voices from the game to say stuff
    1. meet = will say "hi" in their native language
    something like "wassup my man" 
    2. nice car
]]

> KRANE:Set_Friendly(ped) 
--[[
    will use groups to set relationships
    3 neutral - will attack if provoked
    5 angry - will attack always
    1 respect - will never attack
]]
> KRANE:Set_Enemy(ped)  --same like friendly
> KRANE:Set_Neutral(ped) -- same like friednly

> KRANE:Update_Enemy_List({ped, ped, ped})
--[[
    Will be used for KRANE:Fight() to fight someone at random
    from its enemy group
    self.enemy_list = {ped, ped, ped}
]]

> KRANE:Fight()
--[[
    Will fight someone at random from its enemy group
    if it has no enemy group, it will do nothing
]]

> KRANE:Give_Weapon(weapon)
--[[
    It will give a weapon and force to hold
    in case there is no danger it will it till backpack it
    in case of danger it will use the weapon givem
]]

> KRANE:Aggresive_Response()
--[[
    if the ped is Aimed at, it will fire his weapon and mark the target as enemy
]]

> KRANE:Play_Animation(animdict, animname) 
--[[
    Complex animation play
    can be used with the anims from dpemotes
]]

> KRANE:Bro_Hug() -- animation
> KRANE:Trade(callback) -- animation with callback

> KRANE:Internal_Cycle(cb, timeout) 
--[[
    Will run an object-based cycle
    every timeout miliseconds
]]

> KRANE:Got_Damaged()
--[[
    Needs to be called every tick
    It will check if the ped got damaged
    doesn't matter the tick rate just it needs to update AT LEAST once
    for it to detect in future
]]


```



---

### The Class kraneObject

```lua

> KRANE.new()
--[[
    instanciate a new object
]]

> KRANE:Create_Me(x,y,z, heading, model, isNet)
--[[
    Same as Ped
]]
 
> KRANE:Freeze()

> KRANE:Unfreeze()

> KRANE:Invincible()

> KRANE:Uninvincible()

> KRANE:Generic_Object()
--[[
    Inanimate, frozen object
]]

> KRANE:Is_Aiming_Me()
--[[
    if my ped aimed at the entity
]]

> KRANE:Is_Shot()
--[[
    if my ped is pointing the gun and is shooting will return true
]]

> KRANE:Got_Damaged()
--[[
    Same as Ped
]]

> KRANE:Get_Health()

> KRANE:Internal_Cycle(cb, timeout)
--[[
    same as ped
]]
> KRANE:Swap_Model(model)
--[[
    it will store evrything about the object
    it will destroy it
    and create a new one with the model given with the data from the old one: position size heading etc
]]
```