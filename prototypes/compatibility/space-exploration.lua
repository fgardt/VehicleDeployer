local const = require("const")

if not mods["space-exploration"] then return end

local deployer = data.raw.furnace[const.ENTITY]

deployer.se_allow_in_space = true
