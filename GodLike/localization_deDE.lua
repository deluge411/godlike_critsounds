
	GL_VERSION	=	C_AddOns.GetAddOnMetadata("GodLike", "version")

if (GetLocale() == "deDE") then

	GL_LANG = "german";

-- OnLoadMessages
	GL_TEXT_WELCOME00		=	"|c00ff8000[GodLike]: |c00FFE100GodLike |c0000FF00v"..GL_VERSION.." |c00FFE100wurde geladen.";
	GL_TEXT_WELCOME01		=	"|c00ff8000[GodLike]: |c00FFE100F\195\188r Optionen tippe /GodLike oder /GL ein.";

-- ModSlashCommands
	GL_TEXT_SLASHCOMMAND0A	=	"|c00ff8000[GodLike]: |c00FFE100========== |c00FFC800SlashCommandList |c00FFE100==========";
	GL_TEXT_SLASHCOMMAND0B	=	"|c00ff8000[GodLike]: |c00FFE100==================================";
	GL_TEXT_SLASHCOMMAND00	=	"|c00ff8000[GodLike]: |c00FFE100/GL status - Zeigt AddOn Status";
	GL_TEXT_SLASHCOMMAND01	=	"|c00ff8000[GodLike]: |c00FFE100/GL mod on|off - Schaltet GodLike an/aus";
	GL_TEXT_SLASHCOMMAND02	=	"|c00ff8000[GodLike]: |c00FFE100/GL snd on|off - Schaltet Sounds an/aus";
	GL_TEXT_SLASHCOMMAND03	=	"|c00ff8000[GodLike]: |c00FFE100/GL msg on|off - Schaltet Messages an/aus";
	GL_TEXT_SLASHCOMMAND04	=	"|c00ff8000[GodLike]: |c00FFE100/GL sct on|off - Schaltet SCT-Ausgabe an/aus";
	GL_TEXT_SLASHCOMMAND09	=	"|c00ff8000[GodLike]: |c00FFE100/GL low on|off - Schaltet Low-Krit Sounds an/aus";
	GL_TEXT_SLASHCOMMAND05	=	"|c00ff8000[GodLike]: |c00FFE100/GL maxcrit X - Setzt neuen Max-Krit Damage";
	GL_TEXT_SLASHCOMMAND06	=	"|c00ff8000[GodLike]: |c00FFE100/GL maxheal X - Setzt neuen Max-Krit Heilung";
	GL_TEXT_SLASHCOMMAND07	=	"|c00ff8000[GodLike]: |c00FFE100/GL auto - Setzt neuen Max-Krit automatisch";
	GL_TEXT_SLASHCOMMAND08	=	"|c00ff8000[GodLike]: |c00FFE100/GL spell [Spellname]|all|melee - berucksichtige Zauber";

-- ModStatusMessages
	GL_TEXT_MODSTATUS0A	=	"|c00ff8000[GodLike]: |c00FFE100========= |c00FFC800Mod Status |c00FFE100========="
	GL_TEXT_MODSTATUS0B	=	"|c00ff8000[GodLike]: |c00FFE100============================";
	GL_TEXT_MODSTATUS00	=	"|c00ff8000[GodLike]: |c00FFE100GodLike Mod ist "
	GL_TEXT_MODSTATUS01	=	"|c00ff8000[GodLike]: |c00FFE100Sounds sind "
	GL_TEXT_MODSTATUS02	=	"|c00ff8000[GodLike]: |c00FFE100Messages sind "
	GL_TEXT_MODSTATUS03	=	"|c00ff8000[GodLike]: |c00FFE100SCT Messages sind " ;
	GL_TEXT_MODSTATUS09	=	"|c00ff8000[GodLike]: |c00FFE100Low-Krit Sounds sind " ;
	GL_TEXT_MODSTATUS04	=	"|c00ff8000[GodLike]: |c00FFE100Auto Max-Krit ist " ;
	GL_TEXT_MODSTATUS05	=	"|c00ff8000[GodLike]: |c00FFE100Max-Krit ist " ;
	GL_TEXT_MODSTATUS06	=	"|c00ff8000[GodLike]: |c00FFE100Max-Heal ist " ;
	GL_TEXT_MODSTATUS07	=	"|c00ff8000[GodLike]: |c00FFE100Beobachteter Zauber: " ;

