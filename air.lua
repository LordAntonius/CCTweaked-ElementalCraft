-- Config
local MESide = "left"
local binderSide = "right"

-- Variables
local ME = peripheral.wrap(MESide)

--local inert_crystal_name = "elementalcraft:inert_crystal"
local air_crystal_recipe = {"elementalcraft:inert_crystal"}

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
    for k,v in t do
        MEAutocraft(v,1)
        if ME.getItem({name = v}).amount < 1 then
            -- Not enough items
            return false
        end
        ME.exportItemToPeripheral({name=v, amount = 1}, binderSide)
        repeat 
            local n = ME.importItemFromPeripheral(itemName, binderSide)
            sleep(0.5)
        until n > 0
    end
end

elementalcraftCraftSequence(air_crystal_recipe, "elementalcraft:aircrystal")
--while true do
    --MEAutocraft("minecraft:gold_ingot", 64)
    sleep(1)
--end
