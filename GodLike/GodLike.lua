--define SpellName as a global variable
SpellName_Global = "";

function Godlike:OnCombatLogEventUnfiltered()
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
			destGUID, destName, destFlags, destRaidFlags, 
			spellID, spellName, spellSchool, 
			amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = CombatLogGetCurrentEventInfo()	

    -- Check if the event source is the player
    if sourceGUID == UnitGUID("player") then
        local healingEvents = {
            SPELL_HEAL = true,
            SPELL_PERIODIC_HEAL = true,
            SPELL_PERIODIC_ENERGIZE = true,
            SPELL_INTERRUPT = true,
            SPELL_ENERGIZE = true,
            SPELL_DISPEL = true,
        }
        -- If the subevent is not a healing event
        if not healingEvents[subevent] then
            if (amount ~= nil and type(amount) == "number") then
                if(critical ~= false) then
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE timestamp: "..timestamp);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE subevent: "..subevent);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE spellID: "..spellID);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE spellName: "..spellName);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE spellSchool: "..spellSchool);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE sourceGUID: "..sourceGUID);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE sourceName: "..sourceName);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE sourceFlags: "..sourceFlags);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE sourceRaidFlags: "..sourceRaidFlags);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE destGUID: "..destGUID);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE destName: "..destName);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE destFlags: "..destFlags);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE destRaidFlags: "..destRaidFlags);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE amount: "..amount);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE overkill: "..overkill);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE school: "..school);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE resisted: "..resisted);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE blocked: "..blocked);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE absorbed: "..absorbed);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE critical: "..(critical and "Yes" or "No"));
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE glancing: "..glancing);
                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE crushing: "..crushing);

                    --DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800 INSIDE RANGED_DAMAGE: "..amount);
                    if (spellName ~= nil) then
                        local SpellName = Godlike:GetSpell();
                        local SpellNameNot = Godlike:GetSpellNot();
                        if SpellNameNot == nil then
                            SpellNameNot = "";
                        end
                        local SpellsArray = {}

                        for spell in string.gmatch(SpellNameNot, '([^,]+)') do
                            table.insert(SpellsArray, spell:match("^%s*(.-)%s*$"))  -- Trim any leading/trailing whitespace
                        end

                        -- Print the array to verify
                        --for i, spell in ipairs(SpellsArray) do
                            --print(i, spell)
                        --end
                        --Validate that spellName is not in each of the values of SpellNameNot array
                        local isNotInArray = true
                        for i = 1, #SpellsArray do
                            if SpellsArray[i] == spellName then
                                isNotInArray = false
                                break
                            end
                        end

                        if isNotInArray then
                            --print(spellName .. " is NOT in the array.")
                            if(spellName ~= "Restore Mana") then
                                if string.upper(SpellName) == string.upper("all") then
                                    local setLevelVar = tonumber(Godlike:GetSetlevel());
                                    --print("Unit Level: ", UnitLevel("target"));
                                    --print("Set Level: ", setLevelVar);
                                    if (setLevelVar == nil or setLevelVar == 0) then
                                        SpellDmg = amount;
                                        SpellName_Global = spellName;
                                        GodLike_CritDone();
                                    elseif (UnitLevel("target") >= setLevelVar or UnitLevel("target") == -1) then
                                            SpellDmg = amount;
                                            SpellName = spellName;
                                            SpellName_Global = spellName;
                                            GodLike_CritDone();
                                    end
                                else
                                    SpellName = Godlike:GetSpell();
                                    if string.upper(SpellName) == string.upper(spellName) then
                                        SpellDmg = amount;
                                        SpellName_Global = spellName;
                                        GodLike_CritDone();
                                    end
                                end
                            end
                        else
                            --print(spellName .. " is IN the array.")
                        end
                    end
                end
            else
                --print("Subevent:", subevent)
            end
        else
            if subevent == "SPELL_HEAL" or "SPELL_PERIODIC_HEAL" then
                if (amount ~= nil and type(amount) == "number") then
                    if(resisted == true) then
                        if (spellName ~= nil) then
                            SpellName = Godlike:GetSpell();
                            local SpellNameNot = Godlike:GetSpellNot();
                            if SpellNameNot == nil then
                                SpellNameNot = "";
                            end
                            local SpellsArray = {}

                            for spell in string.gmatch(SpellNameNot, '([^,]+)') do
                                table.insert(SpellsArray, spell:match("^%s*(.-)%s*$"))  -- Trim any leading/trailing whitespace
                            end
                            -- Print the array to verify
                            --for i, spell in ipairs(SpellsArray) do
                                --print(i, spell)
                            --end
                            --Validate that spellName is not in each of the values of SpellNameNot array
                            local isNotInArray = true
                            for i = 1, #SpellsArray do
                                if SpellsArray[i] == spellName then
                                    isNotInArray = false
                                    break
                                end
                            end

                            if isNotInArray then
                                --print(spellName .. " is NOT in the array.")
                                if string.upper(SpellName) == string.upper("all") then
                                    SpellDmg = amount;
                                    SpellName_Global = spellName;
                                    GodLike_HealCritDone();
                                else
                                    if string.upper(SpellName) == string.upper(spellName) then
                                        SpellDmg = amount;
                                        SpellName_Global = spellName;
                                        GodLike_HealCritDone();
                                    end
                                end
                            else
                                --print(spellName .. " is IN the array.")
                            end
                        end
                    end
                else
                end
            end
        end
    end		
