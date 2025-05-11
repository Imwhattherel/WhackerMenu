_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Agency Menu", "~h~Set your radio agency", 720, 100)
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled(false) -- Disable cursor
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)

-- Function to generate a random radio ID
function generateRadioID()
    local randomDigits = math.random(10000, 99999) -- Generate random 5 digits
    return "31" .. tostring(randomDigits) -- Prefix with "31"
end

-- Add the "Set Radio ID" button
function SetRadioIDItem(menu)
    local radioIDItem = NativeUI.CreateItem("Set Radio ID", "Generate and set a new Radio ID.")
    radioIDItem.Activated = function(sender, item)
        if item == radioIDItem then
            local radioID = generateRadioID()
            ExecuteCommand("set_rid " .. radioID)
            notify("Radio ID set to ~b~" .. radioID)
        end
    end
    menu:AddItem(radioIDItem)
end

-- Add buttons for setting agencies
function AddAgencyItems(menu)
    local agencies = {
        {label = "PD", command = "set_codeplug PD", color = "~b~"},
        {label = "HP", command = "set_codeplug HP", color = "~b~"},
        {label = "DOT", command = "set_codeplug DOT", color = "~o~"},
        {label = "FD", command = "set_codeplug FD", color = "~r~"},
        {label = "SO", command = "set_codeplug SO", color = "~y~"},
        {label = "EMS", command = "set_codeplug EMS", color = "~g~"}
    }

    for _, agency in ipairs(agencies) do
        local agencyItem = NativeUI.CreateItem("" .. agency.color .. agency.label, "Set agency to " .. agency.label)
        agencyItem.Activated = function(sender, item)
            if item == agencyItem then
                ExecuteCommand(agency.command)
                notify("Agency set to " .. agency.color .. agency.label)
            end
        end
        menu:AddItem(agencyItem)
    end
end

-- Add the "Credits" button
function AddCreditsItem(menu)
    local creditsItem = NativeUI.CreateItem("Credits", "Contact me via Discord @ whattherel")
    menu:AddItem(creditsItem)
end

-- Add all items to the main menu
AddAgencyItems(mainMenu)   -- Add agency buttons
SetRadioIDItem(mainMenu)   -- Add the "Set Radio ID" button
AddCreditsItem(mainMenu)   -- Add the credits button
_menuPool:RefreshIndex()

-- Command to open the menu
RegisterCommand("codeplug", function()
    mainMenu:Visible(not mainMenu:Visible())
end, false)

-- Process the menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

-- Notification function
function notify(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(false, true)
end

-- Display startup message in the console
function displayStartupMessage()
    print('============================================================')
    print('==                                                        ==')
    print('==                   Agency Menu                          ==')
    print('==             Author: WhatTheReL                         ==')
    print('==                                                        ==')
    print('============================================================')
end

-- Show the startup message
displayStartupMessage()
