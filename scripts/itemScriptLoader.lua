local scriptPath = config.getParameter("itemScript") and config.getParameter("itemScript.script")

local version = "v1.0"
local logWarn = function(msg, ...)
  sb.logWarn("ItemScripts %s: " .. msg, version, ...)
end

-- Compatibility check for Item Interfaces v1.0.0(+)
if not scriptPath then
  if config.getParameter("itemInterface") then
    scriptPath = "/items/active/fossil/activeItemInterface.lua"
  else
    return
  end
end

-- Store references
local i, up, un, ac = init, update, uninit, activate

-- Check if the file exists.
if not pcall(function() require(scriptPath) end) then
  logWarn("Could not load the script '%s'.", scriptPath)
  return
end

-- New init is assigned, but init is already called to reach this code. To fix, we call it manually.
if i ~= init then init() end

-- New update isn't assigned; disable the update callback.
if up == update then update = nil end

-- New uninit isn't assigned; disable the uninit callback.
if un == uninit then uninit = nil end

-- New activate isn't assigned; disable the activate callback.
if ac == activate then activate = nil end

-- If we reached this part, that means a valid script was loaded.
itemScript = true