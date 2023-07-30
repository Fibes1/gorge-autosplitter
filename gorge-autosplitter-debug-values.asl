state("Gorge-Win64-Shipping")
{
    int pause: 0x35E03C0, 0x2B4; // not paused = 1
    bool pause1: 0x035E1220, 0x8D0; // this isn't used for the normal autosplitter, since it leaves a gap when exiting to the main menu. the other one does the same for rewind chapter, but that doesn't matter nearly as much
    int load: 0x35E0228, 0x8, 0x100, 0x30C; // loading or main menu = 0

    double checkpoint: 0x35E0228, 0x8, 0x100, 0x2D4; // unique number for the current checkpoint, theres a lot of these addresses but this seems to be the only one that has no repeats. doesnt change when rewinding chapter in most cases
    int chapter: 0x35E0228, 0x8, 0x100, 0x408; // wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261, sometimes the first chapter that you play after opening the game can also be 0

    byte mug: 0x035E0228, 0x8, 0x360, 0xA0; // number of mugs collected
    byte vhs: 0x035E0228, 0x8, 0x360, 0x140; // number of vhs tapes collected
    byte challenge: 0x035E0228, 0x8, 0x378, 0x30; // number of challenge courses completed in under par time
    byte lookout: 0x035E0228, 0x8, 0x360, 0xD0; // number of lookouts visited

    int cpcount: 0x035E03C0, 0x58, 0x498; // used for the gorge done quick achievement
    float freeze: 0x035E6D30, 0x100, 0x3B0, 0x70, 0x1B8, 0x248;
}

