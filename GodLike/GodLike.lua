--------------------------------------------------------------------------------
-- Local -----------------------------------------------------------------------

local THIS_VERSION = GetAddOnMetadata("GodLike", "Version")
local OptionsPanel

loaded = IsAddOnLoaded("sct")

GodLike = {};
GodLike.DefaultSettings = {
	isEnabled = true;
	isSoundEnabled = true;
	isMessageEnabled = true;
	isSctEnabled = false;
	isPlayLow = true;
	isAuto = false;
	AutoSetFactor = 90;
	SetRange = 75;
};

--------------------------------------------------------------------------------
-- OnLoad ----------------------------------------------------------------------

function GodLike_OnLoad(self)
	-- DEFAULT_CHAT_FRAME:AddMessage("Addon NOT LOADED!!");
	_G[self:GetName()]:RegisterEvent("VARIABLES_LOADED");
	_G[self:GetName()]:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

	SlashCmdList["GLOptions"]= GodLike_SlashCommand;  
	SLASH_GLOptions1="/godlike";  
	SLASH_GLOptions2="/gl";
end	

--------------------------------------------------------------------------------
-- OnEvent ---------------------------------------------------------------------

function GodLike_OnEvent(self, event, ...)  
	if (event == "VARIABLES_LOADED") then
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_WELCOME00);  
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_WELCOME01);

		if (not GodLike_Settings) then
			GodLike_Settings = GodLike.DefaultSettings;
		end
		if (not GodLike_Settings.AutoSetFactor) then
			GodLike_Settings.AutoSetFactor = 90;
		end
		if (not GodLike_Settings.SetRange) then
			GodLike_Settings.SetRange = 75;
		end

		GodLike_SetCrits();
		GodLike_SetHeal();
		GodLike_SetSpell();
		GodLike_SetPack();
		GodLike_SetMsg();

        GodLike_SetOptionsPanel();

	end
	-- Abort if godlike is not enabled
	if (not GodLike_Settings.isEnabled) then return; end

	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18 = ...
		if ( arg5 == UnitName("player") ) then
			--local ph = " _ ";
			--DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 A2-"..arg2.." A3-"..arg3.." A4-"..arg4.." A5-"..arg5.." A6-"..arg6.." A7-"..arg7.." A8-"..arg8.." A9-"..arg9.." A10-"..arg10)
			--DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL..(arg2 or NO2)..ph..(arg3 or NO3)..ph..(arg4 or NO4)..ph..(arg5 or NO5)..ph..(arg6 or NO6)..ph..(arg7 or NO7)..ph..(arg8 or NO8)..ph..(arg9 or NO9)..ph..(arg10 or NO10))
		end
		-- arg1  = time of event 
		-- arg2  = name of type of effect
		-- arg3  = ERROR
		-- arg4  = player ID
		-- arg5  = player name
		-- arg6  = played or action
		-- arg7  = always 0
		-- arg8  = creature ID
		-- arg9  = target name
		-- arg10 = Guid for player name
		-- arg11 = cambian de 0 cuando es curacion
		-- arg12 = spell ID
		-- arg13 = DAMAGE
		-- arg14 = 14.1
		-- arg15 = debuff or buff
		-- arg16 = damage number
		-- arg17 = spell school  (holy 2)
		--print("ARG13: " .. arg13);
		--print("ARG16: " .. arg16);
		--print(SpellName);
		--loaded = IsAddOnLoaded("sct")
		--print(loaded)
		if (arg5 ~= nil and arg5 == UnitName("player") ) then
			--DEFAULT_CHAT_FRAME:AddMessage("|c00FFC800 Arg5:  "..arg5);
			--DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFFFF UNIT: "..UnitName("player"));
		end
		if (arg16 ~= nil and arg16 ~= boolean) then
			--DEFAULT_CHAT_FRAME:AddMessage(" |cFFFFFFFF Arg16: "..arg16);
		end
		if (arg2 ~= nil ) then
			--DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFFFF Arg2: "..arg2.." |cFFFFFFFF Arg13: "..arg13);
		end
		--DEFAULT_CHAT_FRAME:AddMessage("|c00FFC800 Arg12: "..arg12.." |cFFFFFFFF Arg6: "..arg6);
		if (arg2 == "SWING_DAMAGE" ) then
			if ( arg5 ~= nil and arg5 == UnitName("player") ) then
				if (arg13 ~= nil) then
					if GodLike_Settings.Spell == "all" or GodLike_Settings.Spell == "melee" then
						SpellDmg = arg13;
						SpellName = arg12;
						
						GodLike_CritDone();
					end
				end
			end
		elseif (arg2 == "SPELL_DAMAGE" ) then
			if ( arg5 ~= nil and arg5 == UnitName("player") ) then
				if (arg16 ~= nil) then
					if GodLike_Settings.Spell == "all" then
						SpellDmg = arg16;
						SpellName = arg13;
						GodLike_CritDone();
					end
				end
			end
		elseif (arg2 == "RANGE_DAMAGE" ) then
			if ( arg5 ~= nil and arg5 == UnitName("player") ) then
				if (arg16 ~= nil) then
					if GodLike_Settings.Spell == "all" then
						SpellDmg = arg16;
						SpellName = arg13;
						GodLike_CritDone();
					end
				end
			end
		elseif (arg2 == "SPELL_HEAL" ) then
			if ( arg5 ~= nil and arg5 == UnitName("player") ) then
				if (arg16 ~= nil) then
					if GodLike_Settings.Spell == "all" then
						SpellDmg = arg16;
						SpellName = arg13;
						GodLike_HealCritDone();
					end
				end
			end
		end
	end
