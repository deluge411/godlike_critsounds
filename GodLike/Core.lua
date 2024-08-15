Godlike = LibStub("AceAddon-3.0"):NewAddon("Godlike Critsounds", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local THIS_VERSION = C_AddOns.GetAddOnMetadata("Godlike", "Version")
--Define CRIT0 to CRIT4 and HEAL0 to HEAL4 as global variables
CRIT0 = 0;
CRIT1 = 0;
CRIT2 = 0;
CRIT3 = 0;
CRIT4 = 0;

HEAL0 = 0;
HEAL1 = 0;
HEAL2 = 0;
HEAL3 = 0;
HEAL4 = 0;


local defaults = {
	profile = {
		--Godlike Defaults Start
		isEnabled = true,
		isSoundEnabled = true,
		isMessageEnabled = true,
		IsAuto = true,
		AutoSetFactor = 90,
		MaxCrit = 10,
		MaxHeal = 10,
		Spell = "all",
		Soundpack = "english",
		SetRange = 55,
		Setlevel = 70,
		CritMsg1 = "|c00FFC800ULTRA KILL!",
		CritMsg2 = "|c00FFC800MOMOMONSTER KILL!",
		CritMsg3 = "|c00FFC800GODLIKE!",
		CritMsg4 = "|c00FFC800Holy Shit! That hurts!",
		MsgHeal1 = "|c00FFC800YEAH!",
		MsgHeal2 = "|c00FFC800OhYEAH!",
		MsgHeal3 = "|c00FFC800Halleluja",
		MsgHeal4 = "|c00FFC800Halleluja!!! Halleluja!!!",
		--Godlike Defaults End
		message = "Welcome Home!",
		showOnScreen = true,
	},
}

local options = {
	name = "Godlike Settings "..THIS_VERSION,
	handler = Godlike,
	type = "group",
	args = {
		isEnabled = {
			type = "toggle",
			order = 1,
			width = "full",
			name = GL_TEXT_OPT_VAR_GLENABLED,
			desc = GL_TEXT_OPT_TOOL_GLENABLED,
			get = "GetIsEnabled",
			set = "SetIsEnabled"
		},
		isSoundEnabled = {
			type = "toggle",
			order = 2,
			width = "full",
			name = GL_TEXT_OPT_VAR_SNDENABLED,
			desc = GL_TEXT_OPT_TOOL_SNDENABLED,
			get = "GetIsSoundEnabled",
			set = "SetIsSoundEnabled"
		},
		isMessageEnabled = {
			type = "toggle",
			order = 3,
			width = "full",
			name = GL_TEXT_OPT_VAR_MSGENABLED,
			desc = GL_TEXT_OPT_TOOL_MSGENABLED,
			get = "GetIsMessageEnabled",
			set = "SetIsMessageEnabled"
		},
		header = {
			type = "header",
			order = 4,
			width = "double",
			name = GL_TEXT_OPT_LABEL_MAXCRIT,
		},
		isAuto = {
			type = "toggle",
			order = 5,
			width = "double",
			name = GL_TEXT_OPT_AUTO,
			desc = GL_TEXT_OPT_AUTOHELP,
			get = "GetIsAuto",
			set = "SetIsAuto",
		},
		AutoSetFactor = {
			type = "range",
			order = 6,
			name = GL_TEXT_OPT_SETAUTO .." % Auto Critical Value",
			desc = GL_TEXT_OPT_SETAUTOHELP,
			width = 1.3,
			get = "GetAutoSetFactor",
			set = "SetAutoSetFactor",
			min = 80, max = 100, step = 1,
		},
		MaxCrit = {
			type = "input",
			order = 7,
			width = "double",
			name = GL_TEXT_OPT_MAXCRIT,
			desc = GL_TEXT_OPT_MAXCRITHELP,
			usage = "102340",
			get = "GetMaxCrit",
			set = "SetMaxCrit",
		},
		MaxHeal = {
			type = "input",
			order = 9,
			width = "double",
			name = GL_TEXT_OPT_MAXHEAL,
			desc = GL_TEXT_OPT_MAXHEALHELP,
			usage = "42100",
			get = "GetMaxHeal",
			set = "SetMaxHeal",
		},
		SetRange = {
			type = "range",
			order = 10,
			name = GL_TEXT_OPT_SETRANGE .." Percentage",
			desc = GL_TEXT_OPT_SETRANGEHELP,
			width = 1.9,
			get = "GetSetRange",
			set = "SetSetRange",
			min = 50, max = 99, step = 1,
		},
		header2 = {
			type = "header",
			order = 11,
			width = "double",
			name = GL_TEXT_OPT_LABEL_SPELL,
		},
		Spell = {
			type = "input",
			order = 12,
			width = "double",
			name = GL_TEXT_OPT_SPELLONLY,
			desc = GL_TEXT_OPT_SPELLONLYHELP,
			usage = "Aimed Shot",
			get = "GetSpell",
			set = "SetSpell",
		},
		header3 = {
			type = "header",
			order = 13,
			width = "double",
			name = 	GL_TEXT_OPT_LABEL_OTHER,
		},
		Soundpack = {
			type = "input",
			order = 14,
			width = "double",
			name = GL_TEXT_OPT_PACK,
			desc = GL_TEXT_OPT_PACKHELP,
			usage = "english, or german or bartsimpson",
			get = "GetSoundpack",
			set = "SetSoundpack",
		},
		Setlevel = {
			type = "input",
			order = 15,
			width = "double",
			name = GL_TEXT_OPT_SETLEVEL,
			desc = GL_TEXT_OPT_SETLEVELHELP,
			usage = "0 for all levels or 70 for level 70 and above",
			get = "GetSetlevel",
			set = "SetSetlevel",
		},
		header4 = {
			type = "header",
			order = 16,
			width = "double",
			name = 	"Write all changes to file made in this panel",
		},
		SetButton = {
			type = "execute",
			order = 17,
			name = "Save and Reload Interface",
			width = 2.0,
			func = function()
				Godlike:RefreshUI();
			end,
		},
	},
}

local options2 = {
	name = "Godlike Chat-Messages",
	handler = Godlike,
	type = "group",
	args = {
		header4 = {
			type = "header",
			order = 1,
			width = "double",
			name = 	GL_TEXT_OPT2_LABEL_CRITMSG,
		},
		CritMsg1 = {
			type = "input",
			width = "full",
			order = 2,
			name = "Critical Damage Message 1:",
			desc = "First critical message.",
			usage = "<Your message>",
			get = "GetCritMsg1",
			set = "SetCritMsg1",
		},
		CritMsg2 = {
			type = "input",
			width = "full",
			order = 3,
			name = "Critical Damage Message 2:",
			desc = "Second critical message.",
			usage = "<Your message>",
			get = "GetCritMsg2",
			set = "SetCritMsg2",
		},
		CritMsg3 = {
			type = "input",
			width = "full",
			order = 4,
			name = "Critical Damage Message 3:",
			desc = "Third critical message.",
			usage = "<Your message>",
			get = "GetCritMsg3",
			set = "SetCritMsg3",
		},
		CritMsg4 = {
			type = "input",
			width = "full",
			order = 5,
			name = "Critical Damage Message 4:",
			desc = "Fourth critical message.",
			usage = "<Your message>",
			get = "GetCritMsg4",
			set = "SetCritMsg4",
		},
		header5 = {
			type = "header",
			order = 6,
			width = "double",
			name = 	GL_TEXT_OPT2_LABEL_HEALMSG,
		},
		MsgHeal1 = {
			type = "input",
			width = "full",
			order = 7,
			name = "Critical Heal Message 1:",
			desc = "First Heal critical message.",
			usage = "<Your message>",
			get = "GetMsgHeal1",
			set = "SetMsgHeal1",
		},
		MsgHeal2 = {
			type = "input",
			width = "full",
			order = 8,
			name = "Critical Heal Message 2:",
			desc = "Second Heal critical message.",
			usage = "<Your message>",
			get = "GetMsgHeal2",
			set = "SetMsgHeal2",
		},
		MsgHeal3 = {
			type = "input",
			width = "full",
			order = 9,
			name = "Critical Heal Message 3:",
			desc = "Third Heal critical message.",
			usage = "<Your message>",
			get = "GetMsgHeal3",
			set = "SetMsgHeal3",
		},
		MsgHeal4 = {
			type = "input",
			width = "full",
			order = 10,
			name = "Critical Heal Message 4:",
			desc = "Fourth Heal critical message.",
			usage = "<Your message>",
			get = "GetMsgHeal4",
			set = "SetMsgHeal4",
		},
		--[[ header6 = {
			type = "header",
			order = 16,
			width = "double",
			name = 	"Update all changes made in this panel",
		},
		SetButton = {
			type = "execute",
			order = 17,
			name = "Save All Changes",
			width = 2.0,
			func = function()
				Godlike:RefreshUI();
			end,
		}, ]]
	},
}

function Godlike:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("GodlikeDB", defaults, true)
	AC:RegisterOptionsTable("Godlike_options", options)
	self.optionsFrame, self.mainFrameId = ACD:AddToBlizOptions("Godlike_options", "Godlike")
	_G["MainFrame"] = self.optionsFrame;

    AC:RegisterOptionsTable("Godlike_chatmessages", options2)
    ACD:AddToBlizOptions("Godlike_chatmessages", "Chat-Messages", "Godlike")

	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	AC:RegisterOptionsTable("Godlike_Profiles", profiles)
	ACD:AddToBlizOptions("Godlike_Profiles", "Profiles", "Godlike")

	self:RegisterChatCommand("gl", "SlashCommand")
	self:RegisterChatCommand("godlike", "SlashCommand")

	GodLike_SetCrits();
	GodLike_SetHeals();
	GodLike_SetPack();
	GodLike_SetMsg();

	-- Ensure AceGUI-3.0 is loaded in your addon



end

function Godlike:OnEnable()
    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "OnCombatLogEventUnfiltered")
	DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_WELCOME00)
    DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_WELCOME01)
