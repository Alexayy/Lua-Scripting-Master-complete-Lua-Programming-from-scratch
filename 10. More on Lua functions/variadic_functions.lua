---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by acakic.
--- DateTime: 8.12.20. 12:55
---

function find_max(...)
    local n = 0
    local arguments = {...}
    local max = arguments[1]

    for i, num in ipairs(arguments) do

        if num > max then
            max = num
        end

        n = n + 1
    end

    return n, max
end

------------------------------------------------
--- Ask for the max value of a list of integers
------------------------------------------------
--local n, max = find_max(2, 3, 4, 6, -5, -23, -4, 9)
local n, max = find_max(5, 7, 4, 3, 3)

print("The maximum out of " ..n.. " values was " ..max)