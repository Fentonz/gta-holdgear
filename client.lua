local oldHighGear = 0
local car
local oldCar
local wasInCar = false

-- is a car
IsCar = function(veh)
    local vc = GetVehicleClass(veh)
    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or
               (vc >= 17 and vc <= 20)
end

function showText(txt)
    SetTextFont(4)
    SetTextScale(0.9, 0.9)
    SetTextColour(200, 0, 0, 255)

    SetTextEntry('STRING')
    AddTextComponentString(txt)
    DrawText(0.1, 0.1)
end

-- PRESSED SHIFT
-- check if oldHighGear == 0
    -- if yes: set oldHighGear to highest gear of that vehicle
-- get current gear
-- set highest gear as current gear

-- JUST RELEASED SHIFT
-- set highest gear as oldHighGear
-- set oldHighGear to 0

-- CHECK IF oldHighGear ~= 0 AND IF PLAYER IS NOT IN VEHICLE
-- set oldHighGear to 0

Citizen.CreateThread(function()
    Citizen.Wait(500)
    while true do
        local ped = GetPlayerPed(-1) -- get our character
        car = GetVehiclePedIsIn(ped) -- get vehicle

        -- check if JUST exited vehicle
        if car == 0 and oldHighGear ~= 0 then
            SetVehicleHighGear(oldCar, oldHighGear)
            oldHighGear = 0
        end
        
        -- check if is in a car
        if car ~= 0 and IsCar(car) then
            oldCar = car
            wasInCar = true
            -- check if SHIFT pressed
            if IsControlPressed(0, 21) then
                if oldHighGear == 0 then
                    oldHighGear = GetVehicleHighGear(car)
                end

                -- get current gear
                local currentGear = GetVehicleCurrentGear(car)

                -- set that to highest gear
                SetVehicleHighGear(car, currentGear)
            end

            -- check if SHIFT was just released
            if IsControlJustReleased(0, 21) then
                SetVehicleHighGear(car, oldHighGear)
                oldHighGear = 0
            end
        end
        Citizen.Wait(1)
    end

end)