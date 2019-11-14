addonName, GLink = ...;

GLink.colour = "|cff00CCFF";
GLink.altColour = "|cffADFFFF";
GLink.currentMap = GLink.currentMap or nil;

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
        ["TOOLTIP_TEXT"] = {},
    },
    ["item"] = {
        ["PATTERN"] = {"item:(%d*)"},
        ["RETURNS"] = {"[Add]"},
        ["COMMAND"] = {"additem #item"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["creature_entry"] = {
        ["PATTERN"] = {"creature_entry:(%d*)"},
        ["RETURNS"] = {"[Spawn]"},
        ["COMMAND"] = {"npc spawn #creature_entry"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["lookup next"] = {
        ["PATTERN"] = {"Enter .lookup next to view the next (%d*) results"},
        ["RETURNS"] = {"[Next]"},
        ["COMMAND"] = {"lookup next"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["gameobject_GUID"] = {
        ["PATTERN"] = {"%(GUID: |cff00CCFF(%d*)|r%)", "gameobject_GUID:(%d*)"},
        ["RETURNS"] = {"[Select]", "[Go]", "[Delete]"},
        ["COMMAND"] = {"gobject select #gameobject_GUID", "gobject go #gameobject_GUID", "gobject delete #gameobject_GUID"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["NPC_GUID"] = {
        ["PATTERN"] = {"%Selected NPC: GUID: |cff00CCFF(%d*)|r,", "NPC_GUID:(%d*)"},
        ["RETURNS"] = {"[Go]", "[Delete]"},
        ["COMMAND"] = {"npc go #NPC_GUID", "npc delete #NPC_GUID"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["NPC_DISPLAYID"] = {
        ["PATTERN"] = {", DisplayID: |cff00CCFF(%d*)|r,", "NPC_DISPLAYID:(%d*)"},
        ["RETURNS"] = {"[Morph]", "[Native]", "[Mount]"},
        ["COMMAND"] = {"morph #NPC_DISPLAYID", "mod native #NPC_DISPLAYID", "mod mount #NPC_DISPLAYID"},
        ["TOOLTIP_TEXT"] = {},
    },
    ["CREATURE_DISPLAYID"] = {
        ["PATTERN"] = {"%[|cff00CCFF(%d*)|r.*%.m2", "CREATURE_DISPLAYID:(%d*)"},
        ["RETURNS"] = {"[Morph]", "[Native]", "[Mount]"},
        ["COMMAND"] = {"morph #CREATURE_DISPLAYID", "mod native #CREATURE_DISPLAYID", "mod mount #CREATURE_DISPLAYID"},
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
}