addonName, GLink = ...;

GLink.colour = "|cff00CCFF";
GLink.altColour = "|cffADFFFF";
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
    },
    ["item"] = {
        ["PATTERN"] = {"item:(%d*)"},
        ["RETURNS"] = {"[Add]"},
        ["COMMAND"] = {"additem #item"},
    },
    ["creature_entry"] = {
        ["PATTERN"] = {"creature_entry:(%d*)"},
        ["RETURNS"] = {"[Spawn]"},
        ["COMMAND"] = {"npc spawn #creature_entry"},
    },
    ["lookup next"] = {
        ["PATTERN"] = {"Enter .lookup next to view the next (%d*) results"},
        ["RETURNS"] = {"[Next]"},
        ["COMMAND"] = {"lookup next"},
    },
    ["gameobject_GUID"] = {
        --["PATTERN"] = {"Selected gameobject "..GLink.colour.."%[.*%]|r %(GUID: "..GLink.colour.."(%d*)|r%)", "GUID:(%d*)"},
        ["PATTERN"] = {"%(GUID: |cff00CCFF(%d*)|r%)", "gameobject_GUID:(%d*)"},
        ["RETURNS"] = {"[Select]", "[Go]", "[Delete]"},
        ["COMMAND"] = {"gobject select #gameobject_GUID", "gobject go #gameobject_GUID", "gobject delete #gameobject_GUID"},
    },
    ["NPC_GUID"] = {
        --["PATTERN"] = {"Selected gameobject "..GLink.colour.."%[.*%]|r %(GUID: "..GLink.colour.."(%d*)|r%)", "GUID:(%d*)"},
        ["PATTERN"] = {"%Selected NPC: GUID: |cff00CCFF(%d*)|r,", "NPC_GUID:(%d*)"},
        ["RETURNS"] = {"[Go]", "[Delete]"},
        ["COMMAND"] = {"npc go #NPC_GUID", "npc delete #NPC_GUID"},
    },
    ["NPC_DISPLAYID"] = {
        --["PATTERN"] = {"Selected gameobject "..GLink.colour.."%[.*%]|r %(GUID: "..GLink.colour.."(%d*)|r%)", "GUID:(%d*)"},
        ["PATTERN"] = {", DisplayID: |cff00CCFF(%d*)|r,", "NPC_DISPLAYID:(%d*)"},
        ["RETURNS"] = {"[Morph]", "[Native]", "[Mount]"},
        ["COMMAND"] = {"morph #NPC_DISPLAYID", "mod native #NPC_DISPLAYID", "mod mount"},
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