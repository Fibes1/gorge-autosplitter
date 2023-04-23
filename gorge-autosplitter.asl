state("Gorge-Win64-Shipping")
{
	int pauseCheck: 0x035E03C0, 0x90, 0x8CC; // not paused = 1
	int loadCheck: 0x034E2EB0, 0xAC8, 0x38, 0x2C; // in certain loads that pauseCheck doesn't pick up on = 0
	int chapterCheck: 0x035E0228, 0x8, 0x100, 0x408; // wake-up = 256, gorge = 257, caves = 258, reservoir = 259, secondary = 260, primary = 261, sometimes the first chapter that you play after opening the game can also be 0
	byte challengeCheck: 0x035E0228, 0x8, 0x378, 0x30; // number of challenge courses completed in under par time
	byte mugCheck: 0x035E0228, 0x8, 0x360, 0xA0; // number of mugs collected
	byte lookoutCheck: 0x035E0228, 0x8, 0x360, 0xD0; // number of lookouts visited
	byte vhsCheck: 0x035E0228, 0x8, 0x360, 0x140; // number of vhs tapes collected
}

startup
{
	settings.Add("Settings", true, "Settings");
	settings.Add("Location", true, "Location Splits");
	settings.Add("Achievement", false, "Achievement Splits");

	settings.Add("WUStart", true, "Start when entering Wake-Up", "Settings");
	settings.Add("WUReset", true, "Reset when entering Wake-Up", "Settings");
	settings.Add("Start", false, "Start when entering any chapter", "Settings");
	settings.Add("Reset", false, "Reset when entering any chapter", "Settings");
	settings.Add("Basic", false, "Basic chapter splitting", "Settings");
	settings.Add("ILMode", false, "IL Mode", "Settings");

	settings.Add("A/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint78", true, "Entering Gorge", "Location");
	settings.Add("A/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint79", true, "Entering Caves", "Location");
	settings.Add("A/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint80", true, "Entering Reservoir", "Location");
	settings.Add("A/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint81_0", true, "Entering Dam - Secondary", "Location");
	settings.Add("A/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint83", true, "Entering Dam - Primary", "Location");
	settings.Add("DP", true, "Completed Dam - Primary", "Location");
	settings.Add("MidChapter", false, "Specific checkpoints", "Location");

	settings.Add("/00_tutorial.00_tutorial:PersistentLevel.BP_ToggleCheckPoint88", false, "Wake-Up - Wall Jumps Section", "MidChapter");
	settings.Add("/00_tutorial.00_tutorial:PersistentLevel.BP_ToggleCheckPoint99", false, "Wake-Up - Oil canister", "MidChapter");
	settings.Add("/01_gorge.01_gorge:PersistentLevel.BP_ToggleCheckPoint20", false, "Gorge - Spinning platform", "MidChapter");
	settings.Add("/02_cave.02_cave:PersistentLevel.BP_ToggleCheckPoint19", false, "Caves - Spiral room", "MidChapter");
	settings.Add("/02_cave.02_cave:PersistentLevel.BP_ToggleCheckPoint26", false, "Caves - Next spiral", "MidChapter");
	settings.Add("/02_cave.02_cave:PersistentLevel.BP_ToggleCheckPoint28", false, "Caves - Slide", "MidChapter");
	settings.Add("/02_cave.02_cave:PersistentLevel.BP_ToggleCheckPoint36", false, "Caves - End section", "MidChapter");
	settings.Add("/03_cliff.03_cliff:PersistentLevel.BP_ToggleCheckPoint4", false, "Reservoir - Main area", "MidChapter");
	settings.Add("/03_cliff.03_cliff:PersistentLevel.BP_ToggleCheckPoint9", false, "Reservoir - After indoors section", "MidChapter");
	settings.Add("/03_cliff.03_cliff:PersistentLevel.BP_ToggleCheckPoint11", false, "Reservoir - Gate", "MidChapter");
	settings.Add("/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint99", false, "Secondary - Left Side Level 4", "MidChapter");
	settings.Add("/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint104", false, "Secondary - Left Side Level 7", "MidChapter");
	settings.Add("/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint10", false, "Secondary - Left Side Key Room", "MidChapter");
	settings.Add("/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint16", false, "Secondary - Right Side Before launches", "MidChapter");
	settings.Add("/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint18", false, "Secondary - Right Side Upper Area", "MidChapter");
	settings.Add("/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint28", false, "Secondary - Right Side Key Room", "MidChapter");
	settings.Add("Key1", false, "Secondary - First key inserted", "MidChapter");
	settings.Add("Key2", false, "Secondary - Second key inserted", "MidChapter");
	settings.Add("/05_finally_a.05_finally_a:PersistentLevel.BP_ToggleCheckPoint2", false, "Primary - Pipe room", "MidChapter");
	settings.Add("/05_finally_c.05_finally_c:PersistentLevel.BP_ToggleCheckPoint4", false, "Primary - After seesaw room", "MidChapter");
	settings.Add("/05_finally_c.05_finally_c:PersistentLevel.BP_ToggleCheckPoint7", false, "Primary - Slide", "MidChapter");
	settings.Add("/05_finally_d.05_finally_d:PersistentLevel.BP_ToggleCheckPoint11", false, "Primary - End section", "MidChapter");

	settings.Add("VHSSplit", false, "VHS tapes", "Achievement");
	settings.Add("VHS1Split", false, "Split on each VHS tape collected", "VHSSplit");
	settings.Add("VHS7Split", false, "Split after collecting all VHS tapes", "VHSSplit");
	settings.Add("VHSachSplit", false, "Split when getting the VHS tape achievements", "VHSSplit");

	settings.Add("MugSplit", false, "Mugs", "Achievement");
	settings.Add("Mug10Split", false, "Split every 10 mugs collected", "MugSplit");
	settings.Add("Mug25Split", false, "Split every 25 mugs collected", "MugSplit");
	settings.Add("Mug50Split", false, "Split every 50 mugs collected", "MugSplit");
	settings.Add("Mug100Split", false, "Split after collecting 100 mugs", "MugSplit");
	settings.Add("MugachSplit", false, "Split when getting the mug achievements", "MugSplit");

	settings.Add("LookSplit", false, "Lookout splits", "Achievement");
	settings.Add("Look1Split", false, "Split on each lookout visited", "LookSplit");
	settings.Add("Look3Split", false, "Split after visiting all lookouts", "LookSplit");

	settings.Add("ChalSplit", false, "Challenge course splits", "Achievement");
	settings.Add("Chal1Split", false, "Split on each challenge course completed", "ChalSplit");
	settings.Add("Chal7Split", false, "Split after completing all challenge courses", "ChalSplit");

	settings.SetToolTip("WUStart", "The timer will start when entering Wake-Up.");
	settings.SetToolTip("WUReset", "The timer will automatically reset when entering Wake-Up from chapter select, or when rewinding chapter in Wake-Up.");
	settings.SetToolTip("Start", "The timer will start when entering any chapter, rather than just Wake-Up. \n"+"Enabled automatically for IL Mode.");
	settings.SetToolTip("Reset", "The timer will automatically reset when entering any chapter, rather than just Wake-Up. \n"+"Enabled automatically for IL Mode.");
	settings.SetToolTip("Basic", "The timer will: \n"+"- Split when entering any chapter, regardless of settings \n"+"- Split earlier than usual when completing the chapter for accuracy \n"+"- Split on any checkpoint rather than just the first \n"+"Enabled automatically for IL Mode.");
	settings.SetToolTip("ILMode","Enables the settings: \n"+"- Start when entering any chapter \n"+"- Reset when entering any chapter \n"+"- Basic chapter splitting \n"+"This is a separate setting for convenience.");
	settings.SetToolTip("Achievement", "Don't select more than 1 option from each section, or the timer may split multiple times at once. \n"+"You must reset your achievements for the splits to work, e.g. if you already have all VHS tapes, then collecting one again will not split.");
	settings.SetToolTip("VHSSplit", "Don't select more than 1 option");
	settings.SetToolTip("MugSplit", "Don't select more than 1 option");
	settings.SetToolTip("LookSplit", "Don't select more than 1 option");
	settings.SetToolTip("ChalSplit", "Don't select more than 1 option");

	vars.dpTimer = new Stopwatch();
	vars.firstCP = new List<string>(){
	"/zz_persistent.zz_persistent:PersistentLevel.zAreaSpawnPoint_tut", // wake-up
	"/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint78", // gorge
	"/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint79", // caves
	"/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint80", // reservoir
	"/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint81_0", // secondary
	"/zz_persistent.zz_persistent:PersistentLevel.BP_ToggleCheckPoint83", // primary
	};
	vars.ten = new List<int>(){10,20,30,40,50,60,70,80,90,100};
	vars.tfive = new List<int>(){25,50,75,100};
	vars.fifty = new List<int>(){50,100};
	vars.mugach = new List<int>(){5,100};
	vars.vhsach = new List<int>(){1,7};

	if(timer.CurrentTimingMethod == TimingMethod.RealTime){ // message box prompt to switch to game time comparison
		var mbox = MessageBox.Show(
			"To remove load/pause time, you must be comparing to game time rather than real time. Would you like to switch to game time?",
			"Gorge Autosplitter",
			MessageBoxButtons.YesNo);

		if(mbox == DialogResult.Yes)
			timer.CurrentTimingMethod = TimingMethod.GameTime;
	}
}