end

function Godlike:SlashCommand(msg)
	if not msg or msg:trim() == "" then
		-- https://github.com/Stanzilla/WoWUIBugs/issues/89
		Settings.OpenToCategory(self.mainFrameId)
	else
		self:Print("hello there!")
	end
end

function Godlike:GetMessage(info)
	return self.db.profile.message
end

function Godlike:SetMessage(info, value)
	self.db.profile.message = value
end

function Godlike:GetChat(info)
	return self.db.profile.message
end

function Godlike:SetChat(info, value)
	self.db.profile.message = value
end
--Godlike get/set functions
function Godlike:GetIsEnabled(info)
	return self.db.profile.isEnabled
end

function Godlike:SetIsEnabled(info, value)
	self.db.profile.isEnabled = value
end

function Godlike:GetIsSoundEnabled(info)
	return self.db.profile.isSoundEnabled
end
function Godlike:SetIsSoundEnabled(info, value)
	self.db.profile.isSoundEnabled = value
end

function Godlike:GetIsMessageEnabled(info)
	return self.db.profile.isMessageEnabled
end
function Godlike:SetIsMessageEnabled(info, value)
	self.db.profile.isMessageEnabled = value
end

function Godlike:GetIsAuto(info)
	return self.db.profile.IsAuto
end
function Godlike:SetIsAuto(info, value)
	self.db.profile.IsAuto = value
