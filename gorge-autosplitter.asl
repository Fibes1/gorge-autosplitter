state("Gorge-Win64-Shipping")
{
	int pauseCheck: 0x035E03C0, 0x90, 0x8CC; // not paused = 1
	int loadCheck: 0x034E2EB0, 0xAC8, 0x38, 0x2C; // in certain loads that pauseCheck doesn't pick up on = 0
	int levelCheck: 0x035E0228, 0x8, 0x100, 0x408; // wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261
	int endCheck: 0x034FBD38, 0x368, 0x410, 0x110, 0x7D8; // on end screen = 4
	float vhsCheck: 0x034FBD38, 0x68, 0x4D0, 0x560, 0x168, 0x3C; // changes when a vhs tape is collected, does not require achievements to be reset
	byte challengeCheck: 0x035E0228, 0x8, 0x378, 0x30; // number of challenge courses completed in under par time
	int mugCheck: 0x035E0228, 0x8, 0x360, 0xA0; // number of mugs collected
	int lookoutCheck: 0x035E0228, 0x8, 0x360, 0xD0; // number of lookouts visited
	int vhs2Check: 0x035E0228, 0x8, 0x360, 0x140; // number of vhs tapes collected
}

startup
{
	settings.Add("ILMode", false, "IL Mode");
	settings.Add("AreaSplit", true, "Split when entering a new area");

	settings.Add("VHSSplit", false, "VHS tape splits");
	settings.Add("VHS1Split", false, "Split on each VHS tape collected", "VHSSplit");
	settings.Add("VHS7Split", false, "Split after collecting all VHS tapes", "VHSSplit");
	settings.Add("VHSachSplit", false, "Split when getting the VHS tape achievements", "VHSSplit");

	settings.Add("MugSplit", false, "Mug splits");
	settings.Add("Mug10Split", false, "Split every 10 mugs collected", "MugSplit");
	settings.Add("Mug25Split", false, "Split every 25 mugs collected", "MugSplit");
	settings.Add("Mug50Split", false, "Split every 50 mugs collected", "MugSplit");
	settings.Add("Mug100Split", false, "Split after collecting 100 mugs", "MugSplit");
	settings.Add("MugachSplit", false, "Split when getting the mug achievements", "MugSplit");

	settings.Add("LookSplit", false, "Lookout splits");
	settings.Add("Look1Split", false, "Split on each lookout visited", "LookSplit");
	settings.Add("Look3Split", false, "Split after visiting all lookouts", "LookSplit");

	settings.Add("ChalSplit", false, "Challenge course splits");
	settings.Add("Chal1Split", false, "Split on each challenge course completed", "ChalSplit");
	settings.Add("Chal7Split", false, "Split after completing all challenge courses", "ChalSplit");

	settings.SetToolTip("ILMode", "Enables resetting when rewinding chapter or exiting to the main menu");
	settings.SetToolTip("VHSSplit", "Don't select more than 1");
	settings.SetToolTip("MugSplit", "Don't select more than 1");
	settings.SetToolTip("LookSplit", "Don't select more than 1");
	settings.SetToolTip("ChalSplit", "Don't select more than 1");

	if (timer.CurrentTimingMethod == TimingMethod.RealTime){
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
	if(settings["VHS1Split"] && current.vhsCheck != old.vhsCheck){
		return true;
	}
	if((settings["VHS7Split"]||settings["VHSachSplit"]) && old.vhs2Check==6 && current.vhs2Check==7){
		return true;
	}
	if(settings["VHSachSplit"] && old.vhs2Check==0 && current.vhs2Check==1){
		return true;
	}
	if(settings["Chal1Split"] && current.challengeCheck > old.challengeCheck){
		return true;
	}
	if(settings["Chal7Split"] && old.challengeCheck==6 && current.challengeCheck==7){
		return true;
	}
// theres probably a much better way to do these mug splits
	if(settings["Mug10Split"] && (current.mugCheck==10||current.mugCheck==20||current.mugCheck==30||current.mugCheck==40||current.mugCheck==50||current.mugCheck==60||current.mugCheck==70||current.mugCheck==80||current.mugCheck==90||current.mugCheck==100) && current.mugCheck != old.mugCheck){
		return true;
	}
	if(settings["Mug25Split"] && (current.mugCheck==25||current.mugCheck==50||current.mugCheck==75||current.mugCheck==100) && current.mugCheck != old.mugCheck){
		return true;
	}
	if(settings["Mug50Split"] && (current.mugCheck==50||current.mugCheck==100) && current.mugCheck != old.mugCheck){
		return true;
	}
	if((settings["Mug100Split"]||settings["MugachSplit"]) && current.mugCheck==100 && old.mugCheck==99){
		return true;
	}
	if(settings["MugachSplit"] && current.mugCheck==5 && old.mugCheck==4){
		return true;
	}
	if(settings["Look1Split"] && current.lookoutCheck > old.lookoutCheck){
		return true;
	}
	if(settings["Look3Split"] && current.lookoutCheck==3 && old.lookoutCheck==2){
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
