local graphics_path = "__vehicle-deployer__/graphics/"

-- icon
---@type data.IconData
local deployer_icon = {
    icon = graphics_path .. "icon/vehicle-deployer.png",
    icon_mipmaps = 4,
    icon_size = 64
}

-- entity
local entity_graphics_path = graphics_path .. "entity/vehicle-deployer/"

---@type data.FurnacePrototype
local entity = {
    type = "furnace",
    name = "VD_vehicle-deployer",
    icons = { deployer_icon },

    source_inventory_size = 1,
    result_inventory_size = 0,
    base_productivity = 0,
    crafting_speed = 1,
    crafting_categories = { "VD_vehicle-deployment" },
    allowed_effects = { "consumption", "pollution" },
    module_specification = { module_slots = 0 },

    energy_usage = "313kW",
    energy_source = {
        type = "electric",
        emissions_per_minute = 2.5,
        buffer_capacity = "1000kJ",
        usage_priority = "secondary-input",
        drain = "12kW"
    },

    allowed_copy_paste = false,
    show_recipe_icon = false,
    show_recipe_icon_on_map = false,
    is_military_target = false,
    alert_when_damaged = true,

    collision_box = { { -1.2, -0.7 }, { 1.2, 0.7 } },
    selection_box = { { -1.5, -1.0 }, { 1.5, 1.0 } },
    minable = {
        mining_time = 0.75,
        result = "VD_vehicle-deployer"
    },

    flags = {
        "not-upgradable",
        "no-automated-item-removal",
        "placeable-neutral",
        "placeable-player",
        "player-creation"
    },

    max_health = 400,
    resistances = {
        {
            type = "fire",
            percent = 90
        }
    },

    open_sound = table.deepcopy(data.raw["furnace"]["electric-furnace"].open_sound),
    close_sound = table.deepcopy(data.raw["furnace"]["electric-furnace"].close_sound),
    vehicle_impact_sound = table.deepcopy(data.raw["furnace"]["electric-furnace"].vehicle_impact_sound),
    dying_trigger_effect = table.deepcopy(data.raw["furnace"]["electric-furnace"].dying_trigger_effect),
    dying_explosion = table.deepcopy(data.raw["furnace"]["electric-furnace"].dying_explosion),

    animation = {
        north = {
            layers = {
                {
                    filename = entity_graphics_path .. "lr-base.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 0, 0 },
                    scale = 0.5,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-base.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 0, 0 },
                        scale = 0.25
                    }
                },
                {
                    filename = entity_graphics_path .. "lr-shadow.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 0, 0 },
                    scale = 0.5,
                    draw_as_shadow = true,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-shadow.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 0, 0 },
                        scale = 0.25,
                        draw_as_shadow = true
                    }
                }
            }
        },
        east = {
            layers = {
                {
                    filename = entity_graphics_path .. "lr-base.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 272, 0 },
                    scale = 0.5,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-base.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 544, 0 },
                        scale = 0.25
                    }
                },
                {
                    filename = entity_graphics_path .. "lr-shadow.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 272, 0 },
                    scale = 0.5,
                    draw_as_shadow = true,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-shadow.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 544, 0 },
                        scale = 0.25,
                        draw_as_shadow = true
                    }
                }
            }
        },
        south = {
            layers = {
                {
                    filename = entity_graphics_path .. "lr-base.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 0, 272 },
                    scale = 0.5,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-base.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 0, 544 },
                        scale = 0.25
                    }
                },
                {
                    filename = entity_graphics_path .. "lr-shadow.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 0, 272 },
                    scale = 0.5,
                    draw_as_shadow = true,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-shadow.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 0, 544 },
                        scale = 0.25,
                        draw_as_shadow = true
                    }
                }
            }
        },
        west = {
            layers = {
                {
                    filename = entity_graphics_path .. "lr-base.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 272, 272 },
                    scale = 0.5,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-base.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 544, 544 },
                        scale = 0.25
                    }
                },
                {
                    filename = entity_graphics_path .. "lr-shadow.png",
                    frame_count = 1,
                    height = 272,
                    width = 272,
                    position = { 272, 272 },
                    scale = 0.5,
                    draw_as_shadow = true,
                    hr_version = {
                        filename = entity_graphics_path .. "hr-shadow.png",
                        frame_count = 1,
                        height = 544,
                        width = 544,
                        position = { 544, 544 },
                        scale = 0.25,
                        draw_as_shadow = true
                    }
                }
            }
        }
    },

    water_reflection = {
        orientation_to_variation = true,
        rotate = false,
        pictures = {
            filename = entity_graphics_path .. "lr-reflection.png",
            size = { 272, 272 },
            priority = "extra-high",
            variation_count = 4,
            line_length = 2,
            scale = 0.5,
            hr_version = {
                filename = entity_graphics_path .. "hr-reflection.png",
                size = { 544, 544 },
                priority = "extra-high",
                variation_count = 4,
                line_length = 2,
                scale = 0.25
            }
        }
    },
}

-- item
---@type data.ItemPrototype
local item = {
    type = "item",
    name = "VD_vehicle-deployer",
    icons = { deployer_icon },

    stack_size = 10,
    default_request_amount = 5,

    place_result = "VD_vehicle-deployer",
    subgroup = "transport",
    order = "z[vehicle-deployer]"
}

-- recipe
---@type data.RecipePrototype
local recipe = {
    type = "recipe",
    name = "VD_vehicle-deployer",
    enabled = false,
    ingredients = {
        { "processing-unit",      50 },
        { "steel-plate",          15 },
        { "electric-engine-unit", 10 }
    },
    result = "VD_vehicle-deployer",
    result_count = 1,
    energy_required = 10
}

-- technology
---@type data.TechnologyPrototype
local technology = {
    type = "technology",
    name = "VD_vehicle-deployer",
    icon = graphics_path .. "technology/vehicle-deployer.png",
    icon_mipmaps = 4,
    icon_size = 256,
    effects = {
        {
            type = "unlock-recipe",
            recipe = "VD_vehicle-deployer"
        }
    },
    prerequisites = { "utility-science-pack" },
    unit = {
        count = 125,
        ingredients = {
            { "automation-science-pack", 1 },
            { "logistic-science-pack",   1 },
            { "chemical-science-pack",   1 },
            { "utility-science-pack",    1 }
        },
        time = 45
    },
    order = "z[vehicle-deployer]"
}


data:extend({ entity, item, recipe, technology })
