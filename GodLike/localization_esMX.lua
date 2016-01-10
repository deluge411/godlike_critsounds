
	GL_VERSION	=	GetAddOnMetadata("GodLike", "version")

if (GetLocale() == "esMX") then

	GL_LANG = "english";

-- OnLoadMessages
	GL_TEXT_WELCOME00		=	"|c00ff8000[GodLike]: |c0000BFFFGodLike |c0000FF00v"..GL_VERSION.." |c0000BFFFis loaded.";
	GL_TEXT_WELCOME01		=	"|c00ff8000[GodLike]: |c0000BFFFFor options type /GodLike or /GL.";

-- ModSlashCommands
	GL_TEXT_SLASHCOMMAND0A	=	"|c00ff8000[GodLike]: |c00FFE100========== |c00FFC800SlashCommandList |c00FFE100==========";
	GL_TEXT_SLASHCOMMAND0B	=	"|c00ff8000[GodLike]: |c00FFE100==================================";
	GL_TEXT_SLASHCOMMAND00	=	"|c00ff8000[GodLike]: |c00FFE100/GL status - Shows AddOn Status";
	GL_TEXT_SLASHCOMMAND01	=	"|c00ff8000[GodLike]: |c00FFE100/GL mod on|off - Turns GodLike on/off";
	GL_TEXT_SLASHCOMMAND02	=	"|c00ff8000[GodLike]: |c00FFE100/GL snd on|off - Turns Sounds on/off";
	GL_TEXT_SLASHCOMMAND03	=	"|c00ff8000[GodLike]: |c00FFE100/GL msg on|off - Turns Messages on/off";
	GL_TEXT_SLASHCOMMAND04	=	"|c00ff8000[GodLike]: |c00FFE100/GL sct on|off - Turns SCT-Ausgabe on/off";
	GL_TEXT_SLASHCOMMAND09	=	"|c00ff8000[GodLike]: |c00FFE100/GL low on|off - Turns Low-Crit Sounds on/off";
	GL_TEXT_SLASHCOMMAND05	=	"|c00ff8000[GodLike]: |c00FFE100/GL maxcrit X - Sets new maxcrit damage";
	GL_TEXT_SLASHCOMMAND06	=	"|c00ff8000[GodLike]: |c00FFE100/GL maxheal X - Sets new maxcrit heal";
	GL_TEXT_SLASHCOMMAND07	=	"|c00ff8000[GodLike]: |c00FFE100/GL auto - sets new maxcrit automatically";
	GL_TEXT_SLASHCOMMAND08	=	"|c00ff8000[GodLike]: |c00FFE100/GL spell [Spellname]|all|melee - recognised spells";

    
-- ModStatusMessages
	GL_TEXT_MODSTATUS0A	=	"|c00ff8000[GodLike]: |c00FFE100========= |c00FFC800Mod Status |c00FFE100========="
	GL_TEXT_MODSTATUS0B	=	"|c00ff8000[GodLike]: |c00FFE100============================";
	GL_TEXT_MODSTATUS00	=	"|c00ff8000[GodLike]: |c00FFE100GodLike Mod is "
	GL_TEXT_MODSTATUS01	=	"|c00ff8000[GodLike]: |c00FFE100Sound Notifications are "
	GL_TEXT_MODSTATUS02	=	"|c00ff8000[GodLike]: |c00FFE100Text Notifications are "
	GL_TEXT_MODSTATUS03	=	"|c00ff8000[GodLike]: |c00FFE100SCT Notifications are " ;
	GL_TEXT_MODSTATUS09	=	"|c00ff8000[GodLike]: |c00FFE100Low-Crit Sounds are " ;
	GL_TEXT_MODSTATUS04	=	"|c00ff8000[GodLike]: |c00FFE100Auto Max-Crit is " ;
	GL_TEXT_MODSTATUS05	=	"|c00ff8000[GodLike]: |c00FFE100Max-Crit is " ;
	GL_TEXT_MODSTATUS06	=	"|c00ff8000[GodLike]: |c00FFE100Max-Heal is " ;
	GL_TEXT_MODSTATUS07	=	"|c00ff8000[GodLike]: |c00FFE100Tracked spell is " ;


-- ModMaxCritMessages
	GL_TEXT_AUTO		=	"|c00ff8000[GodLike]: |c00FFE100Automode is "

	GL_TEXT_NOMAXCRIT	=	"|c00ff8000[GodLike]: |c00FF0000No Max-Crit entered!"
	GL_TEXT_NEWMAXCRIT	=	"|c00ff8000[GodLike]: |c00FFE100New Max-Crit: "
	GL_TEXT_NEWTOPCRIT	=	"|c00ff8000[GodLike]: |c00FFE100New Crit-Record: "
	GL_TEXT_NEWAUTOCRIT	=	"|c00FFE100. (Max-Crit set: "

	GL_TEXT_NOSPELL		=	"|c00ff8000[GodLike]: |c00FF0000No spell entered!"
	GL_TEXT_NEWSPELL	=	"|c00ff8000[GodLike]: |c00FFE100New crit-spell:"