end




--------------------------------------------------------------------------------
-- Functions -------------------------------------------------------------------
--------------------------------------------------------------------------------

-- SlashCommands----------------------------------------------------------------

function GodLike_SlashCommand (msg)
	msg = string.lower(msg);  
	if msg and string.find(msg, "maxcrit%s(.+)") then
		local _, _, crit = string.find(msg, "maxcrit%s(.+)")
		if (tonumber(crit) == nil) then
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NOMAXCRIT);
		else
			GodLike_Settings.MaxCrit = crit;
		end
        GodLike_Settings.isAuto = false;
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWMAXCRIT.."|c00FF0000Damage: "..GodLike_Settings.MaxCrit);
        GodLike_SetCrits();

	elseif msg and string.find(msg, "maxheal%s(.+)") then
		local _, _, heal = string.find(msg, "maxheal%s(.+)")
		if (tonumber(heal) == nil) then
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NOMAXCRIT);
		else
			GodLike_Settings.MaxHeal = heal;
		end
        GodLike_Settings.isAuto = false;
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWMAXCRIT.."|c0000FF00Heal: "..GodLike_Settings.MaxHeal);
        GodLike_SetHeal();

   	elseif msg and string.find(msg, "spell%s(.+)") then
		local _, _, spellname = string.find(msg, "spell%s(.+)")
		if spellname == nil then
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NOSPELL);
		else
			GodLike_Settings.Spell = spellname;
		end
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWSPELL.."|c0000FF00 "..string.upper(GodLike_Settings.Spell));


	elseif (msg == "maxcrit") then
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NOMAXCRIT);
	elseif (msg == "maxheal") then
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NOMAXCRIT);
	elseif (msg == "help") then
--		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND0A);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND00);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND01);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND02);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND03);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND04);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND09);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND05);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND06);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND07);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND08);
--		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_SLASHCOMMAND0B);
	elseif (msg == "status") then
		local isEnabled 			=	GodLike_Settings.isEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		local isSoundEnabled 		=	GodLike_Settings.isSoundEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		local isMessageEnabled		=	GodLike_Settings.isMessageEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		local isSctEnabled			=	GodLike_Settings.isSctEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		local isPlayLow				=	GodLike_Settings.isPlayLow and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		local isAuto				=	GodLike_isAuto and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
