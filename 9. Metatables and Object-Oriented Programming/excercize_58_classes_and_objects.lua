---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by acakic.
--- DateTime: 8.12.20. 12:34
---

-- Instancing the object
Fighter = {
    name = "",
    coutry_of_origin = "",
    special_attack_name = "",
    difficulty_level = 0
}

-- Methods used
function Fighter:light_punch()
    print(self.name .. " used a light punch!")
end

function Fighter:string_punch()
    print(self.name .. " used a STRONG punch!")
end

function Fighter:light_kick()
    print(self.name .. " used a light kick!")
end

function Fighter:heavy_kick()
    print(self.name .. " used a HEAVY kick!")
end

function Fighter:attack_move()
    print(self.name .. " used a special attack move!!!")
end

-- Constructor created
function Fighter:new(t)
    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end

-------------------------------------------------------------------

val_brawlhalla = Fighter:new({
    name = "Val",
    coutry_of_origin = "Brawlhalla",
    special_attack_name = "Brawhalla has no fancy names :c",
    difficulty_level = 3
})

val_brawlhalla:light_punch()
val_brawlhalla:string_punch()
val_brawlhalla:light_kick()
val_brawlhalla:heavy_kick()
val_brawlhalla:attack_move()