-- Sounds
	GL_SND_YEAH			=	"Interface\\AddOns\\GodLike\\Sounds\\yeah.wav";
	GL_SND_OHYEAH		=	"Interface\\AddOns\\GodLike\\Sounds\\ohyeah.wav";
	GL_SND_GODLIKE		=	"Interface\\AddOns\\GodLike\\Sounds\\godlike.wav";
	GL_SND_HOLYSHIT		=	"Interface\\AddOns\\GodLike\\Sounds\\holyshit.wav";
	GL_SND_HALLELUJA1	=	"Interface\\AddOns\\GodLike\\Sounds\\halleluja1.wav";
	GL_SND_HALLELUJA2	=	"Interface\\AddOns\\GodLike\\Sounds\\halleluja2.wav";
	GL_SND_LOW			=	"Interface\\AddOns\\GodLike\\Sounds\\bullshit.wav";

-- Messages
	GL_MSG_GL			=	"|c00FFE100[GodLike]: ";

	GL_MSG_CRIT1		=	"|c00FFC800YEAH!";
	GL_MSG_CRIT2		=	"|c00FFC800OhYEAH!";
	GL_MSG_CRIT3		=	"|c00FFC800You're really God Like!";
	GL_MSG_CRIT4		=	"|c00FFC800Holy Shit! That hurts!";

	GL_MSG_HEAL1		=	"|c00FFC800YEAH!";
	GL_MSG_HEAL2		=	"|c00FFC800OhYEAH!";
	GL_MSG_HEAL3		=	"|c00FFC800Halleluja";
	GL_MSG_HEAL4		=	"|c00FFC800Halleluja!!! Halleluja!!!";

	GL_MSG_LOW			=	"|c00FFC800That's Bullshit!";

-- Optionsmenu
	GL_TEXT_OPT_LABEL_SETTINGS      ="GodLike Settings";
	GL_TEXT_OPT_VAR_GLENABLED       ="GodLike enabled";
	GL_TEXT_OPT_TOOL_GLENABLED      ="Turn GodLike on/off";
	GL_TEXT_OPT_VAR_SNDENABLED      ="Sound-Output enabled";
	GL_TEXT_OPT_TOOL_SNDENABLED     ="Turn the Sound on/off";
	GL_TEXT_OPT_VAR_MSGENABLED      ="Message-Output enabled";
	GL_TEXT_OPT_TOOL_MSGENABLED     ="Turn the Chat Messages on/off";
	GL_TEXT_OPT_VAR_SCTENABLED      ="SCT-Output enabled (works only if SCT installed)";
	GL_TEXT_OPT_TOOL_SCTENABLED     ="Turn the SCT-Messages on/off";
	GL_TEXT_OPT_VAR_PLAYLOW			="Low-Crit Sounds";
	GL_TEXT_OPT_TOOL_PLAYLOW		="Turn the sounds for low crits on/off";

	GL_TEXT_OPT_LABEL_MAXCRIT       ="Crit Settings";
	GL_TEXT_OPT_AUTO                ="|c00FFFFFFAutomatic Crit-Settings";
	GL_TEXT_OPT_SETAUTO		="Set to"
	GL_TEXT_OPT_SETAUTOHELP		="Set the max-crit to XX% of the obtained critical hit."
	GL_TEXT_OPT_MAXCRIT             ="|c00FFFFFFMax-Crit is set to: ";
	GL_TEXT_OPT_MAXCRITHELP         ="Sets critical-hit value";
	GL_TEXT_OPT_MAXHEAL             ="|c00FFFFFFMax-Heal is set to: ";
	GL_TEXT_OPT_MAXHEALHELP         ="Sets critical-heal value";
	GL_TEXT_OPT_SETRANGE		=" Range of Sound-Output:"
	GL_TEXT_OPT_SETRANGEHELP	="This is the range, in percent from your Max-Crit, a sound will be played."

	GL_TEXT_OPT_LABEL_SPELL         ="Spell Settings";
	GL_TEXT_OPT_SPELLONLY			="|c00FFFFFFOnly recognize:";
	GL_TEXT_OPT_SPELLONLYHELP		="Enter Spellname to filter this spell. 'melee' recognze only melee-hits. Empty or 'all' recognizes all spells";

	GL_TEXT_OPT_LABEL_PACK          ="Sound Settings";
	GL_TEXT_OPT_PACK				="|c00FFFFFFUsed Sound-Pack:";
	GL_TEXT_OPT_PACKHELP			="Use 'english' or 'german' for the standard-sounds. Or use the name of the installed custom-sound-pack";


-- Optionsmenu-Seite2

    GL_TEXT_OPT2_LABEL_CRITMSG      ="Critical Hits";
    GL_TEXT_OPT2_CRIT1              ="|c00FFFFFFMsg 1:";
    GL_TEXT_OPT2_CRIT2              ="|c00FFFFFFMsg 2:";
    GL_TEXT_OPT2_CRIT3              ="|c00FFFFFFMsg 3:";
    GL_TEXT_OPT2_CRIT4              ="|c00FFFFFFMsg 4:";

    GL_TEXT_OPT2_LABEL_HEALMSG      ="Critical Heals";
    GL_TEXT_OPT2_HEAL1              ="|c00FFFFFFMsg 1:";
    GL_TEXT_OPT2_HEAL2              ="|c00FFFFFFMsg 2:";
    GL_TEXT_OPT2_HEAL3              ="|c00FFFFFFMsg 3:";
    GL_TEXT_OPT2_HEAL4              ="|c00FFFFFFMsg 4:";

    GL_TEXT_OPT2_LABEL_LOWMSG		="Noob-Crits";
    GL_TEXT_OPT2_LOW              	="|c00FFFFFFMsg:";


end