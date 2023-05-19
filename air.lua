-- Config
local MESide = "left"
local binderSide = "right"


-- Variables
local ME = peripheral.wrap(MESide)

local air_crystal_recipe = {"elementalcraft:inert_crystal"}
local swift_alloy_recipe = {"minecraft:gold_ingot", "elementalcraft:drenched_iron_ingot", "minecraft:copper_ingot", "minecraft:redstone", "elementalcraft:aircrystal"}

local function MECraft (name, number)
    local item = {
        name = name,
        count = number
    }
    if ME.isItemCraftable(item) then
        ME.craftItem(item)
        repeat sleep(0.5)
        until not ME.isItemCrafting({name = name})
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

local function elementalcraftCraftSequence(t, itemName)
    for k,v in pairs(t) do
        MEAutocraft(v,1)
        if ME.getItem({name = v}).amount < 1 then
            -- Not enough items
            return false
        end
        ME.exportItemToPeripheral({name=v, count = 1}, binderSide)
    end
    local n = 0
    repeat 
        n = ME.importItemFromPeripheral({name=itemName}, binderSide)
        sleep(0.5)
    until n > 0
end

for i = 1, 64 do
elementalcraftCraftSequence(swift_alloy_recipe, "elementalcraft:swift_alloy_ingot")
--while true do
    --MEAutocraft("minecraft:gold_ingot", 64)
    sleep(1)
end
--end