-- ModMaxCritMessages
	GL_TEXT_AUTO		=	"|c00ff8000[GodLike]: |c00FFE100Auto-Mode ist "

	GL_TEXT_NOMAXCRIT	=	"|c00ff8000[GodLike]: |c00FF0000Kein Maximal-Krit angegeben!"
	GL_TEXT_NEWMAXCRIT	=	"|c00ff8000[GodLike]: |c00FFE100Neuer Max-Krit: "
	GL_TEXT_NEWTOPCRIT	=	"|c00ff8000[GodLike]: |c00FFE100Neuer Krit-Rekord: "
	GL_TEXT_NEWAUTOCRIT	=	"|c00FFE100. (Max-Krit set: "

	GL_TEXT_NOSPELL		=	"|c00ff8000[GodLike]: |c00FF0000Kein Zauberspruch angeben!"
	GL_TEXT_NEWSPELL	=	"|c00ff8000[GodLike]: |c00FFE100Neuer Zauber:"

-- Sounds
	GL_SND_YEAH		=	"Interface\\AddOns\\GodLike\\Sounds\\yeah.wav";
	GL_SND_OHYEAH		=	"Interface\\AddOns\\GodLike\\Sounds\\ohyeah.wav";
	GL_SND_GODLIKE		=	"Interface\\AddOns\\GodLike\\Sounds\\godlike.wav";
	GL_SND_HOLYSHIT		=	"Interface\\AddOns\\GodLike\\Sounds\\holyshit.wav";
	GL_SND_HALLELUJA1	=	"Interface\\AddOns\\GodLike\\Sounds\\halleluja1.wav";
	GL_SND_HALLELUJA2	=	"Interface\\AddOns\\GodLike\\Sounds\\halleluja2.wav";
	GL_SND_LOW		=	"Interface\\AddOns\\GodLike\\Sounds\\eigentlich.wav";

-- Messages
	GL_MSG_GL		=	"|c00FFE100[GodLike]: |c00FFC800";

	GL_MSG_CRIT1		=	"ULTRA KILL!";
	GL_MSG_CRIT2		=	"MOMOMONSTER KILL!";
	GL_MSG_CRIT3		=	"GODLIKE!";
	GL_MSG_CRIT4		=	"Holy Shit! That hurts!";

	GL_MSG_HEAL1		=	"YEAH!";
	GL_MSG_HEAL2		=	"OhYEAH!";
	GL_MSG_HEAL3		=	"Halleluja";
	GL_MSG_HEAL4		=	"Halleluja!!! Halleluja!!!";

	GL_MSG_LOW			=	"Was kannst du eigentlich?";