--		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS0A);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS00 ..isEnabled);
  		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS01 ..isSoundEnabled);
        DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS02 ..isMessageEnabled);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS03 ..isSctEnabled);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS09 ..isPlayLow);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS04 ..isAuto);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS05 .."|c00FF0000"..GodLike_Settings.MaxCrit);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS06 .."|c0000FF00"..GodLike_Settings.MaxHeal);
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS07 .."|c0000FF00"..GodLike_Settings.Spell);
--		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS0B);

	elseif (msg == "auto off") then
		GodLike_Settings.isAuto = false;
		local isAuto		=	GodLike_Settings.isAuto and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
        DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_AUTO..isAuto);
	elseif (msg == "auto on") then
		GodLike_Settings.isAuto = true;
		local isAuto		=	GodLike_Settings.isAuto and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
        DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_AUTO..isAuto);

	elseif (msg == "mod off") or (msg == "off") then
		GodLike_Settings.isEnabled = false;
		local isEnabled 			=	GodLike_Settings.isEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS00 ..isEnabled);
	elseif (msg == "mod on") or (msg == "on") then
		GodLike_Settings.isEnabled = true;
		local isEnabled 			=	GodLike_Settings.isEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS00 ..isEnabled);
	elseif (msg == "msg off") then
		GodLike_Settings.isMessageEnabled = false;
		local isMessageEnabled		=	GodLike_Settings.isMessageEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
        DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS02 ..isMessageEnabled);
	elseif (msg == "msg on") then
		GodLike_Settings.isMessageEnabled = true;
		local isMessageEnabled		=	GodLike_Settings.isMessageEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
        DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS02 ..isMessageEnabled);
	elseif (msg == "snd off") then
		GodLike_Settings.isSoundEnabled = false;
		local isSoundEnabled 		=	GodLike_Settings.isSoundEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
  		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS01 ..isSoundEnabled);
	elseif (msg == "snd on") then
		GodLike_Settings.isSoundEnabled = true;
		local isSoundEnabled 		=	GodLike_Settings.isSoundEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
  		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS01 ..isSoundEnabled);
	elseif (msg == "sct off") then
		GodLike_Settings.isSctEnabled = false;
		local isSctEnabled			=	GodLike_Settings.isSctEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS03 ..isSctEnabled);
	elseif (msg == "sct on") then
		GodLike_Settings.isSctEnabled = true;
		local isSctEnabled			=	GodLike_Settings.isSctEnabled and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS03 ..isSctEnabled);
	elseif (msg == "low off") then
		GodLike_Settings.isPlayLow = false;
		local isPlayLow			=	GodLike_Settings.isPlayLow and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS09 ..isPlayLow);
	elseif (msg == "low on") then
		GodLike_Settings.isPlayLow = true;
		local isPlayLow			=	GodLike_Settings.isPlayLow and "|c0000FF00[enabled]" or "|c00ff0000[disabled]";
		DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_MODSTATUS09 ..isPlayLow);
	else
        InterfaceOptionsFrame_OpenToCategory("GodLike!")
	end
    CheckboxTextUpdate();
end



-- Settings --------------------------------------------------------------------

function GodLike_SetCrits()
--	GodLike_Settings.MaxCrit = GodLike_SpellLabelMaxCrit:GetText();

	if (tonumber(GodLike_Settings.MaxCrit) == nil) then
		GodLike_Settings.MaxCrit = 10;
	end
	if (tonumber(GodLike_Settings.SetRange) == nil) then
		GodLike_Settings.SetRange = 55;
	end

	local factor = (100 - GodLike_Settings.SetRange)/300

	CRIT4 = GodLike_Settings.MaxCrit;
	CRIT3 = GodLike_Settings.MaxCrit * (1 - factor);
	CRIT2 = GodLike_Settings.MaxCrit * (1 - 2*factor);
	CRIT1 = GodLike_Settings.MaxCrit * (1 - 3*factor);
	CRIT0 = GodLike_Settings.MaxCrit * 0.05;
end

function GodLike_SetHeal()
	if (tonumber(GodLike_Settings.MaxHeal) == nil) then
		GodLike_Settings.MaxHeal = 15;
	end

	local factor = (100 - GodLike_Settings.SetRange)/300

	HEAL4 = GodLike_Settings.MaxHeal;
	HEAL3 = GodLike_Settings.MaxHeal * (1 - factor);
	HEAL2 = GodLike_Settings.MaxHeal * (1 - 2*factor);
	HEAL1 = GodLike_Settings.MaxHeal * (1 - 3*factor);
	HEAL0 = GodLike_Settings.MaxHeal * 0.05;

