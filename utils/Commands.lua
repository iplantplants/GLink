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
    ["GUID"] = {
        --["PATTERN"] = {"Selected gameobject "..GLink.colour.."%[.*%]|r %(GUID: "..GLink.colour.."(%d*)|r%)", "GUID:(%d*)"},
        ["PATTERN"] = {"%(GUID: |cff00CCFF(%d*)|r%)"},
        ["RETURNS"] = {"[Select]", "[Go]", "[Delete]"},
        ["COMMAND"] = {"gobject select #GUID", "gobject go #GUID", "gobject delete #GUID"},
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