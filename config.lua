Config = {}

Config.BottleRecieve = { 1, 6 } -- This is the math random ex. math.random(1, 6) this will give you 1 - 6 bottles when searching a bin.
Config.BottleRecieveSpecial = { 4, 15 } -- This is the math random ex. math.random(4, 15) this will give you 4 - 15 bottles when searching a special bin.
Config.BottleReward = { 1, 4 } -- This is the math random ex. math.random(1, 4) this will give a random payout between 1 - 4

-- Here you add all the bins you are able to search.
Config.BinsAvailable = {
    {objName="prop_bin_01a", special=false},
    {objName="prop_bin_02a", special=false},
    {objName="prop_bin_03a", special=false},
    {objName="prop_bin_04a", special=false},
    {objName="prop_bin_05a", special=false},
    {objName="prop_bin_06a", special=false},
    {objName="prop_bin_07a", special=false},
    {objName="prop_bin_07b", special=false},
    {objName="prop_bin_07c", special=false},
    {objName="prop_bin_07d", special=false},
    {objName="prop_bin_08a", special=false},
    {objName="prop_bin_10a", special=false},
    {objName="prop_bin_10b", special=false},
    {objName="prop_bin_11a", special=false},
    {objName="prop_bin_11b", special=false},
    {objName="ng_proc_binbag_01a", special=false},
    {objName="prop_dumpster_01a" , special=true},
    {objName="prop_dumpster_02a" , special=true},
    {objName="prop_dumpster_02b" , special=true},
    {objName="prop_dumpster_4a"  , special=true},
    {objName="prop_dumpster_4b"  , special=true}
}

-- This is where you add the locations where you sell the bottles.
Config.SellBottleLocations = {
    vector3(29.337753295898, -1770.3348388672, 29.607357025146),
    vector3(388.30194091797, -874.88238525391, 29.295169830322),
    vector3(26.877752304077, -1343.0764160156, 29.497024536133)
}