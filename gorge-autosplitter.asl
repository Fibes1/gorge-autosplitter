state("Gorge-Win64-Shipping")
{
    int gameState: 0x035E03C0, 0xA0, 0xE8, 0x150;
    // WITH IGT ENABLED: in-game = 302, in intro = 287, on rewind chapter or main menu selection screens = 509, pause = 447, in-game with object frozen = 346
    // WITH IGT DISABLED:  in-game = 246, in intro = 241, on rewind chapter or main menu selection screens = 483, pause = 421, in-game with object frozen = 300
    // note that these values also change when prompts are on screen, but thats a rare enough scenario that someone would pause in that time for it to be ignored
    int levelCheck: 0x035E0228, 0x8, 0x100, 0x408;
    // wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261
    int endCheck: 0x034FBD38, 0x368, 0x410, 0x110, 0x7D8;
    // on end screen = 4
}

startup
{
	settings.Add("ILMode", false, "IL Mode");
	settings.SetToolTip("ILMode", "Enables IL timing, meaning the timer will start when entering a level from chapter select and will automatically reset when rewinding chapter or going back to the main menu");

	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{
		var mbox = MessageBox.Show(
			"To remove load/pause time, you must be comparing to game time rather than real time. Would you like to switch to game time?",
			"Gorge Autosplitter",
			MessageBoxButtons.YesNo);

		if (mbox == DialogResult.Yes)
			timer.CurrentTimingMethod = TimingMethod.GameTime;
	}
}

reset
{
    if(settings["ILMode"] && current.gameState == 509){
        return true;
    }
    // for no igt
    if(settings["ILMode"] && current.gameState == 483){
        return true;
    }
}

start
{
    if(settings["ILMode"] && current.gameState == 302){
        return true;
    }
    if(current.gameState == 287){
        return true;
    }
    // for no igt
    if(settings["ILMode"] && current.gameState == 246){
        return true;
    }
    if(current.gameState == 241){
        return true;
    }
}

split
{
    if(current.levelCheck > old.levelCheck){
        return true;
    }
    if(current.endCheck == 4){
        return true;
    }
}

isLoading
{
    if(current.gameState == 447){
        return true;
    }
    if(current.gameState == 302){
        return false;
    }
    if(current.gameState == 287){
        return false;
    }
    if(current.gameState == 346){
        return false;
    }
    // for no igt
    if(current.gameState == 421){
        return true;
    }
    if(current.gameState == 246){
        return false;
    }
    if(current.gameState == 241){
        return false;
    }
    if(current.gameState == 300){
        return false;
    }
}