end

function Godlike:GetAutoSetFactor(info)
	return self.db.profile.AutoSetFactor
end
function Godlike:SetAutoSetFactor(info, value)
	self.db.profile.AutoSetFactor = value
end

function Godlike:GetMaxCrit(info)
	return tostring(self.db.profile.MaxCrit);
end
function Godlike:SetMaxCrit(info, value)
	if (value == nil) then
		value = 10;
		print("ERROR writting the correct MaxCrit DAMAGE, report this error and what you did please");
	end
	self.db.profile.MaxCrit = tonumber(value)
	GodLike_SetCrits();
end

function Godlike:GetMaxHeal(info)
	return tostring(self.db.profile.MaxHeal)
end
function Godlike:SetMaxHeal(info, value)
	if (value == nil) then
		value = 10;
		print("ERROR writting the correct MaxCrit HEAL, report this error and what you did please");
	end
	self.db.profile.MaxHeal = tonumber(value)
	GodLike_SetHeals();
end

function Godlike:GetSpell(info)
	return self.db.profile.Spell
end
function Godlike:SetSpell(info, value)
	self.db.profile.Spell = value
end

function Godlike:GetSoundpack(info)
	return self.db.profile.Soundpack
end
function Godlike:SetSoundpack(info, value)
	self.db.profile.Soundpack = value
