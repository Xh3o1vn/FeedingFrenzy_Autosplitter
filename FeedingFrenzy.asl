state("FeedingFrenzy", "5.7.18.1")
{
    bool stageLoading : "FeedingFrenzy.exe", 0xC10B4, 0x118, 0x178, 0x198;
    bool notMenu : "FeedingFrenzy.exe", 0xC10B4, 0x118, 0x30, 0x10, 0xC, 0x120, 0x4, 0x1D4;
    string5 firstLoading : "FeedingFrenzy.exe", 0xC0CB6;
    int stage : "FeedingFrenzy.exe", 0xC0880, 0x1E4;
    int foodBank : "FeedingFrenzy.exe", 0xC0880, 0x1A8;
    float timeAttackClock: "FeedingFrenzy.exe", 0xC0880, 0x58, 0x10;
}

state("FeedingFrenzy", "2.9.16.1")
{
    bool stageLoading : "FeedingFrenzy.exe", 0xBEE58, 0x118, 0x178, 0x198;
    bool notMenu : "FeedingFrenzy.exe", 0xBEE58, 0x118, 0x30, 0x10, 0xC, 0x120, 0x4, 0x1D4;
    string5 firstLoading : "FeedingFrenzy.exe", 0xBE4F8;
    int stage : "FeedingFrenzy.exe", 0xBE980, 0x1C0;
    int foodBank : "FeedingFrenzy.exe", 0xBE980, 0x184;
    float timeAttackClock: "FeedingFrenzy.exe", 0xBE980, 0x34, 0x10;
}

state("FeedingFrenzy", "sprout")
{
    bool stageLoading : "feedingfrenzy.exe", 0xB937C, 0x118, 0x178, 0x198;
    bool notMenu : "feedingFrenzy.exe", 0xB937C, 0x118, 0x30, 0x10, 0xC, 0x120, 0x4, 0x1D4;
    string5 firstLoading : "feedingfrenzy.exe", 0xB84C0;
    int stage : "feedingfrenzy.exe", 0xB894C, 0x128;
    int foodBank : "feedingfrenzy.exe", 0xB894C, 0xEC;
    float timeAttackClock: "feedingfrenzy.exe", 0xB894C, 0x24, 0x10;
}

startup
{
    settings.Add("SingleStage", false, "Single Stage Split");
}

init
{
    if (modules.First().ModuleMemorySize > 876000)
    {
        version = "5.7.18.1"; // 876544
    }

    else if (modules.First().ModuleMemorySize > 872000)
    {
        version = "2.9.16.1"; // 872448
    }

    else if (modules.First().ModuleMemorySize > 843000)    
    {
        version = "sprout"; // 843776
    }
}

// Timer start at -2.20
start
{
    if (current.firstLoading.Length > 1 && current.stageLoading)
    {
        return true;
    }
}

split
{   
    // Stage Split
    if (current.stage > old.stage)
    {
        return !settings["SingleStage"];
    }

    // Any% End
    if (current.stage == 39)
    {
        return (current.foodBank > old.foodBank || current.timeAttackClock > old.timeAttackClock);
    }

    // Single Stage End 
    if (current.foodBank > old.foodBank)
    {
        return settings["SingleStage"];
    }
}

reset
{
    if (!current.notMenu && old.notMenu)
    {
        return true;
    }
}