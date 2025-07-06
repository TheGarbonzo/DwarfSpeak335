# DwarfSpeak - Dwarven Speech Converter for WoW 3.3.5 (WotLK)

<img src="https://img.shields.io/badge/Version-2.0-blue" alt="Version"> 
<img src="https://img.shields.io/badge/WoW-3.3.5_(WotLK)-orange" alt="WoW Version">
<img src="https://img.shields.io/badge/Lua-100%25-purple" alt="Lua">

## Description

DwarfSpeak transforms common combat terms into flavorful Dwarven language equivalents, perfect for roleplaying dwarves or adding mountain-born flavor to your chat!

### Features

✔ Converts verbs like "attack" → "charge" with proper conjugations ("attacking" → "chargin'")  
✔ Replaces nouns like "boss" → "warlord" and "healer" → "mender"  
✔ Preserves original capitalization and punctuation  
✔ Configurable options to enable/disable verb or noun replacements  
✔ Simple slash command interface  

## Installation

1. Download the latest release
2. Extract to your WoW addons folder:  
   `World of Warcraft/_classic_/Interface/AddOns/`
3. Rename folder to just "DwarfSpeak" (remove any -main or version numbers)
4. Launch WoW and enable the addon in character selection screen

## Usage

The addon automatically processes all chat messages you send.

### Commands

| Command | Description |
|---------|-------------|
| `/dwarfspeak` | Open settings panel |
| `/dwarfspeak [text]` | Test conversion without sending chat |

### Settings

Access through Interface Options or via slash command:

- **Enable DwarfSpeak**: Master on/off toggle
- **Enable Verb Conjugation**: Toggle verb replacements
- **Enable Noun Replacement**: Toggle noun replacements

### Examples

| Original | Dwarven Version |
|----------|-----------------|
| "Attack the boss!" | "Charge the warlord!" |
| "I'm healing the tank" | "I'm mendin' the shieldwall" |
| "They pulled the mobs" | "They lured the mobs" |

## Word Replacements

### Verbs

| English | Dwarven | Present | Gerund | Past |
|---------|---------|---------|--------|------|
| attack | charge | charges | chargin' | charged |
| heal | mend | mends | mendin' | mended |
| cast | hurl | hurls | hurlin' | hurled |
| pull | lure | lures | lurin' | lured |
| craft | forge | forges | forgin' | forged |

### Nouns

| English | Dwarven |
|---------|---------|
| tank | shieldwall |
| boss | warlord |
| loot | spoils |
| healer | mender |
| dps | axefall |

## Feedback & Contributions

Suggestions welcome! Please open an issue to:
- Propose new word replacements
- Report bugs
- Suggest improvements

---

*"By the beard!" - Popular Dwarven expression*