end

function GodLike_CritDone()
	if tonumber(SpellDmg) > tonumber(CRIT4) then
        msg = Godlike:GetCritMsg4();
		sound = GL_SND_CRIT4;
	elseif tonumber(SpellDmg) > tonumber(CRIT3) then
        msg = Godlike:GetCritMsg3();
		sound = GL_SND_CRIT3;
	elseif tonumber(SpellDmg) > tonumber(CRIT2) then
        msg = Godlike:GetCritMsg2();
		sound = GL_SND_CRIT2;
	elseif tonumber(SpellDmg) > tonumber(CRIT1) then
        msg = Godlike:GetCritMsg1();
		sound = GL_SND_CRIT1;
	else return
	end
    local isMessageEnabledVar = Godlike:GetIsMessageEnabled();
	if (isMessageEnabledVar == true) then
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL ..msg)
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800"..SpellName_Global.." |c00FF0000 "..SpellDmg)
	end
    local isSoundEnabledVar = Godlike:GetIsSoundEnabled();
	if (isSoundEnabledVar == true) then
		if sound then
			PlaySoundFile(sound,"Master");
		end
	end
    local isAutoVar = Godlike:GetIsAuto();
	if (isAutoVar == true) then
        local isAutoSetVar = Godlike:GetAutoSetFactor();
        local maxCritVar = tonumber(Godlike:GetMaxCrit());
	    if (tonumber(SpellDmg) * 0.01 * isAutoSetVar) > tonumber(CRIT4) then
			maxCritVar = math.floor(SpellDmg * 0.01 * isAutoSetVar);
            Godlike:SetMaxCrit(nil, maxCritVar);
            maxCritVar = tonumber(Godlike:GetMaxCrit());
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWTOPCRIT.."|c00FF0000Damage: "..SpellDmg..GL_TEXT_NEWAUTOCRIT..maxCritVar..")");
            GodLike_SetCrits();
		end
	else
	end
end


function GodLike_HealCritDone()
	if tonumber(SpellDmg) > tonumber(HEAL4) then
        msg = Godlike:GetMsgHeal4();
		sound = GL_SND_HEAL4;
	elseif tonumber(SpellDmg) > tonumber(HEAL3) then
        msg = Godlike:GetMsgHeal3();
		sound = GL_SND_HEAL3;
	elseif tonumber(SpellDmg) > tonumber(HEAL2) then
        msg = Godlike:GetMsgHeal2();
		sound = GL_SND_HEAL2;
	elseif tonumber(SpellDmg) > tonumber(HEAL1) then
        msg = Godlike:GetMsgHeal1();
		sound = GL_SND_HEAL1;
	else return
	end
    local isMessageEnabledVar = Godlike:GetIsMessageEnabled();
	if (isMessageEnabledVar) then
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL ..msg)
		DEFAULT_CHAT_FRAME:AddMessage(GL_MSG_GL.. "|c00FFC800"..SpellName_Global.." |c0000FF00 "..SpellDmg)
	end
    local isSoundEnabledVar = Godlike:GetIsSoundEnabled();
	if (isSoundEnabledVar) then
		if sound then PlaySoundFile(sound);
		end
	end
    local isAutoVar = Godlike:GetIsAuto();
	if isAutoVar == true then
        local isAutoSetVar = Godlike:GetAutoSetFactor();
        local maxCritVar = tonumber(Godlike:GetMaxHeal());
	    if (tonumber(SpellDmg) * 0.01 * isAutoSetVar) > tonumber(HEAL4) then
			maxCritVar = math.floor(SpellDmg * 0.01 * isAutoSetVar);
            Godlike:SetMaxHeal(nil, maxCritVar);
            maxCritVar = tonumber(Godlike:GetMaxHeal());
			DEFAULT_CHAT_FRAME:AddMessage(GL_TEXT_NEWTOPCRIT.."|c0000FF00Heal: "..SpellDmg..GL_TEXT_NEWAUTOCRIT..maxCritVar..")");
	        GodLike_SetHeals();
		end
	else
	end
	
end