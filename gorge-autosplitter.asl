state("Gorge-Win64-Shipping")
{
    int gameState: 0x035E03C0, 0xA0, 0xE8, 0x150;
// this changes based on the hud elements on screen, but in almost all cases in game is less than 400 and in a menu is above 400. exceptions are certain loading screens and the main menu.
    int levelCheck: 0x035E0228, 0x8, 0x100, 0x408;
// wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261
    int endCheck: 0x034FBD38, 0x368, 0x410, 0x110, 0x7D8;
// on end screen = 4
    float vhsCheck: 0x034FBD38, 0x68, 0x4D0, 0x560, 0x168, 0x3C;
// changes when a vhs tape is collected
}

startup
{
	settings.Add("ILMode", false, "IL Mode");
	settings.SetToolTip("ILMode", "Enables IL timing, meaning the timer will start when entering a level from chapter select and will automatically reset when rewinding chapter or going back to the main menu");
	settings.Add("AreaSplit", true, "Split when entering a new area");
	settings.Add("VHSSplit", false, "Split on collecting VHS tapes");

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
    if(settings["ILMode"] && current.gameState==509 && current.gameState!=old.gameState){
        return true;
    }
    if(settings["ILMode"] && current.gameState==483 && current.gameState!=old.gameState){
        return true;
    }
}

start
{
    if(current.gameState==241){
        return true;
    }
    if(current.gameState==287){
        return true;
    }
    if(settings["ILMode"] && current.gameState==302){
        return true;
    }
    if(settings["ILMode"] && current.gameState==246){
        return true;
    }
}

split
{
    if(settings["AreaSplit"] && current.levelCheck > old.levelCheck){
        return true;
    }
    if(current.endCheck == 4){
        return true;
    }
    if(settings["VHSSplit"] && current.vhsCheck != old.vhsCheck){
        return true;
    }
}

isLoading
{
    if(current.gameState>400){
        return true;
    }
// for rewind chapter, entering from main menu, etc
    if(current.gameState==246){
        return false;
    }
// same as above but for with igt on
    if(current.gameState==302){
        return false;
    }
// for rewind chapter, entering from main menu, etc, with the random scenario where the banner shows immediately
    if(current.gameState==260){
        return false;
    }
// same as above but for with igt on
    if(current.gameState==306){
        return false;
    }
// the unpausing checks below are needed as you won't always unpause with no hud elements on screen, unlike with rewind chapter or entering from main menu
// for unpausing
    if(old.gameState==284 && current.gameState!=old.gameState && current.gameState!=221){
        return false;
    }
// for unpausing with igt on
    if(old.gameState==228 && current.gameState!=old.gameState && current.gameState!=242){
        return false;
    }
}
