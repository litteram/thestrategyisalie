local addonName, addon = ...

local macroName = addonName.."Say"
local macroIcon = 132310
local macroBody = "/click "..addonName

local pp = _G.DevTools_Dump

local function createOrUpdateMacro()
    local id, _, _ = GetMacroInfo(macroName)
    if id == nil then
        CreateMacro(macroName, macroIcon, macroBody, false)
    end
end

local function OnEvent(self, evt, ...)
    if evt == "PLAYER_ENTERING_WORLD" then
        createOrUpdateMacro()
    end
end

local function OnClick(...)
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID = GetInstanceInfo()

    if addon.dungeons[instanceID] == nil then return end

    local msg = addon.dungeons[instanceID]

    for m in msg:gmatch("([^\n]*)\n?") do
	    SendChatMessage(m, IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and 'INSTANCE_CHAT' or IsInRaid() and 'RAID' or IsInGroup() and 'PARTY' or 'SAY')
    end
end

local f = CreateFrame("Button", addonName)
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", OnEvent)
f:SetScript("OnClick", OnClick)