init
{
	current.checkpointString = null;
	current.lastSaved = null;
	current.keys = 0;
}

update
{
// this reads the save file for the current checkpoint
// the save file is used since chapterCheck can sometimes default to 0 and can't do more specific splitting, and any current checkpoint memory addresses don't change with rewind chapter & have some repeats
// checking when the file was last saved is used since reading the file whilst its being written to by the game can sometimes cause the game to not save at all
	string path = Environment.GetEnvironmentVariable("AppData")+"\\..\\local\\Gorge\\Saved\\SaveGames\\default_slot.sav"; // get save file path
	current.lastSaved = File.GetLastWriteTime(path); // get time of last save
	if(current.lastSaved!=old.lastSaved){
		string save = File.ReadAllText(path); // reads the save file
		current.checkpointString = save.Substring(save.LastIndexOf("Maps")+4, save.LastIndexOf("Checked")-save.LastIndexOf("Maps")-9); // gets the text (roughly) between the last appearance of "Maps" and the last appearance of "Checked", which is the current checkpoint string. pretty scuffed, can probably be improved
	}
}

onStart
{
	current.keys = 0;
	vars.dpTimer.Reset();
}

start
{
	if(settings["WUStart"] && current.pauseCheck==1 && current.loadCheck!=0 && current.checkpointString.ToString()=="/zz_persistent.zz_persistent:PersistentLevel.zAreaSpawnPoint_tut"){
		return true;
	}
	if((settings["ILMode"] || settings["Start"]) && current.pauseCheck==1 && current.loadCheck!=0 && vars.firstCP.Contains(current.checkpointString.ToString())){
		return true;
	}
}

