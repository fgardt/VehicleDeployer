---@meta

---@class DeployerInfo
---@field entity LuaEntity
---@field surface LuaSurface
---@field deploy_pos MapPosition
---@field registration uint64
---@field input LuaInventory
---@field storage LuaInventory
---@field in_progress boolean
---@field active boolean

---@class Global
---@field deployers table<uint, DeployerInfo>
