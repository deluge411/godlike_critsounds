
	GL_VERSION	=	C_AddOns.GetAddOnMetadata("GodLike", "version")

if (GetLocale() == "zhCN") then

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

	GL_MSG_CRIT1		=	"|c00FFC800ULTRA KILL!";
	GL_MSG_CRIT2		=	"|c00FFC800MOMOMONSTER KILL!";
	GL_MSG_CRIT3		=	"|c00FFC800GODLIKE!";
	GL_MSG_CRIT4		=	"|c00FFC800Holy Shit! That hurts!";

	GL_MSG_HEAL1		=	"|c00FFC800YEAH!";
	GL_MSG_HEAL2		=	"|c00FFC800OhYEAH!";
	GL_MSG_HEAL3		=	"|c00FFC800Halleluja";
	GL_MSG_HEAL4		=	"|c00FFC800Halleluja!!! Halleluja!!!";

	GL_MSG_LOW			=	"|c00FFC800That's Bullshit!";

-- Optionsmenu
	GL_TEXT_OPT_LABEL_SETTINGS      ="GodLike 设置";
	GL_TEXT_OPT_VAR_GLENABLED       ="GodLike 设置";
	GL_TEXT_OPT_TOOL_GLENABLED      ="GodLike 开/关";
	GL_TEXT_OPT_VAR_SNDENABLED      ="声音输出 设置";
	GL_TEXT_OPT_TOOL_SNDENABLED     ="声音输出 开/关";
	GL_TEXT_OPT_VAR_MSGENABLED      ="消息输出 设置";
	GL_TEXT_OPT_TOOL_MSGENABLED     ="消息输出 开/关";
	GL_TEXT_OPT_VAR_SCTENABLED      ="SCT输出 设置 (安装了SCT才生效)";
	GL_TEXT_OPT_TOOL_SCTENABLED     ="SCT输出 开/关";
	GL_TEXT_OPT_VAR_PLAYLOW			="Low-Crit Sounds";
	GL_TEXT_OPT_TOOL_PLAYLOW		="Turn the sounds for low crits on/off";

	GL_TEXT_OPT_LABEL_MAXCRIT       ="暴击条件设置";
	GL_TEXT_OPT_AUTO                ="|c00FFFFFF自动设置";
	GL_TEXT_OPT_AUTOHELP            ="|c00FFFFFF自动设置 开/关";
	GL_TEXT_OPT_SETAUTO				="设置"
	GL_TEXT_OPT_SETAUTOHELP			="将最大爆击值生效条件设定为你最大爆击值的 XX%。此设置仅适用于自动模式。"
	GL_TEXT_OPT_MAXCRIT             ="|c00FFFFFF最大爆击设置为：";
	GL_TEXT_OPT_MAXCRITHELP         ="设置爆击值";
	GL_TEXT_OPT_MAXHEAL             ="|c00FFFFFF最大治疗设置为：";
	GL_TEXT_OPT_MAXHEALHELP         ="设置最大治疗值";
	GL_TEXT_OPT_SETRANGE		="爆击生效范围百分比";
	GL_TEXT_OPT_SETRANGEHELP	="这是从你的最大爆击值计算的百分比范围，当达到该范围时将播放声音。"

	GL_TEXT_OPT_LABEL_SPELL         ="技能监控";
	GL_TEXT_OPT_SPELLONLY			="|c00FFFFFF仅监控以下技能：";
	GL_TEXT_OPT_SPELLONLYHELP		="输入技能名称以筛选该技能。例如，'Aimed Shot' 只会识别瞄准射击的伤害，或者输入 'all' 以识别所有技能。";

	GL_TEXT_OPT_LABEL_SPELLNOT      ="Spells to Avoid Monitoring";
	GL_TEXT_OPT_SPELLONLYNOT		="|c00FFFFFFAvoid monitoring these spells:";
	GL_TEXT_OPT_SPELLONLYHELPNOT	="Enter Spellname to NOT monitor. 'Arcane Shot,Aim Shot' will NOT recognize arcane shot and aim shot damage, separate spells by comma only and no quotations";

	GL_TEXT_OPT_LABEL_PACK          ="声音设置";
	GL_TEXT_OPT_PACK				="|c00FFFFFF选择你的声音包文件夹：";
	GL_TEXT_OPT_PACKHELP			="使用 'english' 或 'german' 作为标准声音文件夹，或者使用已安装的自定义音效包目录的名称。";

	GL_TEXT_OPT_LABEL_OTHER		    ="其他";

	GL_TEXT_OPT_SETLEVEL			="|c00FFFFFF在该等级或更高等级时启用声音提示 (0 = 任意等级)";
	GL_TEXT_OPT_SETLEVELHELP		="此选项适用于进行低级地下城时使用，因为你造成的伤害很高，不希望一直听到声音提示。";

-- Optionsmenu-Seite2

    GL_TEXT_OPT2_LABEL_CRITMSG      ="爆击命中";
    GL_TEXT_OPT2_CRIT1              ="|c00FFFFFFMsg 1:";
    GL_TEXT_OPT2_CRIT2              ="|c00FFFFFFMsg 2:";
    GL_TEXT_OPT2_CRIT3              ="|c00FFFFFFMsg 3:";
    GL_TEXT_OPT2_CRIT4              ="|c00FFFFFFMsg 4:";

    GL_TEXT_OPT2_LABEL_HEALMSG      ="爆击治疗";
    GL_TEXT_OPT2_HEAL1              ="|c00FFFFFFMsg 1:";
    GL_TEXT_OPT2_HEAL2              ="|c00FFFFFFMsg 2:";
    GL_TEXT_OPT2_HEAL3              ="|c00FFFFFFMsg 3:";
    GL_TEXT_OPT2_HEAL4              ="|c00FFFFFFMsg 4:";

    GL_TEXT_OPT2_LABEL_LOWMSG		="Noob-Crits";
    GL_TEXT_OPT2_LOW              	="|c00FFFFFFMsg:";


end