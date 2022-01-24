Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'en',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = true,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = true,
	MenuImage = "https://media.discordapp.net/attachments/826161097857171497/915413078991073321/Untitled-1.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = true,
	RagdollKeybind = 303, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = true,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = true,
}

Config.KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

Config.Languages = {
  ['en'] = {
    ['emotes'] = 'Emotii',
    ['danceemotes'] = "🕺 Emotii De Dans",
    ['propemotes'] = "📦 Emotii Obiecte",
    ['favoriteemotes'] = "🌟 Favorite",
    ['favoriteinfo'] = "Selecteaza o emotie aici pentru a-l seta ca preferat.",
    ['rfavorite'] = "Resetati emotiile favorite.",
    ['prop2info'] = "❓ Prop Emotes can be located at the end",
    ['set'] = "Seteaza (",
    ['setboundemote'] = ") sa fie animatia pe keybind-ul setat ?",
    ['newsetemote'] = "~w~ este acum keybind-ul setat, apasa ~g~CapsLock~w~ pentru a il folosi.",
    ['walkingstyles'] = "Stil de mers",
    ['resetdef'] = "Reseteaza la ~g~NORMAL~w~.",
    ['normalreset'] = "Normal (Reseteaza)",
    ['moods'] = "Mod fata",
    ['notvaliddance'] = "Nu este un dans valid.",
    ['notvalidemote'] = "Nu este o emotie valida..",
    ['nocancel'] = "Nicio emotie de anulat.",
    ['maleonly'] = "Scuze, aceasta emotie este disponibila doar pentru un caracter de tip barbatesc!",
    ['emotemenucmd'] = "Do /emotemenu for a menu.",
    ['shareemotes'] = "👫 Emotii partajate",
    ['shareemotesinfo'] = "Invitati o persoana din apropiere sa foloseasca o emotie.",
    ['sharedanceemotes'] = "🕺 Dansuri partajate",
    ['notvalidsharedemote'] = "Nu este valida.",
    ['sentrequestto'] = "Trimite o cerere lui ~y~",
    ['nobodyclose'] = "Nimeni nu este indeajuns de ~r~aproape~w~.",
    ['doyouwanna'] = "~y~H~w~ pentru a accepta, ~r~L~w~ pentru a refuza (~g~",
    ['refuseemote'] = "Emotie refuzata.",
    ['makenearby'] = "Face jucatorul din apropiere sa joace",
    ['camera'] = "Apasa ~y~G~w~ pentru a folosi blitul de la camera.",
    ['makeitrain'] = "Apasa ~y~G~w~ pentru a arunca cu bani.",
    ['pee'] = "Tine apasat ~y~G~w~ pentru a urina..",
    ['spraychamp'] = "Tine apasat ~y~G~w~ pentru a pulveriza sampania",
    ['bound'] = "Bindeaza ",
    ['to'] = "la",
    ['currentlyboundemotes'] = " Emotii bindate in prezent:",
    ['notvalidkey'] = "Nu este o tasta valida.",
    ['keybinds'] = "🔢 Binduri",
    ['keybindsinfo'] = "Foloseste"
  },
}