--	DEFAULT_CHAT_FRAME:AddMessage(HEAL4);
--	DEFAULT_CHAT_FRAME:AddMessage(HEAL3);
--	DEFAULT_CHAT_FRAME:AddMessage(HEAL2);
--	DEFAULT_CHAT_FRAME:AddMessage(HEAL1);
--	DEFAULT_CHAT_FRAME:AddMessage(HEAL0);
end

function GodLike_SetSpell()
	if GodLike_Settings.Spell == nil or GodLike_Settings.Spell == "" or GodLike_Settings.Spell == "all" or GodLike_Settings.Spell == "ALL" then
		GodLike_Settings.Spell = "all";
	elseif GodLike_Settings.Spell == "melee" or GodLike_Settings.Spell == "MELEE" then
		GodLike_Settings.Spell = "melee";
	else	
	    GodLike_Settings.Spell = string.upper(GodLike_Settings.Spell);
	end
end

function GodLike_SetPack()
	if (not GodLike_Settings.Soundpack) or (GodLike_Settings.Soundpack == "")then
		GodLike_Settings.Soundpack = GL_LANG;
	end

    -- Sounds
	GL_SND_CRIT1		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\crit1.mp3";
	GL_SND_CRIT2		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\crit2.mp3";
	GL_SND_CRIT3		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\crit3.mp3";
	GL_SND_CRIT4		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\crit4.mp3";
	GL_SND_HEAL1		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\heal1.mp3";
	GL_SND_HEAL2		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\heal2.mp3";
	GL_SND_HEAL3		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\heal3.mp3";
	GL_SND_HEAL4		=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\heal4.mp3";
	GL_SND_LOW			=	"Interface\\AddOns\\GodLike\\Sounds\\"..GodLike_Settings.Soundpack.."\\low.mp3";
end

function GodLike_SetMsg()
	if (not GodLike_Settings.MsgCrit1) or (GodLike_Settings.MsgCrit1 == "")then
		GodLike_Settings.MsgCrit1 = GL_MSG_CRIT1;
	end
	if (not GodLike_Settings.MsgCrit2) or (GodLike_Settings.MsgCrit2 == "")then
		GodLike_Settings.MsgCrit2 = GL_MSG_CRIT2;
	end
	if (not GodLike_Settings.MsgCrit3) or (GodLike_Settings.MsgCrit3 == "")then
		GodLike_Settings.MsgCrit3 = GL_MSG_CRIT3;
	end
	if (not GodLike_Settings.MsgCrit4) or (GodLike_Settings.MsgCrit4 == "")then
		GodLike_Settings.MsgCrit4 = GL_MSG_CRIT4;
	end
	if (not GodLike_Settings.MsgHeal1) or (GodLike_Settings.MsgHeal1 == "")then
		GodLike_Settings.MsgHeal1 = GL_MSG_HEAL1;
	end
	if (not GodLike_Settings.MsgHeal2) or (GodLike_Settings.MsgHeal2 == "")then
		GodLike_Settings.MsgHeal2 = GL_MSG_HEAL2;
	end
	if (not GodLike_Settings.MsgHeal3) or (GodLike_Settings.MsgHeal3 == "")then
		GodLike_Settings.MsgHeal3 = GL_MSG_HEAL3;
	end
	if (not GodLike_Settings.MsgHeal4) or (GodLike_Settings.MsgHeal4 == "")then
		GodLike_Settings.MsgHeal4 = GL_MSG_HEAL4;
	end
	if (not GodLike_Settings.MsgLow) or (GodLike_Settings.MsgLow == "")then
		GodLike_Settings.MsgLow = GL_MSG_LOW;
	end
end

--[[function GodLike_NewMaxCrit(wert)
	if GodLike_Settings.isAuto == true then
	    if (tonumber(wert) * 0.9) > CRIT4 then
			GodLike_Settings.MaxCrit = math.floor(wert * 0.9);
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWTOPCRIT.."|c00FF0000Damage: "..wert..GL_TEXT_NEWAUTOCRIT..GodLike_Settings.MaxCrit..")");
	        GodLike_SetCrits();
		end
	else
	end
end

function GodLike_NewMaxHeal(wert)
	if GodLike_Settings.isAuto == true then
	    if (tonumber(wert) * 0.9) > HEAL4 then
			GodLike_Settings.MaxHeal = math.floor(wert * 0.9);
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_TOPMAXCRIT.."|c0000FF00Heal: "..wert..GL_TEXT_NEWAUTOCRIT..GodLike_Settings.MaxHeal..")");
	        GodLike_SetCrits();
		end
	else
	end