end

function Godlike:GetSetRange(info)
	return self.db.profile.SetRange
end
function Godlike:SetSetRange(info, value)
	self.db.profile.SetRange = value
end

function Godlike:GetSetlevel(info)
	return tostring(self.db.profile.Setlevel)
end
function Godlike:SetSetlevel(info, value)
	if (value == nil) then
		value = 70;
		print("ERROR writting the correct SET LEVEL, report this error and what you did please");
	end
	self.db.profile.Setlevel = tonumber(value)
end

function Godlike:GetCritMsg1(info)
	return self.db.profile.CritMsg1
end
function Godlike:SetCritMsg1(info, value)
	self.db.profile.CritMsg1 = "|c00FFC800"..value
end

function Godlike:GetCritMsg2(info)
	return self.db.profile.CritMsg2
end
function Godlike:SetCritMsg2(info, value)
	self.db.profile.CritMsg2 = "|c00FFC800"..value
end

function Godlike:GetCritMsg3(info)
	return self.db.profile.CritMsg3
end
function Godlike:SetCritMsg3(info, value)
	self.db.profile.CritMsg3 = "|c00FFC800"..value
end

function Godlike:GetCritMsg4(info)
	return self.db.profile.CritMsg4
end
function Godlike:SetCritMsg4(info, value)
	self.db.profile.CritMsg4 = "|c00FFC800"..value
end

function Godlike:GetMsgHeal1(info)
	return self.db.profile.MsgHeal1
end
function Godlike:SetMsgHeal1(info, value)
	self.db.profile.MsgHeal1 = "|c00FFC800"..value
end

function Godlike:GetMsgHeal2(info)
	return self.db.profile.MsgHeal2
end
function Godlike:SetMsgHeal2(info, value)
	self.db.profile.MsgHeal2 = "|c00FFC800"..value
end

function Godlike:GetMsgHeal3(info)
	return self.db.profile.MsgHeal3
end
function Godlike:SetMsgHeal3(info, value)
	self.db.profile.MsgHeal3 = "|c00FFC800"..value
end

function Godlike:GetMsgHeal4(info)
	return self.db.profile.MsgHeal4
end
function Godlike:SetMsgHeal4(info, value)
	self.db.profile.MsgHeal4 = "|c00FFC800"..value
end

-- Functions that manage the addon ----------------------------------------------------------
--This function sets the 5 crits we use in the addon based on the maxcrit value
function GodLike_SetCrits()
		local maxCritVar = tonumber(Godlike:GetMaxCrit());
		if (maxCritVar == nil or maxCritVar == "nil") then
			Godlike:SetMaxCrit(nil,10);
			maxCritVar = tonumber(Godlike:GetMaxCrit());
		end
		local setRangeVar = Godlike:GetSetRange();
		if (setRangeVar == nil) then
			Godlike:SetSetRange(nil, 55);
			setRangeVar = Godlike:GetSetRange();
		end
		local factor = (100 - setRangeVar)/300
		CRIT4 = maxCritVar;
		CRIT3 = maxCritVar * (1 - factor);
		CRIT2 = maxCritVar * (1 - 2*factor);
		CRIT1 = maxCritVar * (1 - 3*factor);
		CRIT0 = maxCritVar * 0.05;
		--print("Crits set to: "..CRIT4..", "..CRIT3..", "..CRIT2..", "..CRIT1..", "..CRIT0);
end
--This function sets the 5 crits we use in the addon based on the maxheal value
function GodLike_SetHeals()
		local maxHealVar = tonumber(Godlike:GetMaxHeal());
		if (maxHealVar == nil) then
			Godlike:SetMaxHeal(nil,10);
			maxHealVar = tonumber(Godlike:GetMaxHeal());
		end
		local setRangeVar = Godlike:GetSetRange();
		if (setRangeVar == nil) then
			Godlike:SetSetRange(nil,55);
			setRangeVar = Godlike:GetSetRange();
		end
		
		local factor = (100 - setRangeVar)/300
		HEAL4 = Godlike:GetMaxHeal();
		HEAL3 = Godlike:GetMaxHeal() * (1 - factor);
		HEAL2 = Godlike:GetMaxHeal() * (1 - 2*factor);
		HEAL1 = Godlike:GetMaxHeal() * (1 - 3*factor);
		HEAL0 = Godlike:GetMaxHeal() * 0.05;
		--print("Heals set to: "..HEAL4..", "..HEAL3..", "..HEAL2..", "..HEAL1..", "..HEAL0);
