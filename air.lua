-- Config
local MESide = "left"
local binderSide = "right"

-- Variableq
local ME = peripheral.wrap(MESide)

local inert_crystal_name = "elementalcraft:inert_crystal"

local function MECraft (name, number)
    local item = {
        name = name,
        count = number
    }
    if ME.isItemCraftable(item) then
        ME.craftItem(item)
        repeat sleep(0.5)
        until ME.isItemCrafting({name = name})
    end
end

local function MEAutocraft (name, number)
    local item = {
        name = name
    }

    curItem = ME.getItem(item)
    local diff = number - curItem.amount

    if diff > 0 then
        MECraft(name, diff)
    end
end

while true do
    MEAutocraft("minecraft:gold_ingot", 64)
    sleep(1)
end
