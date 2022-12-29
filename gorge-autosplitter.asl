state("Gorge-Win64-Shipping")
{
    int pauseCheck: 0x035E03C0, 0x90, 0x8CC;
// not paused = 1
    int loadCheck: 0x034E2EB0, 0xAC8, 0x38, 0x2C;
// in certain loads that pauseCheck doesn't pick up on = 0
    int levelCheck: 0x035E0228, 0x8, 0x100, 0x408;
// wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261
    int endCheck: 0x034FBD38, 0x368, 0x410, 0x110, 0x7D8;
// on end screen = 4
    float vhsCheck: 0x034FBD38, 0x68, 0x4D0, 0x560, 0x168, 0x3C;
// changes when a vhs tape is collected
    byte challengeCheck: 0x035E0228, 0x8, 0x378, 0x30;
// amount of challenge courses completed in under par time
}

startup
{
	settings.Add("ILMode", false, "IL Mode");
	settings.SetToolTip("ILMode", "Enables resetting when rewinding chapter or exiting to the main menu");
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
    if(settings["ILMode"] && current.loadCheck==0){
        return true;
    }
}

start
{
    if(current.pauseCheck==1 && current.loadCheck!=0){
        return true;
    }
}

split
{
    if(settings["AreaSplit"] && current.levelCheck > old.levelCheck){
        return true;
    }
    if(current.endCheck == 4 && current.endCheck != old.endCheck){
        return true;
    }
    if(settings["VHSSplit"] && current.vhsCheck != old.vhsCheck){
        return true;
    }
    if(old.challengeCheck==6 && current.challengeCheck==7){ // for all achievements and all challenge courses runs
        return true;
    }
}

isLoading
{
    if(current.pauseCheck!=1){
        return true;
    }
    if(current.loadCheck==0){
        return true;
    }
    if(current.pauseCheck==1 && current.loadCheck!=0){
        return false;
    }
}
