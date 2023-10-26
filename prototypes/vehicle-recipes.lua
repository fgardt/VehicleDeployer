-- add deploy recipe category
data:extend({ {
    type = "recipe-category",
    name = "VD_vehicle-deployment"
} })

-- get all vehicles to make recipes for
local vehicles = {}

-- car vehicles
for name, vehicle in pairs(data.raw["car"]) do
    vehicles["c-" .. name] = vehicle
end

-- spider vehicles
for name, vehicle in pairs(data.raw["spider-vehicle"]) do
    vehicles["s-" .. name] = vehicle
end

-- generate all deploy recipes
for name, vehicle in pairs(vehicles) do
    local items = {}
    if vehicle.placeable_by then
        if vehicle.placeable_by.item then
            -- singular item
            table.insert(items, { name = vehicle.placeable_by.item })
        else
            -- array of items
            for _, i in pairs(vehicle.placeable_by) do
                table.insert(items, { name = i.item })
            end
        end
    else
        -- check ALL items if they place this vehicle
        for _, item in pairs(data.raw["item-with-entity-data"]) do
            if item.place_result == vehicle.name then
                table.insert(items, item)
            end
        end

        if not next(items) then
            goto continue
        end
    end

    for _, item in pairs(items) do
        data:extend({ {
            type = "recipe",
            name = "VD_vehicle-deploy-" .. name .. "-" .. item.name,
            hide_from_player_crafting = true,
            enabled = true,
            category = "VD_vehicle-deployment",
            ingredients = { { item.name, 1 } },
            result = item.name,
            energy_required = 10,
            allow_inserter_overload = false,
            overload_multiplier = 1,
            order = "z[vehicle-deployer-" .. name .. "-" .. item.name .. "]"
        } })
    end

    ::continue::
end