end
--Set the soundpack to the one selected in the options
function GodLike_SetPack()
	local soundPackVar = Godlike:GetSoundpack();
	if (not soundPackVar) or (soundPackVar == "")then
		Godlike:SetSoundpack(GL_LANG);
		soundPackVar = Godlike:GetSoundpack();
	end

    -- Sounds
	GL_SND_CRIT1		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\crit1.mp3";
	GL_SND_CRIT2		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\crit2.mp3";
	GL_SND_CRIT3		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\crit3.mp3";
	GL_SND_CRIT4		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\crit4.mp3";
	GL_SND_HEAL1		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\heal1.mp3";
	GL_SND_HEAL2		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\heal2.mp3";
	GL_SND_HEAL3		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\heal3.mp3";
	GL_SND_HEAL4		=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\heal4.mp3";
	--GL_SND_LOW			=	"Interface\\AddOns\\GodLike\\Sounds\\"..soundPackVar.."\\low.mp3";
end

function GodLike_SetMsg()
	local msgCritVar1 = Godlike:GetCritMsg1();
	local msgCritVar2 = Godlike:GetCritMsg2();
	local msgCritVar3 = Godlike:GetCritMsg3();
	local msgCritVar4 = Godlike:GetCritMsg4();

	local msgHealVar1 = Godlike:GetMsgHeal1();
	local msgHealVar2 = Godlike:GetMsgHeal2();
	local msgHealVar3 = Godlike:GetMsgHeal3();
	local msgHealVar4 = Godlike:GetMsgHeal4();
    --Damage criticals messages go here
	if (not msgCritVar1) or (msgCritVar1 == "")then
		Godlike:SetCritMsg1(nil, GL_MSG_CRIT1);
		msgCritVar1 = Godlike:GetCritMsg1();
	end
	if (not msgCritVar2) or (msgCritVar2 == "")then
		Godlike:SetCritMsg2(nil, GL_MSG_CRIT2);
		msgCritVar2 = Godlike:GetCritMsg2();
	end
	if (not msgCritVar3) or (msgCritVar3 == "")then
		Godlike:SetCritMsg3(nil, GL_MSG_CRIT3);
		msgCritVar3 = Godlike:GetCritMsg3();
	end
	if (not msgCritVar4) or (msgCritVar4 == "")then
		Godlike:SetCritMsg4(nil, GL_MSG_CRIT4);
		msgCritVar4 = Godlike:GetCritMsg4();
	end
	--Heal criticals messages go here
	if (not msgHealVar1) or (msgHealVar1 == "")then
		Godlike:SetMsgHeal1(nil, GL_MSG_HEAL1);
		msgHealVar1 = Godlike:GetMsgHeal1();
	end
	if (not msgHealVar2) or (msgHealVar2 == "")then
		Godlike:SetMsgHeal2(nil, GL_MSG_HEAL2);
		msgHealVar2 = Godlike:GetMsgHeal2();
	end
	if (not msgHealVar3) or (msgHealVar3 == "")then
		Godlike:SetMsgHeal3(nil, GL_MSG_HEAL3);
		msgHealVar3 = Godlike:GetMsgHeal3();
	end
	if (not msgHealVar4) or (msgHealVar4 == "")then
		Godlike:SetMsgHeal4(nil, GL_MSG_HEAL4);
		msgHealVar4 = Godlike:GetMsgHeal4();
	end
	--print all messages
	--print("Crit Messages set to: "..msgCritVar1..", "..msgCritVar2..", "..msgCritVar3..", "..msgCritVar4);
	--print("Heal Messages set to: "..msgHealVar1..", "..msgHealVar2..", "..msgHealVar3..", "..msgHealVar4);
end

function Godlike:RefreshUI()
    ReloadUI();
end



--End of Godlike get/set functions