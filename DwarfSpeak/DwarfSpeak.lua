local DwarfSpeak = CreateFrame("Frame")
local orig_SendChatMessage = SendChatMessage

-- Saved Variables
DwarfSpeakDB = DwarfSpeakDB or {
    enabled = true,
    verbsEnabled = true,
    nounsEnabled = true
}

-- Verb Database
local verbs = {
    attack = {base = "charge", forms = {attacking = "chargin'", attacks = "charges", attacked = "charged"}},
    heal = {base = "mend", forms = {healing = "mendin'", heals = "mends", healed = "mended"}},
    cast = {base = "hurl", forms = {casting = "hurlin'", casts = "hurls", casted = "hurled"}},
    pull = {base = "lure", forms = {pulling = "lurin'", pulls = "lures", pulled = "lured"}},
    craft = {base = "forge", forms = {crafting = "forgin'", crafts = "forges", crafted = "forged"}}
}

-- Noun Database
local nouns = {
    tank = "shieldwall",
    boss = "warlord",
    loot = "spoils",
    healer = "mender",
    dps = "axefall"
}

-- Case Preservation
local function ApplyCase(replacement, original)
    if original == string.upper(original) then
        return string.upper(replacement)
    elseif string.find(original, "^%u") then
        return string.upper(string.sub(replacement, 1, 1))..string.sub(replacement, 2)
    end
    return replacement
end

-- Text Processing
local function ProcessText(text)
    if not DwarfSpeakDB.enabled then return text end
    
    local result = {}
    for word, punct in string.gmatch(text, "([%w']+)([%p]*)") do
        local lowerWord = string.lower(word)
        local replaced
        
        -- Verb Conjugation
        if DwarfSpeakDB.verbsEnabled then
            for verb, data in pairs(verbs) do
                for engForm, dwarvForm in pairs(data.forms) do
                    if lowerWord == string.lower(engForm) then
                        replaced = ApplyCase(dwarvForm, word)
                        break
                    end
                end
                if replaced then break end
            end
        end
        
        -- Noun Replacement
        if not replaced and DwarfSpeakDB.nounsEnabled then
            local noun = nouns[lowerWord]
            if noun then
                replaced = ApplyCase(noun, word)
            end
        end
        
        table.insert(result, (replaced or word)..punct)
    end
    
    return table.concat(result, " ")
end

-- Chat Hook
function SendChatMessage(msg, ...)
    orig_SendChatMessage(ProcessText(msg), ...)
end

-- Settings Panel
local function CreatePanel()
    local panel = CreateFrame("Frame")
    panel.name = "DwarfSpeak"
    
    -- Title
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("DwarfSpeak Settings")
    
    -- Master Toggle
    local masterToggle = CreateFrame("CheckButton", "DwarfSpeakMasterToggle", panel, "OptionsCheckButtonTemplate")
    masterToggle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -16)
    getglobal(masterToggle:GetName().."Text"):SetText("Enable DwarfSpeak")
    masterToggle:SetChecked(DwarfSpeakDB.enabled)
    masterToggle:SetScript("OnClick", function(self) 
        DwarfSpeakDB.enabled = self:GetChecked()
        DEFAULT_CHAT_FRAME:AddMessage("DwarfSpeak: "..(DwarfSpeakDB.enabled and "|cFF00FF00Enabled|r" or "|cFFFF0000Disabled|r"))
    end)
    
    -- Verbs Toggle
    local verbsToggle = CreateFrame("CheckButton", "DwarfSpeakVerbsToggle", panel, "OptionsCheckButtonTemplate")
    verbsToggle:SetPoint("TOPLEFT", masterToggle, "BOTTOMLEFT", 0, -16)
    getglobal(verbsToggle:GetName().."Text"):SetText("Enable Verb Conjugation")
    verbsToggle:SetChecked(DwarfSpeakDB.verbsEnabled)
    verbsToggle:SetScript("OnClick", function(self)
        DwarfSpeakDB.verbsEnabled = self:GetChecked()
    end)
    
    -- Nouns Toggle
    local nounsToggle = CreateFrame("CheckButton", "DwarfSpeakNounsToggle", panel, "OptionsCheckButtonTemplate")
    nounsToggle:SetPoint("TOPLEFT", verbsToggle, "BOTTOMLEFT", 0, -16)
    getglobal(nounsToggle:GetName().."Text"):SetText("Enable Noun Replacement")
    nounsToggle:SetChecked(DwarfSpeakDB.nounsEnabled)
    nounsToggle:SetScript("OnClick", function(self)
        DwarfSpeakDB.nounsEnabled = self:GetChecked()
    end)
    
    InterfaceOptions_AddCategory(panel)
end

-- Initialize
DwarfSpeak:RegisterEvent("PLAYER_LOGIN")
DwarfSpeak:SetScript("OnEvent", function()
    -- Initialize DB if it doesn't exist
    if not DwarfSpeakDB then
        DwarfSpeakDB = {
            enabled = true,
            verbsEnabled = true,
            nounsEnabled = true
        }
    end
    
    CreatePanel()
    
    -- Slash Commands
    SLASH_DWARFSPEAK1 = "/dwarfspeak"
    SlashCmdList["DWARFSPEAK"] = function(input)
        if input and input ~= "" then
            print("DwarfSpeak:", ProcessText(input))
        else
            InterfaceOptionsFrame_OpenToCategory("DwarfSpeak")
            InterfaceOptionsFrame_OpenToCategory("DwarfSpeak") -- Fix Blizzard UI bug
        end
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("DwarfSpeak v1.0 loaded. Type /dwarfspeak for options.")
end)