end         --]]



-- CritDone!!! -----------------------------------------------------------------

function GodLike_CritDone()
	--DEFAULT_CHAT_FRAME:AddMessage("CURRENT: "..SpellDmg.." LIMIT: "..CRIT4);
	if tonumber(SpellDmg) > tonumber(CRIT4) then
		msg = GodLike_Settings.MsgCrit4;
		sound = GL_SND_CRIT4;
	elseif tonumber(SpellDmg) > tonumber(CRIT3) then
		msg = GodLike_Settings.MsgCrit3;
		sound = GL_SND_CRIT3;
	elseif tonumber(SpellDmg) > tonumber(CRIT2) then
		msg = GodLike_Settings.MsgCrit2;
		sound = GL_SND_CRIT2;
	elseif tonumber(SpellDmg) > tonumber(CRIT1) then
		msg = GodLike_Settings.MsgCrit1;
		sound = GL_SND_CRIT1;
	
	--elseif tonumber(SpellDmg) < tonumber(CRIT0) and (GodLike_Settings.isPlayLow) then
		--msg = GodLike_Settings.MsgLow;
		--sound = GL_SND_LOW;
	else return
	end
	if (GodLike_Settings.isMessageEnabled == true) then
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL ..msg)
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800"..SpellName.." |c00FF0000 "..SpellDmg)
	end
    if (IsAddOnLoaded("sct")) then
		if (GodLike_Settings.isSctEnabled) then
  			local rgbcolor = {r=0, g=0, b=1};
			SCT:DisplayMessage(msg, rgbcolor);
		end
	end
	if (GodLike_Settings.isSoundEnabled) then
		if sound then PlaySoundFile(sound);
		end
	end
	if GodLike_Settings.isAuto == true then
	    if (tonumber(SpellDmg) * 0.01 * GodLike_Settings.AutoSetFactor) > tonumber(CRIT4) then
			GodLike_Settings.MaxCrit = math.floor(SpellDmg * 0.01 * GodLike_Settings.AutoSetFactor);
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWTOPCRIT.."|c00FF0000Damage: "..SpellDmg..GL_TEXT_NEWAUTOCRIT..GodLike_Settings.MaxCrit..")");
	        GodLike_SetCrits();
		end
	else
	end
end



function GodLike_HealCritDone()
	if tonumber(SpellDmg) > tonumber(HEAL4) then
		msg = GodLike_Settings.MsgHeal4;
		sound = GL_SND_HEAL4;
	elseif tonumber(SpellDmg) > tonumber(HEAL3) then
		msg = GodLike_Settings.MsgHeal3;
		sound = GL_SND_HEAL3;
	elseif tonumber(SpellDmg) > tonumber(HEAL2) then
		msg = GodLike_Settings.MsgHeal2;
		sound = GL_SND_HEAL2;
	elseif tonumber(SpellDmg) > tonumber(HEAL1) then
		msg = GodLike_Settings.MsgHeal1;
		sound = GL_SND_HEAL1;
	--elseif tonumber(SpellDmg) < tonumber(HEAL0) and (GodLike_Settings.isPlayLow) then
--		msg = GodLike_Settings.MsgLow;
		--sound = GL_SND_LOW;
	else return
	end

	if (GodLike_Settings.isMessageEnabled) then
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL ..msg)
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800"..SpellName.." |c0000FF00 "..SpellDmg)
	end

    if (IsAddOnLoaded("sct")) then
		if (GodLike_Settings.isSctEnabled) then
  			local rgbcolor = {r=0, g=0, b=1};
			SCT:DisplayMessage(msg, rgbcolor);
		end
	end

	if (GodLike_Settings.isSoundEnabled) then
		if sound then PlaySoundFile(sound);
		end
	end

	if GodLike_Settings.isAuto == true then
	    if (tonumber(SpellDmg) * 0.01 * GodLike_Settings.AutoSetFactor) > tonumber(HEAL4) then
			GodLike_Settings.MaxHeal = math.floor(SpellDmg * 0.01 * GodLike_Settings.AutoSetFactor);
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWTOPCRIT.."|c0000FF00Heal: "..arg12..GL_TEXT_NEWAUTOCRIT..GodLike_Settings.MaxHeal..")");
	        GodLike_SetHeal();
		end
	else
	end
	