startup
{
    settings.Add("location", true, "Location Splits");
        settings.Add("wakeup", true, "Wake-Up", "location");
        settings.CurrentDefaultParent = "wakeup";
            settings.Add("256", true, "First Checkpoint");
            settings.Add("3.40433574423129E+27", false, "Wall Jumps Section");
            settings.Add("1.78263407272949E+29", false, "Oil Canister");
            settings.Add("6.9324658484767E+29", false, "Last Checkpoint");
        settings.Add("gorge", true, "Gorge", "location");
        settings.CurrentDefaultParent = "gorge";
            settings.Add("257", true, "First Checkpoint");
            settings.Add("-1.35399782960504E+27", false, "Spinning Platform");
            settings.Add("-2.32113871659486E+26", false, "Last Checkpoint");
        settings.Add("caves", true, "Caves", "location");
        settings.CurrentDefaultParent = "caves";
            settings.Add("258", true, "First Checkpoint");
            settings.Add("-4.11986633182541E+30", false, "Spiral Room");
            settings.Add("-1.18842290782924E+30", false, "Next Spiral");
            settings.Add("-6.33825769878899E+29", false, "Slide");
            settings.Add("-1.48552878193047E+28", false, "Slide 2");
            settings.Add("-2.72371134114874E+28", false, "Last Checkpoint");
        settings.Add("reservoir", true, "Reservoir", "location");
        settings.CurrentDefaultParent = "reservoir";
            settings.Add("259", true, "First Checkpoint");
            settings.Add("-3.29589306792851E+31", false, "Main Area");
            settings.Add("-1.90147665418145E+31", false, "Cage");
            settings.Add("-1.16623915483116E+32", false, "Gate");
            settings.Add("-1.59724035845068E+32", false, "Last Checkpoint");
        settings.Add("secondary", true, "Dam - Secondary", "location");
        settings.CurrentDefaultParent = "secondary";
            settings.Add("260", true, "First Checkpoint");
            settings.Add("-9.12708913335691E+32", false, "Left Side Level 4");
            settings.Add("-1.87612409126619E+32", false, "Left Side Level 7");
            settings.Add("-9.38062045634573E+31", false, "Left Side Key Room");
            settings.Add("-8.11296769018935E+33", false, "Right Side Launches");
            settings.Add("-4.82721540789893E+33", false, "Right Side Upper Area");
            settings.Add("-2.35276047555408E+33", false, "Right Side Key Room");
            settings.Add("key1", false, "Inserted Key 1");
            settings.Add("key2", false, "Inserted Key 2");
        settings.Add("primary", true, "Dam - Primary", "location");
        settings.CurrentDefaultParent = "primary";
            settings.Add("261", true, "First Checkpoint");
            settings.Add("-1.71994910208778E+34", false, "Pipe Room");
            settings.Add("-1.33052683531004E+34", false, "Seesaw Room End");
            settings.Add("-1.39543054525592E+34", false, "Slide");
            settings.Add("-1.7524004609629E+34", false, "Canister Room");
            settings.Add("end", true, "Game Completed");

    settings.CurrentDefaultParent = null;
    settings.Add("achievement", false, "Achievement Splits");
        settings.Add("misd", false, "Minor Souvenir Destruction", "achievement");
        settings.Add("masd", false, "Major Souvenir Destruction", "achievement");
            settings.Add("m10", false, "Split every 10 mugs", "masd");
            settings.Add("m25", false, "Split every 25 mugs", "masd");
            settings.Add("m50", false, "Split every 50 mugs", "masd");
        settings.Add("sac", false, "Starting a Collection", "achievement");
        settings.Add("ftc", false, "Finishing the Collection", "achievement");
            settings.Add("v", false, "Split on every tape", "ftc");
        settings.Add("llo", false, "Lookout Look Out", "achievement");
            settings.Add("l", false, "Split on every lookout", "llo");
        settings.Add("ftb", false, "For the Birdies", "achievement");
            settings.Add("c", false, "Split on every course completed", "ftb");

    settings.Add("debug", false, "Debug Values");
    settings.CurrentDefaultParent = "debug";
        settings.Add("X", false, "X Position");
            settings.Add("XP", false, "Precise", "X");
        settings.Add("Y", false, "Y Position");
            settings.Add("YP", false, "Precise", "Y");
        settings.Add("Z", false, "Z Position");
            settings.Add("ZP", false, "Precise", "Z");
        settings.Add("Paused", false, "Paused");
        settings.Add("Loading", false, "Loading");
        settings.Add("CheckpointID", false, "Checkpoint ID");
        settings.Add("CheckpointCount", false, "Checkpoint Count");
        settings.Add("Chapter", false, "Chapter");
        settings.Add("Mugs", false, "Mugs");
        settings.Add("FreezeTimer", false, "Freeze Timer");

    vars.SetTextComponent = (Action<string, string>)((id, text) =>
	{
		var textSettings = timer.Layout.Components.Where(x => x.GetType().Name == "TextComponent").Select(x => x.GetType().GetProperty("Settings").GetValue(x, null));
		var textSetting = textSettings.FirstOrDefault(x => (x.GetType().GetProperty("Text1").GetValue(x, null) as string) == id);
		if (textSetting == null)
		{
			var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
			var textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
			timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));
			textSetting = textComponent.GetType().GetProperty("Settings", BindingFlags.Instance | BindingFlags.Public).GetValue(textComponent, null);
			textSetting.GetType().GetProperty("Text1").SetValue(textSetting, id);
		}
		if (textSetting != null)
			textSetting.GetType().GetProperty("Text2").SetValue(textSetting, text);
	});

    vars.FreezeTimer = new Stopwatch();

    vars.chapters = new Dictionary<int,string> 
	{
        {0, "Unknown"},
        {256, "Wake-Up"},
        {257, "Gorge"},
        {258, "Caves"},
        {259, "Reservoir"},
        {260, "Dam - Secondary"},
        {261, "Dam - Primary"},
        };

    if(timer.CurrentTimingMethod==TimingMethod.RealTime){ // message box prompt to switch to game time comparison
        var mbox = MessageBox.Show(
            "To remove load/pause time, you must be comparing to game time rather than real time. Would you like to switch to game time?",
            "Gorge Autosplitter",
            MessageBoxButtons.YesNo);
        if(mbox==DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

init
{
    current.keys = 0;
    vars.startchapter = 0;
    vars.end = 0; // ==1 during the 3 seconds before the end in dam primary, ==2 until a new chapter is entered (to prevent 2 splits in longer runs)
    vars.posWatcher = new MemoryWatcher<Vector3f>(new DeepPointer(0x35BD180));
    vars.load2 = "False";
    vars.FreezeTime = 0;
}

update
{
    vars.posWatcher.Update(game);
    current.pos = vars.posWatcher.Current;

    if(current.freeze<1 && current.freeze>0){
        vars.FreezeTime = Math.Truncate(current.freeze*100);
    }
    else{
        vars.FreezeTime = 0;
    }
    if(current.freeze == old.freeze){
        vars.FreezeTime = 0;
    }

    if(current.load==0){
        vars.load2 = "True";
    }
    else{
        vars.load2 = "False";
    }

    string chapter2 = vars.chapters[current.chapter];

    if(settings["XP"]) vars.SetTextComponent("X:", current.pos.X.ToString());
    else if(settings["X"]) vars.SetTextComponent("X:", Math.Truncate(current.pos.X).ToString());
    if(settings["YP"]) vars.SetTextComponent("Y:", current.pos.Y.ToString());
    else if(settings["Y"]) vars.SetTextComponent("Y:", Math.Truncate(current.pos.Y).ToString());
    if(settings["ZP"]) vars.SetTextComponent("Z:", current.pos.Z.ToString());
    else if(settings["Z"]) vars.SetTextComponent("Z:", Math.Truncate(current.pos.Z).ToString());
    if(settings["Paused"]) vars.SetTextComponent("Paused:", current.pause1.ToString());
    if(settings["Loading"]) vars.SetTextComponent("Loading:", vars.load2);
    if(settings["CheckpointID"]) vars.SetTextComponent("Checkpoint ID:", current.checkpoint.ToString());
    if(settings["CheckpointCount"]) vars.SetTextComponent("Checkpoint Count:", current.cpcount.ToString());
    if(settings["Chapter"]) vars.SetTextComponent("Chapter:", chapter2);
    if(settings["Mugs"]) vars.SetTextComponent("Mugs:", current.mug.ToString());
    if(settings["FreezeTimer"]) vars.SetTextComponent("Freeze Timer:", vars.FreezeTime.ToString());
}

start
{
    if(old.load==0 && current.load!=0){
        current.keys = 0;
        vars.end = 0;
        vars.startchapter = current.chapter; // used for resetting - has the problem of current.chapter potentially being 0 if the game was just started
        return true;
    }
}

split
{
    if(settings["end"] && current.load!=0 && current.chapter==256 && (old.chapter==261 || old.chapter==260))
        vars.end = 1; // sets a variable when the chapter gets changed back to 256
    if(current.pause!=1 && vars.end==1){ // splits when the game is then paused, which after the variable is set would then have to be the end screen
        vars.end = 2;
        vars.startchapter = 1; // for longer runs which might re-enter the starting chapter
        return true;
    }

    if(current.checkpoint!=old.checkpoint){
        if(settings[current.checkpoint.ToString()]){
            return true;
        }
        if(old.checkpoint.ToString()!="-8.76200479924032E+33" && current.checkpoint.ToString()=="-8.7620047991307E+33"){
            current.keys++;
            return settings["key"+current.keys.ToString()];
        }
    }
    if(current.chapter!=old.chapter){
        current.keys = 0;
        if(vars.end==0 && vars.startchapter!=current.chapter && settings[current.chapter.ToString()]){ // the chapter is used for splitting on the first checkpoint rather than the checkpoint for accuracy
            return true;
        }
        if(vars.end==2){
            vars.end = 0;
        }
    }

    if(current.mug>old.mug){
        return (settings["misd"] && current.mug==5)
            || (settings["m10"] && current.mug%10==0)
            || (settings["m25"] && current.mug%25==0)
            || (settings["m50"] && current.mug%50==0)
            || (settings["masd"] && current.mug==100);
    }
    if(current.vhs>old.vhs){
        return (settings["sac"] && current.vhs==1)
            || (settings["v"])
            || (settings["ftc"] && current.vhs==7);
    }
    if(current.lookout>old.lookout){
        return (settings["l"])
            || (settings["llo"] && current.lookout==3);
    }
    if(current.challenge>old.challenge){
        vars.startchapter = 1; // ensures the timer won't reset when entering a new course
        return (settings["c"])
            || (settings["ftb"] && current.challenge==7);
    }
}

reset
{
    if(old.load==0 && current.load!=0 && current.chapter==vars.startchapter){
        return true;
    }
}

isLoading
{
    return current.pause!=1
        || current.load==0;
}
