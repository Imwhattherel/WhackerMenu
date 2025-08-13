_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Agency Menu", "~h~Set your radio agency", 720, 100)
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled(false)
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)

-- Function to generate a random radio ID
function generateRadioID()
    local randomDigits = math.random(10000, 99999) -- Generate random 5 digits
    return "25" .. tostring(randomDigits) -- Prefix with "25"
end


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


function AddAgencyItems(menu)
    local agencies = {
        {label = "XTS5000",      command = "set_codeplug XTS5000",      color = "~b~"},
        {label = "XTL2500",      command = "set_codeplug XTL2500",      color = "~b~"},
        {label = "UNIG5",        command = "set_codeplug UNIG5",        color = "~b~"},
        {label = "SRX2200",      command = "set_codeplug SRX2200",      color = "~o~"},
        {label = "E5",           command = "set_codeplug E5",           color = "~r~"},
        {label = "APXNextXE",    command = "set_codeplug APXNextXE",    color = "~y~"},
        {label = "APXNext",      command = "set_codeplug APXNext",      color = "~g~"},
        {label = "APXNext-T",    command = "set_codeplug APXNext-T",    color = "~b~"},
        {label = "APXN70",       command = "set_codeplug APXN70",       color = "~o~"},
        {label = "APX900",       command = "set_codeplug APX900",       color = "~r~"},
        {label = "APX8000XE",    command = "set_codeplug APX8000XE",    color = "~y~"},
        {label = "APX7000",      command = "set_codeplug APX7000",      color = "~g~"},
        {label = "APX6000XE",    command = "set_codeplug APX6000XE",    color = "~b~"},
        {label = "APX6000",      command = "set_codeplug APX6000",      color = "~o~"},
        {label = "APX4500",      command = "set_codeplug APX4500",      color = "~r~"},
        {label = "APX4500-G",    command = "set_codeplug APX4500-G",    color = "~y~"},
        {label = "FD",           command = "set_codeplug FD",           color = "~g~"},
        {label = "PD",           command = "set_codeplug PD",           color = "~b~"}
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


function AddCreditsItem(menu)
    local creditsItem = NativeUI.CreateItem("Credits", "Contact me via Discord @ whattherel")
    menu:AddItem(creditsItem)
end


AddAgencyItems(mainMenu)   
SetRadioIDItem(mainMenu)   
AddCreditsItem(mainMenu)   
_menuPool:RefreshIndex()


RegisterCommand("codeplug", function()
    mainMenu:Visible(not mainMenu:Visible())
end, false)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)


function notify(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(false, true)
end


function displayStartupMessage()
    print('============================================================')
    print('==                                                        ==')
    print('==                   Agency Menu                          ==')
    print('==             Author: WhatTheReL                         ==')
    print('==                                                        ==')
    print('============================================================')
end


displayStartupMessage()
