state("Gorge-Win64-Shipping")
{
    int pause: 0x035E03C0, 0x90, 0x8CC; // not paused = 1
    int load: 0x034E2EB0, 0xAC8, 0x38, 0x2C; // loading or main menu = 0

    double checkpoint: 0x034F9308, 0x28, 0x1C0, 0x100, 0x2D4; // unique number for the current checkpoint, theres a lot of these addresses but this seems to be the only one that has no repeats. doesnt change when rewinding chapter in most cases
    int chapter: 0x035E0228, 0x8, 0x100, 0x408; // wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261, sometimes the first chapter that you play after opening the game can also be 0

    byte mug: 0x035E0228, 0x8, 0x360, 0xA0; // number of mugs collected
    byte vhs: 0x035E0228, 0x8, 0x360, 0x140; // number of vhs tapes collected
    byte challenge: 0x035E0228, 0x8, 0x378, 0x30; // number of challenge courses completed in under par time
    byte lookout: 0x035E0228, 0x8, 0x360, 0xD0; // number of lookouts visited
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

    if(settings["end"] && current.load!=0 && current.chapter==256 && (old.chapter==261 || old.chapter==260))
        vars.end = 1; // sets a variable when the chapter gets changed back to 256
    if(current.pause!=1 && vars.end==1){ // splits when the game is then paused, which after the variable is set would then have to be the end screen
        vars.end = 2;
        vars.startchapter = 0; // for longer runs which might re-enter the starting chapter
        return true;
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
            || (settings["ftb"] && current.vhs==7);
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
