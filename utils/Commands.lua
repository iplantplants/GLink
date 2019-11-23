addonName, GLink = ...;

GLink.colour = "|cff00CCFF";
GLink.altColour = "|cffADFFFF";
GLink.currentMap = select(8,GetInstanceInfo());
--/run print((select(8,GetInstanceInfo())))
GLink.commands = {

    ["lookup"] = {
        ["Item"] = {
            ["PATTERN"] = "Hitem:(%d%)",
        },
        ["GameObject"] = {
            ["PATTERN"] = "Hgobject_entry:(%d*)",
        },
    }

}
--Keep all command syntaxes here
GLink.hyperlinks = {
    ["gameobject_entry"] = {
        ["PATTERN"] = {"gameobject_entry:(%d*)"}, 
        ["RETURNS"] = {"[Spawn]"},
        ["COMMAND"] = {"gobject spawn #gameobject_entry"},
        ["TOOLTIP_TEXT"] = {"Spawn object with entry: #gameobject_entry"},
    },
    ["item"] = {
        ["PATTERN"] = {"item:(%d*)"},
        ["RETURNS"] = {"[Add]"},
        ["COMMAND"] = {"additem #item"},
        ["TOOLTIP_TEXT"] = {"N/A"},
    },
    ["creature_entry"] = {
        ["PATTERN"] = {"creature_entry:(%d*)"},
        ["RETURNS"] = {"[Spawn]"},
        ["COMMAND"] = {"npc spawn #creature_entry"},
        ["TOOLTIP_TEXT"] = {"Spawn creature with entry: #creature_entry"},
    },
    ["lookup next"] = {
        ["PATTERN"] = {"Enter .lookup next to view the next (%d*) results"},
        ["RETURNS"] = {"[Next]"},
        ["COMMAND"] = {"lookup next"},
        ["TOOLTIP_TEXT"] = {"View next ~50 results."},
    },
    ["gameobject_GUID"] = {
        ["PATTERN"] = {"%(GUID: |cff00CCFF(%d*)|r%)", "gameobject_GUID:(%d*)"},
        ["RETURNS"] = {"[Select]", "[Go]", "[Delete]"},
        ["COMMAND"] = {"gobject select #gameobject_GUID", "gobject go #gameobject_GUID", "gobject delete #gameobject_GUID"},
        ["TOOLTIP_TEXT"] = {"Select gameobject with GUID: "..GLink.colour.."#gameobject_GUID", "Go to object with GUID: "..GLink.colour.."#gameobject_GUID", "Delete gobject with GUID: "..GLink.colour.."#gameobject_GUID"},
    },
    ["gameobject_ENTRY"] = {
        ["PATTERN"] = {"Spawned gameobject |cff00CCFF%[.+ %- (%d*)%]",  "Selected gameobject |cff00CCFF%[.+ %- (%d*)%]", "gameobject_ENTRY:(%d*)"},
        ["RETURNS"] = {"[Spawn]"},
        ["COMMAND"] = {"gobject spawn #gameobject_ENTRY"},
        ["TOOLTIP_TEXT"] = {"Spawn gameobject with entry: "..GLink.colour.."#gameobject_ENTRY|r"},
    },
    ["NPC_GUID"] = {
        ["PATTERN"] = {"%Selected NPC: GUID: |cff00CCFF(%d*)|r,", "NPC_GUID:(%d*)"},
        ["RETURNS"] = {"[Go]", "[Delete]"},
        ["COMMAND"] = {"npc go #NPC_GUID", "npc delete #NPC_GUID"},
        ["TOOLTIP_TEXT"] = {"npc go #NPC_GUID", "npc delete #NPC_GUID"},
    },
    ["NPC_DISPLAYID"] = {
        ["PATTERN"] = {", DisplayID: |cff00CCFF(%d*)|r,", "NPC_DISPLAYID:(%d*)"},
        ["RETURNS"] = {"[Morph]", "[Native]", "[Mount]"},
        ["COMMAND"] = {"morph #NPC_DISPLAYID", "mod native #NPC_DISPLAYID", "mod mount #NPC_DISPLAYID"},
        ["TOOLTIP_TEXT"] = {"morph #NPC_DISPLAYID", "mod native #NPC_DISPLAYID", "mod mount #NPC_DISPLAYID"},
    },
    ["CREATURE_DISPLAYID"] = {
        ["PATTERN"] = {"%[|cff00CCFF(%d*)|r.*%.m2", "CREATURE_DISPLAYID:(%d*)"},
        ["RETURNS"] = {"[Morph]", "[Native]", "[Mount]"},
        ["COMMAND"] = {"morph #CREATURE_DISPLAYID", "mod native #CREATURE_DISPLAYID", "mod mount #CREATURE_DISPLAYID"},
        ["TOOLTIP_TEXT"] = {"morph #CREATURE_DISPLAYID", "mod native #CREATURE_DISPLAYID", "mod mount #CREATURE_DISPLAYID"},
    },
    ["gameobject_GPS"] = {
        --x:(-?%d*\.?%d*)y:(-?%d*\.?%d*)z:(-?%d*\.?%d*)m:(%d*)o:(-?%d*\.?%d*)
        ["PATTERN"] = {"%(?X: |cff00CCFF(-?%d*\.?%d*)|r,", "Y: |cff00CCFF(-?%d*\.?%d*)|r,", "Z: |cff00CCFF(-?%d*\.?%d*)|r:?,", "Yaw/Turn: |cff00CCFF(-?%d*\.?%d*)|r", "O: |cff00CCFF(-?%d*\.?%d*)|r", "gameobject_GPS:(-?%d*\.?%d*):(-?%d*\.?%d*):(-?%d*\.?%d*):(-?%d*\.?%d*):(%d*)"},
        ["RETURNS"] = {"[Teleport]", "[Copy Coordinates]"},
        ["COMMAND"] = {"worldport #X #Y #Z #ORI #MAP", "Copy Coordinates #X #Y #Z #ORI #MAP"},
        ["TOOLTIP_TEXT"] = {"Teleport to coordinates.", "No"},
    },
    ["tele"] = {

        ["PATTERN"] = {"Htele:(%d*)", "tele:(%d*)"},
        ["RETURNS"] = {"[Teleport]"},
        ["COMMAND"] = {"tele #tele"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["spell"] = {

        ["PATTERN"] = {"Hspell:(%d*)", "spell:(%d*)"},
        ["RETURNS"] = {"[Cast]", "[Aura]"},
        ["COMMAND"] = {"cast #spell", "aura #spell"},
        ["TOOLTIP_TEXT"] = {},
    },
    --735.5 changes
    -- ["gameobject_GUID"] = {
    --     ["PATTERN"] = "gameobject_GUID:(%d*)", 
    --     ["RETURNS"] = {"[Select]", "[Go]", "[Delete]"},
    --     ["COMMAND"] = {"gobject select #gameobject_GUID", "gobject go #gameobject_GUID", "gobject delete #gameobject_GUID"},
    -- },
    --creaturedisplayID
    ["creatureDisplayID"] = {
        ["PATTERN"] = {"creatureDisplayID:(%d*)"},
        ["RETURNS"] = {"[Native]", "[Morph]", "[Mount]"},
        ["COMMAND"] = {"mod native #creatureDisplayID", "morph #creatureDisplayID", "mod mount #creatureDisplayID"},
    },
    ["displayID"] = {
        ["PATTERN"] = {"displayID:(%d*)"},
        ["RETURNS"] = {"[Morph]", "[Mount]"},
        ["COMMAND"] = {"morph #displayID", "mod mount #displayID"},
    },
    ["nativeID"] = {
        ["PATTERN"] = {"nativeID:(%d*)"},
        ["RETURNS"] = {"[Native]"},
        ["COMMAND"] = {"mod native #nativeID"},
    },
    ["emoteID"] = {
        ["PATTERN"] = {"emoteID:(%d*)"},
        ["RETURNS"] = {"[Emote]"},
        ["COMMAND"] = {"mod stand #emoteID"},
    },
    ["phaseID"] = {
        ["PATTERN"] = {"phaseID:(%d*)"},
        ["RETURNS"] = {"[Join]"},
        ["COMMAND"] = {"phase enter #phaseID"},
        ["TOOLTIP_TEXT"] = {"Click to enter #phaseID"},
    },
}