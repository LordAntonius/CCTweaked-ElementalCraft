-- Config
local MESide = "left"
local binderSide = "right"

-- Variableq
local ME = peripheral.wrap(MESide)

local inert_crystal_name = "elementalcraft:inert_crystal"

local function MEcraft (name, number) {
    local item = {
        name = name,
        count = number
    }
    if ME.isItemCraftable(item) then
        ME.craftItem(item)
    end
}

local function MEAutocraft (name, number) {
    local item = {
        name = name
    }

    curItem = ME.getItem(item)
    local diff = curItem.amount - number

    if diff > 0 then
        MEcraft(name, diff)
    end
}

while true do
    MEAutocraft("minecraft:gold_ingot", 64)
    sleep(1)
end
