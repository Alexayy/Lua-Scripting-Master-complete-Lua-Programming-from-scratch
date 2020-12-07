---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by acakic.
--- DateTime: 7.12.20. 06:48
---
---

math.randomseed(os.time())

-- Declaring player and enemy positions as tables
local player = {x = 400, y = 300}

local enemy = {x = 0, y = 0}

local user_option = 0

function display_menu()
    -- display a menu on the console
    print("|------------------------------------------------|")
    print("| WELCOME, "..os.date())
    print("|------------------------------------------------|")
    print("| 1. Generate random enemy position.")
    print("| 2. Distance from enemy to player.")
    print("| 3. Get angle from enemy to player.")
    print("| 4. Exit.")
    print("|------------------------------------------------|")

end

function get_distance(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function get_degrees(x1, y1, x2, y2)
    local a = math.atan( (y1 - y2), (x1 - x2) )
    return math.deg(a)
end
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --- -- ---
while user_option ~= 4 do

    display_menu()

    -- read user input
    print("Please enter your option: ")
    user_option = io.read("*n")

    if user_option == 1 then
        enemy.x = math.random(0, 800)
        enemy.y = math.random(0, 600)

        print("         | - - - - New enemy position: " ..enemy.x.. ", " ..enemy.y.. ")")
    end

    if user_option == 2 then
        local distance = get_distance(player.x, player.y, enemy.x, enemy.y)
        print("Distance from enemy: " .. distance)
    end

    if user_option == 3 then
        print("The angle between enemy and the player is: " .. get_degrees(player.x, enemy.x, player.y, enemy.y))
    end
end