end



-- OptionsPanel ----------------------------------------------------------------
-- thx to Tuhljin for this nice options-lib!!! ---------------------------------

function GodLike_SetOptionsPanel()
	if GodLike_Settings.isAuto then
		isAuto = GL_TEXT_OPT_AUTOON
	else
		isAuto = GL_TEXT_OPT_AUTOOFF
	end
	if GodLike_Settings.Spell == "all" then
		isSpell = GL_TEXT_OPT_ALLSPELL
	else
		isSpell = GL_TEXT_OPT_ONESPELL.."|c00FFAA00"..string.upper(GodLike_Settings.Spell)
	end

    OptionsPanel = TjOptions.CreatePanel("GodLike!", nil, {
	title = "GodLike v"..THIS_VERSION,
	itemspacing = 0,
    column2Offset = 230,
	variables = GodLike_Settings,
	defaults = GodLike.DefaultSettings,
--	scrolling = true,
	items = {
		 { type = "labelnorm", text = GL_TEXT_OPT_LABEL_SETTINGS, topBuffer = 0 },
		 { variable = "isEnabled", text = GL_TEXT_OPT_VAR_GLENABLED, tooltip = GL_TEXT_OPT_TOOL_GLENABLED },
		 { variable = "isSoundEnabled", text = GL_TEXT_OPT_VAR_SNDENABLED, tooltip = GL_TEXT_OPT_TOOL_SNDENABLED, topBuffer = -5 },
		 { variable = "isMessageEnabled", text = GL_TEXT_OPT_VAR_MSGENABLED, tooltip = GL_TEXT_OPT_TOOL_MSGENABLED, topBuffer = -5 },
		 { variable = "isSctEnabled", text = GL_TEXT_OPT_VAR_SCTENABLED, tooltip = GL_TEXT_OPT_TOOL_SCTENABLED, topBuffer = -5 },
		 { variable = "isPlayLow", text = GL_TEXT_OPT_VAR_PLAYLOW, tooltip = GL_TEXT_OPT_TOOL_PLAYLOW, topBuffer = -5 },

		 { type = "labelnorm", text = GL_TEXT_OPT_LABEL_MAXCRIT, topBuffer = 10 },
		 { variable = "isAuto", text = GL_TEXT_OPT_AUTO, OnChange = UpdateAuto, tooltip = GL_TEXT_OPT_TOOL_AUTOHELP },
		 { variable = "AutoSetFactor", name = "GodLike_SetAutoSlider", column = 2, type = "slider", text = GL_TEXT_OPT_SETAUTO, Width=75, min = 80, max = 100, textValue = "%s%%", textLow = "80%", textHigh = "100%",
	  	   tooltipWrap = true, topBuffer = -8, tooltip = GL_TEXT_OPT_SETAUTOHELP },
--		 { variable = "MaxCrit", name = "GodLike_SpellLabelMaxCrit", topBuffer = 3, type = "editbox", textOnLeft=true, textWidth=230, OnTextChanged = GodLike_SetCrits, width = 60, text = GL_TEXT_OPT_MAXCRIT, tooltip = GL_TEXT_OPT_MAXCRITHELP },
		 { variable = "MaxCrit", name = "GodLike_SpellLabelMaxCrit", topBuffer = 3, type = "editbox", textOnLeft=true, textWidth=230, useCommits = true, button = "Set", validateFunc = GodLike_CheckCrit, OnChange = GodLike_SetCrits, width = 60, text = GL_TEXT_OPT_MAXCRIT, tooltip = GL_TEXT_OPT_MAXCRITHELP },
		 { variable = "MaxHeal", name = "GodLike_SpellLabelMaxHeal", topBuffer = -7, type = "editbox", textOnLeft=true, textWidth=230, useCommits = true, button = "Set", validateFunc = GodLike_CheckHeal, OnChange = GodLike_SetHeal, width = 60, text = GL_TEXT_OPT_MAXHEAL, tooltip = GL_TEXT_OPT_MAXHEALHELP },
		 { type = "labelwhite", text = GL_TEXT_OPT_SETRANGE, topBuffer = 0 },
		 { variable = "SetRange", column = 2, type = "slider", text = "", min = 50, max = 99, textValue = "%s%%", textLow = "50%", textHigh = "99%", OnChange = GodLike_SetRange,
	  	   tooltipWrap = true, topBuffer = -12, tooltip = GL_TEXT_OPT_SETRANGEHELP},

		 { type = "labelnorm", xOffset = 0, text = GL_TEXT_OPT_LABEL_SPELL, topBuffer = 20 },
		 { variable = "Spell", type = "editbox", topBuffer = -2, textOnLeft=true, useCommits = true, button = "Set", OnChange = GodLike_SetSpell, text = GL_TEXT_OPT_SPELLONLY, tooltip = GL_TEXT_OPT_SPELLONLYHELP },

		 { type = "labelnorm", xOffset = 0, text = GL_TEXT_OPT_LABEL_PACK, topBuffer = 5 },
		 { variable = "Soundpack", type = "editbox", topBuffer = -2, textOnLeft=true, useCommits = true, button = "Set", OnChange = GodLike_SetPack, text = GL_TEXT_OPT_PACK, tooltip = GL_TEXT_OPT_PACKHELP },

	},
	OnShow = CheckboxTextUpdate,
    });

    OptionsPanel2 = TjOptions.CreatePanel("Chat-Messages", "GodLike!", {
	title = "GodLike v"..THIS_VERSION.." - Chat-Messages",
	itemspacing = 0,
	variables = GodLike_Settings,
	defaults = GodLike.DefaultSettings,
--	scrolling = true,
	items = {
		 { type = "labelnorm", text = GL_TEXT_OPT2_LABEL_CRITMSG, topBuffer = 10 },
		 { variable = "MsgCrit1", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_CRIT1 },
		 { variable = "MsgCrit2", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_CRIT2 },
		 { variable = "MsgCrit3", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_CRIT3 },
		 { variable = "MsgCrit4", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_CRIT4 },
		 { type = "labelnorm", text = GL_TEXT_OPT2_LABEL_HEALMSG, topBuffer = 10 },
		 { variable = "MsgHeal1", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_HEAL1 },
		 { variable = "MsgHeal2", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_HEAL2 },
		 { variable = "MsgHeal3", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_HEAL3 },
		 { variable = "MsgHeal4", type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_HEAL4 },
		 { type = "labelnorm", text = GL_TEXT_OPT2_LABEL_LOWMSG, topBuffer = 10 },
		 --{ variable = "MsgLow",   type = "editbox", textOnLeft=true, width = 250, textWidth=50, OnTextChanged = GodLike_SetMsg, text = GL_TEXT_OPT2_LOW },
	},
	});

end

function GodLike_CheckCrit(self, text)
  local num = tonumber(text)
  if (num) then
    if (num ~= tonumber(GodLike_Settings.MaxCrit)) then
	    return true
	end
  end
end

function GodLike_CheckHeal(self, text)
  local num = tonumber(text)
  if (num) then
    if (num ~= tonumber(GodLike_Settings.MaxHeal)) then
	    return true
	end
  end
end




function GodLike_SetRange()
		GodLike_SetCrits();
		GodLike_SetHeal();
end

local function UpdateAuto(self, key, val)
  if (GodLike_Settings.isAuto == 1) then
    GodLike_SetAutoSlider:Enable()
  else
    GodLike_SetAutoSlider:Disable()
  end
end

local function UpdateAutoBoxes()
--  if (GodLike_Settings.isAuto == false) then
--    GodLike_SpellLabelMaxCrit:Enable();
--    GodLike_SpellLabelMaxHeal:Enable()
--  else
--    GodLike_SpellLabelMaxCrit:Disable();
--    GodLike_SpellLabelMaxHeal:Disable()
--  end
end


function CheckboxTextUpdate()
end