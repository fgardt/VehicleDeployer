local ev = defines.events
local deploy_offset = 3.5

local function init()
    ---@type Global
    global = global or {}
    global.deployers = global.deployers or {}
end

script.on_init(init)
script.on_configuration_changed(init)

--- called by all events that could build a vehicle deployer
---@param event
---| EventData.on_built_entity
---| EventData.on_robot_built_entity
---| EventData.script_raised_built
---| EventData.script_raised_revive
local function deployer_built(event)
    local entity = event.created_entity or event.entity

    if not entity or not entity.valid then return end

    -- deploy position
    local deploy_pos = entity.position

    if entity.direction == defines.direction.north then
        deploy_pos.y = deploy_pos.y - deploy_offset
    elseif entity.direction == defines.direction.east then
        deploy_pos.x = deploy_pos.x + deploy_offset
    elseif entity.direction == defines.direction.south then
        deploy_pos.y = deploy_pos.y + deploy_offset
    elseif entity.direction == defines.direction.west then
        deploy_pos.x = deploy_pos.x - deploy_offset
    end

    -- store in global
    global.deployers[entity.unit_number] = {
        entity = entity,
        surface = entity.surface,
        deploy_pos = deploy_pos,
        registration = script.register_on_entity_destroyed(entity),
        input = entity.get_inventory(defines.inventory.furnace_source),
        storage = game.create_inventory(1),
        in_progress = false,
        active = true
    }
end

-- register all build events and filter for vehicle-deployer
script.on_event(ev.on_built_entity, deployer_built, { { filter = "name", name = "VD_vehicle-deployer" } })
script.on_event(ev.on_robot_built_entity, deployer_built, { { filter = "name", name = "VD_vehicle-deployer" } })
script.on_event(ev.script_raised_built, deployer_built, { { filter = "name", name = "VD_vehicle-deployer" } })
script.on_event(ev.script_raised_revive, deployer_built, { { filter = "name", name = "VD_vehicle-deployer" } })


script.on_event(ev.on_entity_destroyed, function(event)
    -- ignore if entity has no unit_number -> definitely not a deployer
    -- correct way to do this is to keep track of all the registrations
    -- and check if we have registered the entity that was destroyed
    if event.unit_number == nil then return end

    global.deployers[event.unit_number] = nil
end)


script.on_nth_tick(1, function()
    for unit_number, deployer in pairs(global.deployers) do
        local entity = deployer.entity
        if not entity or not entity.valid then
            global.deployers[unit_number] = nil
            goto continue
        end

        if not deployer.in_progress and deployer.active then
            entity.active = false
            deployer.active = false
            goto continue
        end

        -- check if the deployment of the current vehicle is finished
        if deployer.in_progress and entity.crafting_progress == 1 then
            local item = deployer.storage[1]
            local spawn_res = deployer.surface.create_entity({
                name = game.item_prototypes[item.name].place_result.name,
                position = deployer.deploy_pos,
                direction = entity.direction,
                force = entity.force,
                player = entity.last_user,
                raise_built = true,
                create_build_effect_smoke = true,
                move_stuck_players = true,
                item = item
            })

            entity.active = false
            deployer.active = false
            if not spawn_res or not spawn_res.valid then
                game.print("failed to deploy " .. item.name)
                goto continue
            end

            --game.print("finished deployment of " .. deployer.storage[1].name)
            deployer.in_progress = false
            deployer.storage.clear()

            -- empty input? -> wait 1 tick before setting inactive
            if deployer.input.is_empty() then
                entity.active = true
                deployer.active = true
                goto continue
            end
        end

        -- check if the deployer is active and has an item to deploy
        if not deployer.active and not deployer.in_progress and entity.energy > 0 then
            local item = deployer.input[1]
            if item and item.valid_for_read and item.count == 1 then
                entity.active = true
                deployer.active = true
                deployer.in_progress = true
                deployer.storage.insert(item)
                --game.print("started deployment of " .. item.name)
                goto continue
            end
        end

        ::continue::
    end
end)
