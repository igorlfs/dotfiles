-- Yoinked from https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/utils/colors.lua
local M = {}

---@param hex_str string hexadecimal value of a color
---@return [number?,number?,number?]
local hex_to_rgb = function(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local red, green, blue = string.match(hex_str, pat)

    assert(red)
    assert(green)
    assert(blue)

    return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---@param fg string forecrust color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
---@return string
function M.blend(fg, bg, alpha)
    local bg_ = hex_to_rgb(bg)
    local fg_ = hex_to_rgb(fg)

    ---@param i integer
    ---@return integer
    local blendChannel = function(i)
        local ret = (alpha * assert(fg_[i]) + ((1 - alpha) * assert(bg_[i])))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

---@param hex string
---@param amount number
---@param bg string
---@return string
function M.darken(hex, amount, bg)
    return M.blend(hex, bg, math.abs(amount))
end

---@param hex string
---@param amount number
---@param fg string
---@return string
function M.lighten(hex, amount, fg)
    return M.blend(hex, fg, math.abs(amount))
end

return M
