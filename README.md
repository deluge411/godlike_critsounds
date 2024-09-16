# godlike_critsounds
GodLike CrtiSounds is an addon that you can customize the ranges of your critical attacks and heals to play certain sounds. Replaced the old sounds with the Unreal Tournament sounds. Replace the mp3's to load your own sounds.



Notes: I decided to keep this addon updated since I couldn't find another addon similiar to this anywhere. I decided to give back and share it with the community. This addon was made around the middle of 2005 to give you an idea how long ago this has been going on. Multiple authors have tried to keep it alive as noted in the credits. (Aug 15, 2024)



Notes-deDE: Ein kleines Spaß AddOn, welches Nachrichten und Sounds ausgiebt wenn ihr ein Ziel kritisch trefft. Viel Spaß!



For options type:

/gl

/godlike



Description:

So to give a brief description what this addon does and how it works. We will be assuming you run it out of the box with its default configuration, which has Automatic Crit-Settings turned on.  We will use low numbers so you get the idea better, for level 110 just add more zeros at the end.



You hit a crit of 1000, Godlike CritSounds adjust to 90%(you can change this value in options) of that crit and sets it as your Max-Crit which is 900.  Now around every 10% from there on downward it adjusts crit sounds for your 4 main sounds.  It will look like this internally on your crit damage and what sound it will play (these are approximate values since I get the 10% of the next value):



900+  = Holy Shit

899-800 = Godlike

799-700 = Monster Kill

699-600 = Ultra Kill



So Godlike Critsound will sound off on crits of those sizes unless you hit something higher then 900 and it readjusts the table again.



Options Explained:

GodLike Enabled - Turn Godlike CritSounds on or off

Sound-Output Enabled - Activate sounds  on or off

Message-Output Enabled - Activate to display chat-messages text



Automatic Crit-Settings Set to - Sets the % of the value to set your max crit to. Example: If you hit 100 and if its on 90% it will set it to 90.

Max-Crit is set to - Sets the maximum crit damage manually.

Max-Heal is set to - Sets the maximum heal value manually.(I normally set this really high if I am playing a dps class so I don' hear it at all)

Range of Sound-Output - Sound output volume of the sounds playing

Only monitor this spell - This option is for when you don't care about the rest of your spells and only want the addon to monitor one certain spell. Example, I set it to Aimed Shot, the addon will ignore everything else and just activate sounds when aim shot hits a critical. This also applies for heals.

Avoid monitoring these spells - This option is for when you are tired that the addon only activates on certain spells cause they always hit hard. Example, I input Execute with my warrior because thats the only spell hitting super hard and nothing else comes close to it. So I want to monitor the critical of other spells in the example mentioned. This also applies for heals.

Only Activate when target is this level or above - Sets the lowest level the target needs to be for Godlike CritSounds to play sounds. (I just added this because it was frustrating going into MC or BWL and screwing up my Max Crit set cause the mobs were low level. Also because I got tired of hearing Holy Shit for killing a level 20 mob and me being 110).

Used Sound-Pack - You can put the name of the folder you want to use as sounds that are found in GodLike\Sounds\   Default is the english folder found inside, you can have multiple folders with different sounds and just type the name of the folder you want to use.

 Localization: This addon should work out of the box for the following WoW clients: enUS, deDE,  zhCN



Credits go to where they are due:

Title: GodLike CritSounds

Author: Garthnait of Kil'Jaeden (EU)

Updated & Enhanced: Svenson of Anub'Arak (EU)

Updated 6.3.2 - Current: Antedeluvian of Sargeras (US)



If you have used previous versions of this addon and you still have the user variables saved this might give you an error. Try and go into  Profiles section and hit RESET PROFILE to reset your saved variables to the new ones used. That should fix that issue.



Changelog:

Notes 11.0.2d(September 16, 2024): Added section for "Avoid monitoring these spells" and fixed certain interrupts activating sounds. Added localization zhCN complete text locale file.

Notes 11.0.2c(August 31, 2024): Added zhCN locale to fix missing variable.


Notes 11.0.2b(August 24, 2024): Fixed a wrong operator when you set this level or above. It should now work as intended and also work with Cataclysm Classic. 

Notes 11.0.2(August 15, 2024): Redid the whole addon using the ACE3 libraries since the old libraries were causing too many interface errors.  This version is ready for The War Within expansion and works with the current Classic versions also 1.15.3 version.

Notes 8.1.5(May 22, 2011): Fixed interface version.  

Notes 8.0.1(Aug 6, 2018): Fixed interface version and the way combat log is grabbed to parse the criticals. 

Notes 7.32.2(Nov 19, 2017): Added Level Settings for Damage. Now you can set the level that Godlike CritSounds will use to only activate with. Ex: Set the level at 106 Godlike will only activate when the mob is 106 or higher. This is to prevent the addon from sounding off on everything when you are farming lower level stuff then you having to manually set the Max Crit level again. Also added and fixed Localization for deDE and esMX.  Added to the proyect page a description text and example and explained what the options do.

Notes 7.32.1(Nov 17, 2017): Fixed Options not working properly and removed some obsolete stuff

Notes 7.32(Nov 15, 2017): Fixed interface version to work with patch 7.32 

Notes 7.03: Fixed parameters it receives from combat log and updated to new interface version. 

Notes 6.32: All sounds were replaced by the Unreal Sounds for more excitement. If you want to use your own sounds just replace the .mp3s accordingly.