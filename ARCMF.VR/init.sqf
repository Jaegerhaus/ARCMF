enableSaving [false, false];
enableSentences false;

// Environment
if (isServer && {(getNumber (missionConfigFile >> "CfgARCMF" >> "enableRandomEnvironment") == 1 || getNumber (missionConfigFile >> "Header" >> "sandbox") == 1)}) then {
    [] call ARC_fnc_randomEnvironment;
};

// Briefing
#include "briefing.sqf"

// Group IDs
#include "f\setGroupID\f_setGroupIDs.sqf"

// Buddy Team Colours
#include "f\setTeamColours\f_setTeamColours.sqf"

// Fireteam Member Markers
[] call f_fnc_SetLocalFTMemberMarkers;

// Group Markers
[true, true] call ARC_fnc_initTracker;

// ORBAT Notes
#include "f\briefing\f_orbatNotes.sqf"

// Mission Timer/Safe Start
#include "f\safeStart\f_safeStart.sqf"

// Adversarial Mode
if (isNil "ARC_adversarialMode") then {
    ARC_adversarialMode = false;
};

ARC_isSpectating = false;

// Radio Systems Support
#include "f\radios\acre2\acre2_init.sqf"

// Disable random button on Virtual Arsenal to prevent breaking ACRE
[missionNamespace, "arsenalOpened", {
    disableSerialization;
    _display = _this select 0;
    _button = (_display displayCtrl 44150);
    _button ctrlRemoveAllEventHandlers "buttonclick";
    _button ctrlEnable false;
    _button ctrlSetTooltip "Random is disabled because it breaks ACRE";
    _display displayAddEventHandler ["KeyDown", "if ((_this select 1) in [19,29]) then {true}"];
}] call BIS_fnc_addScriptedEventHandler;

// You are free to add/edit/delete anything below this line.