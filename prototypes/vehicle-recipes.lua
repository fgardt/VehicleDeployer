-- add deploy recipe category
data:extend{{
    type = "recipe-category",
    name = "vehicle-deployment"
}}

-- get all vehicles to make recipes for
local vehicles = {}

-- car vehicles
for name, _ in pairs(data.raw["car"]) do
    vehicles[#vehicles+1] = name
end

-- spider vehicles
for name, _ in pairs(data.raw["spider-vehicle"]) do
    vehicles[#vehicles+1] = name
end

-- generate all deploy recipes
for _, vehicle in ipairs(vehicles) do
    data:extend{{
        type = "recipe",
        name = "vehicle-deploy-" .. vehicle,
        hide_from_player_crafting = true,
        enabled = true,
        category = "vehicle-deployment",
        ingredients = {{vehicle, 1}},
        result = vehicle,
        energy_required = 10,
        allow_inserter_overload = false,
        overload_multiplier = 1,
        order = "z[vehicle-deployer-" .. vehicle .. "]"
    }}
end
