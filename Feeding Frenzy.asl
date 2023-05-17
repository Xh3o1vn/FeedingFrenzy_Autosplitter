state("FeedingFrenzy", "5.7.18.1")
{
    bool stageLoading : "FeedingFrenzy.exe", 0xC10B4, 0x118, 0x178, 0x198;
    bool isMenu : "FeedingFrenzy.exe", 0xC10B4, 0x118, 0x30, 0x10, 0xC, 0x120, 0x4, 0x1D4;
    string1 firstLoading : "FeedingFrenzy.exe", 0xC0CB6;
    int stage : "FeedingFrenzy.exe", 0xC0880, 0x1E4;
    int foodBank : "FeedingFrenzy.exe", 0xC0880, 0x1A8;
    float timeAttackClock: "FeedingFrenzy.exe", 0xC0880, 0x58, 0x10;
}

state("FeedingFrenzy", "2.9.16.1")
{
    bool stageLoading : "FeedingFrenzy.exe", 0xBEE58, 0x118, 0x178, 0x198;
    bool isMenu : "FeedingFrenzy.exe", 0xBEE58, 0x118, 0x30, 0x10, 0xC, 0x120, 0x4, 0x1D4;
    string1 firstLoading : "FeedingFrenzy.exe", 0xBE4F8;
    int stage : "FeedingFrenzy.exe", 0xBE980, 0x1C0;
    int foodBank : "FeedingFrenzy.exe", 0xBE980, 0x184;
    float timeAttackClock: "FeedingFrenzy.exe", 0xBE980, 0x34, 0x10;
}

state("FeedingFrenzy", "sprout")
{
    bool stageLoading : "feedingfrenzy.exe", 0xB937C, 0x118, 0x178, 0x198;
    bool isMenu : "feedingFrenzy.exe", 0xB937C, 0x118, 0x30, 0x10, 0xC, 0x120, 0x4, 0x1D4;
    string1 firstLoading : "feedingfrenzy.exe", 0xB84C0;
    int stage : "feedingfrenzy.exe", 0xB894C, 0x128;
    int foodBank : "feedingfrenzy.exe", 0xB894C, 0xEC;
    float timeAttackClock: "feedingfrenzy.exe", 0xB894C, 0x24, 0x10;
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
    if (current.stageLoading == true && current.firstLoading.Length > 0)
    {
        return true;
    }
}

split
{   
    // Stage Split
    if (current.stage > old.stage)
    {
        return true;
    }

    // End
    if (current.stage == 39)
    {
        return (current.foodBank > old.foodBank || current.timeAttackClock > old.timeAttackClock);
    }
}

reset
{
    if (current.isMenu == false && old.isMenu == true)
    {
        return true;
    }
}