-- Optionsmenu
	GL_TEXT_OPT_LABEL_SETTINGS      ="GodLike Einstellungen";
	GL_TEXT_OPT_VAR_GLENABLED       ="GodLike aktviert";
	GL_TEXT_OPT_TOOL_GLENABLED      ="Schaltet GodLike an/aus";
	GL_TEXT_OPT_VAR_SNDENABLED      ="Soundausgabe aktiviert";
	GL_TEXT_OPT_TOOL_SNDENABLED     ="Schaltet den Sound an/aus";
	GL_TEXT_OPT_VAR_MSGENABLED      ="Chatnachrtichten aktiviert";
	GL_TEXT_OPT_TOOL_MSGENABLED     ="Schaltet die Chatnachrichten an/aus";
	GL_TEXT_OPT_VAR_SCTENABLED      ="SCT-Ausgabe aktiviert (nur wenn SCT intalliert ist)";
	GL_TEXT_OPT_TOOL_SCTENABLED     ="Schaltet die SCT-Nachrichten an/aus";
	GL_TEXT_OPT_VAR_PLAYLOW			="Low-Krit Sounds";
	GL_TEXT_OPT_TOOL_PLAYLOW		="Schaltet den Sound bei niedrigen Krits an/aus";

	GL_TEXT_OPT_LABEL_MAXCRIT       ="Krit Einstellungen";
	GL_TEXT_OPT_AUTO                ="|c00FFFFFFAutomatsiche Krit-Anpassung";
	GL_TEXT_OPT_SETAUTO		="Setzen auf"
	GL_TEXT_OPT_SETAUTOHELP		="Setzte den Max-Crit auf XX% des erzielten kritischen Treffers."
	GL_TEXT_OPT_MAXCRIT             ="|c00FFFFFFMax-Crit ist eingestellt auf: ";
	GL_TEXT_OPT_MAXCRITHELP         ="Legt fest wie hoch ein kritischer Treffer sein muss";
	GL_TEXT_OPT_MAXHEAL             ="|c00FFFFFFMax-Heal ist eingestellt auf: ";
	GL_TEXT_OPT_MAXHEALHELP         ="Legt fest wie hoch eine kritische Heilung ein muss";
	GL_TEXT_OPT_SETRANGE		=" Spannweite der Soundausgabe:"
	GL_TEXT_OPT_SETRANGEHELP	="Bis zu wieviel Prozent des Max-Crit soll eine Soundausgabe erfolgen."

	GL_TEXT_OPT_LABEL_SPELL         ="Zauberspruch Einstellungen";
	GL_TEXT_OPT_SPELLONLY			="|c00FFFFFFBeschr\195\164nkt auf:";
	GL_TEXT_OPT_SPELLONLYHELP		="Zaubername eingeben um nur diesen Zauber zu ber\195\188cksichtigen. 'melee' ber\195\188cksichtigt nur Nahkampf-Krits. L\195\182schen oder 'all' um alle Zauber zu ber\195\188cksichtigen";

	GL_TEXT_OPT_LABEL_SPELLNOT      ="Spells to Avoid Monitoring";
	GL_TEXT_OPT_SPELLONLYNOT		="|c00FFFFFFAvoid monitoring these spells:";
	GL_TEXT_OPT_SPELLONLYHELPNOT	="Enter Spellname to NOT monitor. 'Arcane Shot,Aim Shot' will NOT recognize arcane shot and aim shot damage, separate spells by comma only and no quotations";

	GL_TEXT_OPT_LABEL_PACK          ="Sound Einstellungen";
	GL_TEXT_OPT_PACK				="|c00FFFFFFVerwendetes Sound-Pack:";
	GL_TEXT_OPT_PACKHELP			="Benutze 'german' oder 'english' f\195\188r die Standard-Sounds. Oder den jeweiligen Namen des Custom-Sound-Packs";

	GL_TEXT_OPT_LABEL_OTHER		    ="Other Settings";

	GL_TEXT_OPT_SETLEVEL			="|c00FFFFFFActivate sounds this level or above (0 = any level)";
	GL_TEXT_OPT_SETLEVELHELP		="This option is good for when doing lower level dungeons and you don't want to keep hearing the sounds because you are hitting them hard";


-- Optionsmenu-Seite2

    GL_TEXT_OPT2_LABEL_CRITMSG      ="Kritische Treffer";
    GL_TEXT_OPT2_CRIT1              ="|c00FFFFFFMsg 1:";
    GL_TEXT_OPT2_CRIT2              ="|c00FFFFFFMsg 2:";
    GL_TEXT_OPT2_CRIT3              ="|c00FFFFFFMsg 3:";
    GL_TEXT_OPT2_CRIT4              ="|c00FFFFFFMsg 4:";

    GL_TEXT_OPT2_LABEL_HEALMSG      ="Kritische Heilungen";
    GL_TEXT_OPT2_HEAL1              ="|c00FFFFFFMsg 1:";
    GL_TEXT_OPT2_HEAL2              ="|c00FFFFFFMsg 2:";
    GL_TEXT_OPT2_HEAL3              ="|c00FFFFFFMsg 3:";
    GL_TEXT_OPT2_HEAL4              ="|c00FFFFFFMsg 4:";

    GL_TEXT_OPT2_LABEL_LOWMSG		="Kritische Noob-Warunung :-)";
    GL_TEXT_OPT2_LOW              	="|c00FFFFFFMsg:";
end