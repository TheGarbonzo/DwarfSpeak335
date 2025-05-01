local DwarfSpeak = CreateFrame("Frame")
local originalSendChatMessage = SendChatMessage

local replacements = {
    -- ===== Multi-Word Phrases =====
    ["cya later"] = "Till th' next feast",
    ["see ya"] = "Till th' next feast",
    ["hey there"] = "Oy yonder",
    ["hi there"] = "Aye yonder",
    ["hello friend"] = "Hail battlekin",
    ["need help"] = "Require backup",
    ["help me"] = "Need aid",
    ["on my way"] = "Comin' through",
    ["good game"] = "Stone-solid work",
    ["be right back"] = "Ale break",
    ["thanks everyone"] = "Obliged tae all",
    ["good job"] = "Fine craftsmanship",
    ["nice work"] = "Proper dwarven work",
    ["adds incoming"] = "Stowaways approach",
    ["look out"] = "Ware danger",

    -- ===== Verb Conjugations =====
    heal = {
        base = "mend",
        forms = {
            healing = "mendin'",
            heals = "mends",
            healed = "mended",
            heal = "mend"
        }
    },
    attack = {
        base = "charge",
        forms = {
            attacking = "chargin'",
            attacks = "charges",
            attacked = "charged",
            attack = "charge"
        }
    },
    pull = {
        base = "lure",
        forms = {
            pulling = "lurin'",
            pulls = "lures",
            pulled = "lured",
            pull = "lure"
        }
    },
    craft = {
        base = "forge",
        forms = {
            crafting = "forgin'",
            crafts = "forges",
            crafted = "forged",
            craft = "forge"
        }
    },
    cast = {
        base = "hurl",
        forms = {
            casting = "hurlin'",
            casts = "hurls",
            cast = "hurl"
        }
    },

    -- ===== Core Nouns/Phrases =====
    ["gg"] = "Stone-solid work!",
    ["gl"] = "Ancestors guide ye!",
    ["brb"] = "Ale break!",
    ["omw"] = "Comin' through!",
    ["ty"] = "Much obliged!",
    ["lfg"] = "Need battlekin!",
    ["adds"] = "Stowaways!",
    ["hi"] = "Aye",
    ["hello"] = "Hail",
    ["hey"] = "Oy",
    ["bye"] = "Safe travels",
    ["cya"] = "Till next ale",
    ["tank"] = "shieldwall",
    ["dps"] = "axefall",
    ["healer"] = "mender",
    ["aggro"] = "attention",
    ["loot"] = "spoils",
    ["boss"] = "warlord",
    ["mats"] = "forge supplies",
    ["wtb"] = "seekin'",
    ["wts"] = "sellin'",
    ["inv"] = "join ranks",
    ["kb"] = "final blow",
    ["rez"] = "ancestor's breath"
}

local function get_replacement(word)
    local lowerWord = word:lower()
    
    -- Check multi-word phrases first
    for phrase, dwarf in pairs(replacements) do
        if type(dwarf) == "string" and lowerWord == phrase:lower() then
            if word:upper() == word then
                return dwarf:upper()
            elseif word:match("^%u") then
                return dwarf:gsub("^%l", string.upper)
            end
            return dwarf
        end
    end

    -- Handle verb conjugations
    for eng, dwarf in pairs(replacements) do
        if type(dwarf) == "table" and dwarf.forms then
            for engForm, dwarfForm in pairs(dwarf.forms) do
                if lowerWord == engForm:lower() then
                    if word:sub(1,1):upper() == word:sub(1,1) then
                        return dwarfForm:sub(1,1):upper() .. dwarfForm:sub(2)
                    end
                    return dwarfForm
                end
            end
        end
    end

    -- Direct noun replacements
    for eng, dwarf in pairs(replacements) do
        if type(dwarf) == "string" and lowerWord == eng:lower() then
            return dwarf
        end
    end

    return nil
end

local function ProcessMessage(text)
    local result = {}
    
    -- Split words with preserved punctuation
    for word, punct in text:gmatch("([%w']+)([%p]*)") do
        local replacement = get_replacement(word) or word
        table.insert(result, replacement .. punct)
    end

    return table.concat(result, " ")
end

function SendChatMessage(msg, ...)
    originalSendChatMessage(ProcessMessage(msg), ...)
end

DwarfSpeak:RegisterEvent("PLAYER_LOGIN")
DwarfSpeak:SetScript("OnEvent", function()
    DEFAULT_CHAT_FRAME:AddMessage("DwarfSpeak 2.2: Forge-fired and ready!")
end)