split
{
	if(current.checkpointString!=old.checkpointString){
		if(settings[current.checkpointString.ToString()]){
			return true;
		}
		if(!settings["ILMode"] && !settings["Basic"] && settings["A"+current.checkpointString.ToString()]){ // disables splits at the start of chapters if IL Mode/Basic chapter splitting is on, since those are then handled separately for accuracy
			return true;
		}
		if(current.checkpointString.ToString()=="/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPointSmartDam_2" && old.checkpointString.ToString()!="/04_dam.04_dam:PersistentLevel.BP_ToggleCheckPoint3"){ // keeps track of keys inserted in secondary dam
			current.keys++;
		}
	}
	if((settings["ILMode"]||settings["Basic"]) && current.chapterCheck>old.chapterCheck){
		return true;
	}
	if(settings["DP"] && (old.chapterCheck==261||old.chapterCheck==260) && current.chapterCheck==256) vars.dpTimer.Restart(); // the stopwatch waits 3 seconds after the chapter value is set back to 256 before splitting - this stops the timer at the same time that the igt stops. last chapter must be primary or secondary as these are the only realistic scenarios, and it prevents accidental splits in obscure scenarios, like when re-entering wake-up
	if(vars.dpTimer.ElapsedMilliseconds>=3000){
		vars.dpTimer.Reset();
		return true;
	}
	if(settings["Key1"] && current.keys==1 && old.keys==0){
		return true;
	}
	if(settings["Key2"] && current.keys==2 && old.keys==1){
		return true;
	}
	if(settings["VHS1Split"] && current.vhsCheck>old.vhsCheck){
		return true;
	}
	if((settings["VHS7Split"]) && old.vhsCheck==6 && current.vhsCheck==7){
		return true;
	}
	if(settings["VHSachSplit"] && current.vhsCheck!=old.vhsCheck && vars.vhsach.Contains(current.vhsCheck)){
		return true;
	}
	if(settings["Chal1Split"] && current.challengeCheck>old.challengeCheck){
		return true;
	}
	if(settings["Chal7Split"] && old.challengeCheck==6 && current.challengeCheck==7){
		return true;
	}
	if(settings["Mug10Split"] && current.mugCheck!=old.mugCheck && vars.ten.Contains(current.mugCheck)){
		return true;
	}
	if(settings["Mug25Split"] && current.mugCheck!=old.mugCheck && vars.tfive.Contains(current.mugCheck)){
		return true;
	}
	if(settings["Mug50Split"] && current.mugCheck!=old.mugCheck && vars.fifty.Contains(current.mugCheck)){
		return true;
	}
	if(settings["Mug100Split"] && current.mugCheck==100 && old.mugCheck==99){
		return true;
	}
	if(settings["MugachSplit"] && current.mugCheck!=old.mugCheck && vars.mugach.Contains(current.mugCheck)){
		return true;
	}
	if(settings["Look1Split"] && current.lookoutCheck>old.lookoutCheck){
		return true;
	}
	if(settings["Look3Split"] && current.lookoutCheck==3 && old.lookoutCheck==2){
		return true;
	}
}

reset
{
	if(settings["WUReset"] && current.loadCheck==0 && current.pauseCheck==1 && current.checkpointString.ToString()=="/zz_persistent.zz_persistent:PersistentLevel.zAreaSpawnPoint_tut"){
		return true;
	}
	if((settings["ILMode"] || settings["Reset"]) && current.loadCheck==0 && current.pauseCheck==1 && vars.firstCP.Contains(current.checkpointString.ToString())){
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
