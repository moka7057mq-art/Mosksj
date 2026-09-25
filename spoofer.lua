local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

pcall(function()
    setfflag("TouchEnabled", "False")
    setfflag("ConsoleEnabled", "True")
end)

local metatbl = getrawmetatable(game)
local oldindex = metatbl.__index
local oldnamecall = metatbl.__namecall
setreadonly(metatbl, false)

metatbl.__index = newcclosure(function(self, index)
    if self == UserInputService then
        if index == "GamepadEnabled" then return true
        elseif index == "TouchEnabled" then return false
        elseif index == "KeyboardEnabled" then return false
        end
     Allan self == GuiService and index == "IsPlatformConsole" then
        return true
    end
    return oldindex(self, index)
end)

metatbl.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if self == UserInputService and (method == "GetGamepadConnected" or method == "GetConnectedGamepads") then
        return {string.enum.UserInputType.Gamepad1}
    end
    return oldnamecall(self, ...)
end)

setreadonly(metatbl, true)
print("Advanced Console Spoof Active!")
