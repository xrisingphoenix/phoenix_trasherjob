Config = {}

Config.UseNewESX = true -- New ESX has a new Export. Enable if you need this

Config.Fuel = function(vehicle)
    -- exports['LegacyFuel']:SetFuel(vehicle, 100)
    -- exports['myFuel']:SetFuel(vehicle, 100)
end

Config.MSG = function(msg)
    ESX.ShowNotification(msg) 
    --exports['okokNotify']:Alert("Trasher Job", msg, 3000, 'info') 
    --If you use okokNotify, uncomment this or use your own Notify Script
end

Config.UseOxTarget = false -- true if you use ox_target

Config.Locale = 'en'

Config.Bail = 2500 -- Amount of Bail a Player has to Pay for the Vehicle. When hes bringing it back, he gets the Money back. No Bail -> set to 0

Config.Webhook = '' --Your Webhook Link

Config.UseMiniGame = false -- Only for Using K5_Skillcheck https://github.com/kac5a/k5_skillcheck

Config.UseAnProgbar = false --Only for Using An_Progbar https://github.com/aymannajim/an_progBar

Config.Moneytype = 'bank' -- 'bank', 'black_money', 'money'

Config.Reward = 200  -- Reward for each Trashcan.

Config.EnableZones = true -- Enable Zones (see Config.Zones at bottom)

Config.Bonus = 1000 -- Bonus for each 10th Trashcan (only if Config.EnableZones is false)

Config.BonusPerTrash = 50  -- Bonus for completing the Job with all Trashcans (only if Config.EnableZones is true)

Config.VisibleforOtherPlayer = true -- Trashcan visible for other Players?

---- Cooldown
Config.EnableCooldown = true

Config.ClientCooldown = 10--[[Minute]] * 1000 * 60 -- Cooldown to prevent to do the same zone again

Config.ServerCooldown = 1--[[Minute]] * 1000 * 60 -- Cooldown to prevent to do the same zone again for everyone
---- 

Config.Job = {
    enable = false,
    name = 'trasher'
}

Config.StartMission = {
    {
        startcoords = vector3(499.9894, -651.9183, 24.9093),
        pedname = 's_m_y_airworker',
        pedheading = 270.8186,
        vehiclespawnname = 'trash2',
        vehiclespawncoords = vector4(510.3752, -654.7561, 24.7512, 179.6859),
    }
}

Config.Clothing = {
    ["male"] = {
        ["Torso"] = { id = 71, txt = 0},
        ["TShirt"] = { id = 155, txt = 0},
        ["Arms"] = { id = 66, txt = 0},
        ["Pants"] = { id = 53, txt = 0},
        ["Shoes"] = { id = 27, txt = 0},
        ["Hat"] = { id = 5, txt = 0},
    },
    ["female"] = {
        ["Torso"] = { id = 67, txt = 0},
        ["TShirt"] = { id = 191, txt = 0},
        ["Arms"] = { id = 75, txt = 0},
        ["Pants"] = { id = 55, txt = 0},
        ["Shoes"] = { id = 26, txt = 0},
        ["Hat"] = { id = 5, txt = 0},
    }
}


Config.Chance = 100 -- Chance to even get a reward from RewardList (100 = 100%) - set to 0 to disable 
Config.RewardList = {
    {item = "black_money", chance = 5, amount = {200, 700}},    -- 5% Chance, Amount: 200 to 700
    {item = "casino_chips", chance = 15, amount = {50, 100}},       -- 15% Chance, Amount: 1 to 5
    {item = "coke", chance = 2, amount = {1, 2}},            -- 20% Chance, Amount: 1 to 2
    {item = "lighter", chance = 40, amount = {1, 1}},           -- 30% Chance, Amount: 1 to 3
    {item = "metal", chance = 30, amount = {1, 5}},   -- 20% Chance, Amount: 1 to 10
}


Config.Zones = {
    -- The Trashcan heading shows to the back of the player
    ["Vespucci Beach"] = {
        vector4(-1255.1630, -866.0649, 12.3271, 127.7181),
        vector4(-1379.9288, -875.0063, 14.2792, 46.6056),
        vector4(-1386.5310, -966.4913, 9.3006, 126.6987),
        vector4(-1336.2352, -1057.3573, 7.4427, 121.9257),
        vector4(-1328.1361, -1087.8826, 6.9719, 27.3108),
        vector4(-1318.1592, -1159.2786, 4.8605, 183.6614),
        vector4(-1329.4347, -1192.9816, 4.9113, 356.6694),
        vector4(-1305.6124, -1244.7618, 4.7818, 16.5129),
        vector4(-1241.5565, -1356.7318, 4.0386, 111.6555),
        vector4(-1199.4954, -1467.2944, 4.3348, 36.1279),
        vector4(-1167.3198, -1521.8759, 4.3723, 214.6263),
        vector4(-1123.4629, -1591.7235, 4.4002, 305.8413),
        vector4(-1085.2694, -1595.0155, 4.3921, 124.7920),
        vector4(-1004.9964, -1575.9767, 5.1364, 286.2723),
        vector4(-1176.8815, -1274.2716, 5.8690, 293.2883),
        vector4(-1187.9678, -1226.7695, 6.9974, 19.7695),
        vector4(-1216.0475, -1126.0294, 7.8737, 288.1608),
        vector4(-1248.7579, -1035.1937, 8.5578, 289.2156),
        vector4(-1218.0499, -890.7308, 12.6952, 212.1706),
        vector4(-1133.0559, -917.4585, 2.8662, 119.7981),
        vector4(-1103.4771, -965.6371, 2.4192, 120.8400),
        vector4(-1069.2737, -1024.3817, 2.0829, 119.0135),
        vector4(-1016.9603, -1115.5334, 2.1461, 119.9151),
        vector4(-981.3167, -1102.8013, 2.0706, 30.2664),
        vector4(-974.5203, -1188.3466, 3.9840, 118.9622),
    },
    ["Downtown"] = {
        vector4(499.2880, -723.9116, 24.8758, 87.0968), 
        vector4(495.6935, -795.3802, 24.8794, 92.1568),       
        vector4(494.2187, -882.9914, 25.5004, 89.7601),
        vector4(494.0735, -1012.8770, 27.8452, 89.9289),
        vector4(482.9222, -1061.9247, 29.1831, 65.8190),
        vector4(435.7865, -1063.4226, 29.2129, 358.9034),
        vector4(410.1964, -931.6528, 29.4183, 268.5800),
        vector4(412.9388, -878.1670, 29.3647, 273.7656),
        vector4(413.1365, -792.4429, 29.3057, 272.6253),
        vector4(415.2385, -705.6684, 29.3673, 269.8976),
        vector4(311.8445, -742.2496, 29.3103, 70.1455),
        vector4(294.2721, -809.3268, 29.4468, 30.1982),
        vector4(197.8335, -1072.5925, 29.3077, 87.9404),
        vector4(178.5333, -1123.2219, 29.3013, 359.3456),
        vector4(84.1455, -1122.1823, 29.3092, 356.4065),
        vector4(88.0040, -1081.5573, 29.3046, 248.2797),
        vector4(150.1436, -1064.3341, 29.1924, 290.5598),
        vector4(53.2067, -964.8918, 29.3576, 341.6128),
        vector4(74.3667, -877.0332, 30.4424, 252.9804),
        vector4(48.8979, -830.6078, 31.0880, 340.7340),
        vector4(5.3707, -976.5236, 29.5537, 160.7441),
        vector4(34.0026, -1008.1057, 29.4478, 119.2186),
        vector4(76.6769, -1035.1429, 29.4502, 66.2763),
        vector4(59.3487, -1073.7224, 29.4445, 65.3884),
        vector4(18.8129, -1124.1912, 28.9612, 1.6908),
        vector4(-4.9893, -1087.6599, 27.0472, 294.7406),
        vector4(-45.4912, -1026.0925, 28.7068, 247.6943),
        vector4(-108.0500, -902.1058, 29.2811, 346.5283),
        vector4(-235.0332, -859.7977, 30.4910, 341.4456),
        vector4(-232.5495, -726.6810, 33.5395, 248.9677),
        vector4(-51.0962, -757.4275, 32.9454, 162.2136),
        vector4(61.0562, -741.4420, 31.6822, 250.1598),
        vector4(94.5246, -648.2792, 31.6717, 249.0136),
        vector4(-88.2965, -577.3760, 36.3983, 76.2099),
        vector4(-183.8195, -672.6326, 34.1226, 340.3185),
        vector4(-266.0782, -776.8786, 32.3601, 71.5584),
        vector4(-225.3239, -894.3792, 29.7608, 161.0129),
        vector4(-104.6451, -944.9006, 29.2300, 159.6549),
        vector4(-38.4272, -1150.9404, 26.4517, 182.4583),
        vector4(169.5135, -1037.8551, 29.3284, 163.5247),
        vector4(255.9823, -988.6326, 29.2877, 250.4120),
        vector4(311.2722, -946.0675, 29.4186, 1.6569),
        vector4(341.3217, -960.0705, 29.4276, 177.6608),
        vector4(389.4138, -900.5450, 29.4106, 82.7445),
        vector4(370.5771, -834.1250, 29.2917, 344.7026),
        vector4(328.4510, -787.3898, 29.2770, 259.3422),
        vector4(344.8719, -736.6544, 29.2733, 257.3544),
        vector4(381.6142, -683.2603, 29.2574, 174.6184),
        vector4(445.3920, -684.0923, 28.5597, 181.0537),
    },
    ["Southside"] = {
        vector4(47.5489, -1208.9652, 29.2940, 88.1944),      
        vector4(63.1330, -1326.5868, 29.2992, 125.0999),       
        vector4(-25.8949, -1351.2637, 29.3148, 3.2781),       
        vector4(-176.0395, -1388.5898, 30.5130, 30.8172),       
        vector4(-181.7872, -1496.7681, 32.4620, 152.2531),       
        vector4(-62.8574, -1596.4941, 29.4121, 139.4557),       
        vector4(-100.4997, -1674.2429, 29.3455, 54.8099),       
        vector4(-86.5282, -1789.0510, 28.5816, 145.0492),       
        vector4(28.5695, -1885.0819, 22.6620, 140.0744),       
        vector4(132.8292, -1883.6683, 23.6003, 159.9985),       
        vector4(192.9336, -1913.2461, 22.8949, 141.8847),       
        vector4(337.9156, -1814.2014, 28.0402, 231.2229),       
        vector4(435.3181, -1698.3115, 29.2926, 230.1027),       
        vector4(540.6014, -1572.4595, 29.2403, 228.8420),       
        vector4(489.7458, -1543.4076, 29.2800, 322.6416),       
        vector4(438.9660, -1494.6969, 29.2541, 296.7838),       
        vector4(264.6102, -1447.5273, 29.3377, 318.7887),       
        vector4(130.4628, -1361.7903, 29.2923, 333.6293),       
        vector4(134.9616, -1312.8291, 29.1850, 174.8277),       
        vector4(264.9110, -1320.6010, 29.5070, 178.7499),       
        vector4(287.7537, -1253.1743, 29.4395, 272.7386),       
        vector4(235.9411, -1202.7830, 29.3524, 274.9745),       
        vector4(225.7106, -1090.8586, 29.3121, 264.3718),       
        vector4(280.1410, -1064.0588, 29.4186, 182.3636),       
        vector4(362.6252, -1066.8667, 29.5249, 176.3449),           

    },
    ["Vinewood"] = {
        vector4(628.5258, 56.8047, 89.0825, 343.9327),
        vector4(394.5921, 138.8676, 102.4920, 348.8087),
        vector4(261.4689, 190.4176, 104.8607, 340.1474),
        vector4(58.1488, 265.2257, 109.5122, 340.0071),
        vector4(-217.5082, 273.0092, 92.0491, 356.9673),
        vector4(-518.7982, 272.4323, 83.1299, 88.7641),
        vector4(-600.3821, 273.6597, 82.0645, 1.6561),
        vector4(-453.9127, 118.8747, 64.4367, 178.7298),
        vector4(-354.4398, 116.1964, 66.5568, 175.5920),
        vector4(-257.3876, 115.6558, 69.2235, 191.7320),
        vector4(-102.5710, 43.6985, 71.5508, 243.5128),
        vector4(88.7883, -22.8370, 68.2769, 171.9379),
        vector4(246.1068, -80.5593, 69.8385, 154.0408),
        vector4(209.5999, -197.3285, 54.0571, 344.4720),
        vector4(-14.8502, -114.7717, 56.8456, 339.1542),
        vector4(-152.1538, -67.7158, 54.1569, 340.9835),
        vector4(-341.4834, -1.8532, 47.5590, 339.7463),
        vector4(-478.8915, 23.8080, 45.2202, 1.0502),
        vector4(-532.1716, 22.5024, 44.2877, 4.8148),
        vector4(-539.4061, -104.6990, 39.5102, 119.4510),
        vector4(-434.7555, -92.7889, 40.4847, 231.2507),
        vector4(-316.6977, -41.5928, 48.3118, 157.4099),
        vector4(-154.1837, -98.1158, 54.5646, 165.4800),
        vector4(-13.5890, -146.6476, 56.7046, 165.1603),
        vector4(92.9970, -187.3022, 54.8660, 156.2339),
        vector4(181.1462, -219.1616, 54.0499, 159.0623),
        vector4(377.5447, -293.9887, 53.3755, 162.0179),
        vector4(433.4878, -315.2861, 49.2963, 162.2041),
        vector4(429.0031, -358.4823, 47.1869, 61.4756),
        vector4(380.7563, -386.3831, 46.5996, 2.5035),
        vector4(291.3340, -450.2999, 43.4058, 77.9869),
        vector4(246.2447, -580.1992, 43.2632, 69.8762),
    },
    ["Rockford Hills"] = {
        vector4(-493.5119, -251.9230, 35.7918, 22.7668),
        vector4(-531.5322, -267.4043, 35.3894, 23.5881),
        vector4(-582.4977, -236.5986, 36.2835, 299.8553),
        vector4(-569.6848, -169.8564, 38.1690, 203.4237),
        vector4(-492.0877, -129.2787, 38.9265, 211.8163),
        vector4(-491.4697, -86.5526, 38.7904, 320.4239),
        vector4(-618.6133, 6.0063, 41.7762, 10.9482),
        vector4(-692.9054, -3.9901, 38.2881, 28.3672),
        vector4(-760.0333, -34.2172, 37.8318, 29.5393),
        vector4(-853.8492, -86.1720, 37.8383, 35.0498),
        vector4(-970.6832, -145.0631, 37.8216, 16.5935),
        vector4(-1017.3434, -157.6229, 37.7979, 29.5607),
        vector4(-957.4604, -250.5584, 38.3716, 147.0147),
        vector4(-863.0793, -303.1627, 39.4468, 144.3147),
        vector4(-822.9163, -347.2791, 37.3684, 63.2520),
        vector4(-860.9356, -377.1417, 39.5528, 25.4058),
        vector4(-930.9432, -408.9266, 37.6445, 38.1765),
        vector4(-969.8424, -389.3998, 37.8314, 299.4562),
        vector4(-1008.4061, -315.5284, 37.8607, 298.0398),
        vector4(-1025.9377, -287.3896, 37.8507, 301.3999),
        vector4(-1087.7882, -268.4395, 37.6596, 32.1038),
        vector4(-1189.7134, -335.3025, 37.5333, 94.2827),
        vector4(-1193.1069, -394.2829, 34.9061, 100.2688),
        vector4(-1128.6965, -420.7223, 36.2600, 192.8332),
        vector4(-1038.7334, -388.9296, 37.8485, 209.7101),
        vector4(-957.1716, -330.4311, 38.1366, 208.5612),
        vector4(-775.6286, -288.1106, 37.0903, 280.6006),
        vector4(-760.0192, -259.8484, 37.0486, 204.8054),
        vector4(-723.7679, -295.2164, 37.0457, 162.2644),
        vector4(-595.6694, -332.7748, 34.8981, 209.8253),
        vector4(-473.8592, -274.0079, 35.7469, 208.2918),
        vector4(-343.3288, -211.7789, 37.7813, 199.4917),
        vector4(-256.8593, -125.4603, 45.3499, 259.9228),
        vector4(-205.7759, -85.1083, 51.0301, 164.9427),

    },
}

Config.SpawnProps ={ -- Only if Config.EnableZones is false
    {x = 475.5041,  y = -670.2628,  z = 26.5331, h = 3.4894},
    {x = 141.3320,  y = -1027.8635, z = 29.3513, h = 163.0735},
    {x = 64.3686,   y = -1000.1199, z = 29.3574, h = 176.7247}, 
    {x = 180.6876,  y =  -1040.9425,z = 29.3079, h = 164.1857},
    {x = 196.4586,  y = -1096.8436, z = 29.2941, h = 85.8390},
    {x = 199.4161,  y = -1186.1459, z = 29.3193, h = 96.4643},
    {x = 207.9233,  y = -1242.9977, z = 29.3187, h = 92.9186},
    {x = 236.1090,  y = -1272.4854, z = 29.2668, h= 264.3872},
    {x = 235.3850,  y = -1203.2180, z = 29.3613, h= 284.3658},
    {x = 225.9029,  y = -1094.8710, z = 29.2959, h= 270.1631},
    {x = 253.7923,  y = -994.4833,  z = 29.2649, h = 251.2704},
    {x = 283.2362,  y = -912.9605,  z = 28.9950, h = 267.8209},
    {x = 259.0956,  y = -834.1644,  z = 29.5405, h = 339.6722},
    {x = 203.8092,  y = -774.9088,  z = 32.2717, h = 251.9818},
    {x = 109.7364,  y = -947.0361,  z = 29.6282, h = 67.6934},
    {x = 74.7820,   y = -972.7283,  z = 29.3577, h = 341.5839},
    {x = 3.2568,    y = -946.8578,  z = 29.3576, h = 342.8749},
    {x = 133.8557,  y = -967.0474,  z = 29.5356, h = 252.1046},
    {x = 138.8061,  y = -1367.0753, z = 29.3026, h = 333.7043},
    {x = 126.8776,  y = -1323.1719, z = 29.2377, h = 212.3943},
    {x = 79.6624,   y = -1200.9001, z = 29.2846, h = 270.7774}, 
    {x = 29.2875,   y = -1301.0388, z = 29.2221, h = 4.6868},
    {x = 79.4077,   y = -1102.6627, z = 29.3065, h = 250.1998},
    {x = 150.9825,  y = -1085.5032, z = 29.1942, h = 183.4256},
    {x = 159.1338,  y = -1008.5742, z = 29.5585, h = 344.6902},
    {x = 224.7981,  y = -856.5838,  z = 30.1266, h = 162.4310},
    {x = 295.1959,  y = -881.0540,  z = 29.2098, h = 252.5723},
    {x = 340.7103,  y = -869.3583,  z = 29.2907, h = 182.3136},
    {x = 388.4954,  y = -869.0103,  z = 29.2917, h = 181.4513},
    {x = 389.3043,  y = -907.8170,  z = 29.4108, h = 176.7281},
    {x = 397.4715,  y = -925.1342,  z = 29.4187, h = 85.3651},
    {x = 411.2105,  y = -906.4905,  z = 29.4187, h = 270.7979},
    {x = 392.9344,  y = -989.8352,  z = 29.4181, h = 86.9190},
    {x = 319.0802,  y = -1034.7701, z = 29.2210, h = 356.8058},
    {x = 274.7674,  y = -1035.0782, z = 29.2081, h = 1.2735},
    {x = 264.4851,  y = -1064.3960, z = 29.4186, h = 181.7215},
    {x = 324.5908,  y = -1064.4202, z = 29.4369, h = 179.4372},
    {x = 391.8871,  y = -1085.3070, z = 29.4216, h = 88.6291},
    {x = 371.5064,  y = -1125.4972, z = 29.4065, h = 1.4280},
    {x = 263.6351,  y = -1120.0977, z = 29.3656, h = 358.7808},
    {x = 228.7551,  y = -1147.4351, z = 29.3036, h = 278.7664},
    {x = 301.4845,  y = -1205.6896, z = 29.3679, h = 265.9781},
    {x = 290.8227,  y = -1251.1184, z = 29.4220, h = 181.1820},
    {x = 133.5831,  y = -1122.7675, z = 29.3061, h = 6.0275},
    {x = 37.3052,   y = -1038.4550, z = 29.4643, h = 338.2645},
    {x = -66.1231,  y = -1081.3080, z = 26.9615, h = 260.9160},
    {x = -8.6212,   y = -1087.7323, z = 26.6955, h = 249.9065}, 
    {x = -45.8060,  y = -1028.3158, z = 28.5534, h = 245.9735},
    {x = -34.4345,  y = -996.2932,  z = 29.1205, h = 248.2568},
    {x = 55.6280,   y = -792.5734,  z = 31.5955, h = 160.6566},
    {x = 76.8087,   y = -799.1368,  z = 31.5802, h = 158.7955},
    {x = 102.7218,  y = -808.3702,  z = 31.4191, h = 160.3637},
    {x = 131.4403,  y = -787.1794,  z = 31.2966, h = 336.1524},
    {x = 215.5849,  y = -818.3110,  z = 30.6371, h = 342.9619},
    {x = 317.8807,  y = -817.1687,  z = 29.2772, h = 249.5879},
    {x = 333.5982,  y = -771.4371,  z = 29.2769, h = 252.9979},
    {x = 351.1658,  y = -718.4304,  z = 29.2759, h = 251.2580},
    {x = 328.5123,  y = -695.6565,  z = 29.3097, h = 72.6609},
    {x = 306.6965,  y = -757.0514,  z = 29.3100, h = 70.8890},
    {x = 286.7085,  y = -818.1135,  z = 29.3099, h = 68.3277},
    {x = 334.2407,  y = -951.7277,  z = 29.6030, h = 12.0549},
    {x = 344.2732,  y = -959.7680,  z = 29.4319, h = 181.2829},
    {x = 72.4137,   y = -870.5861,  z = 30.5299, h = 261.7058},
    {x = 48.2880,   y = -906.8010,  z = 29.9513, h = 61.5799},
    {x = 23.5499,   y = -823.0858,  z = 30.9971, h = 236.1618},
    {x = -2.1233,   y = -840.2816,  z = 30.4514, h = 68.1490},
    {x = 366.6276,  y = -798.4854,  z = 29.2886, h = 269.2122},
    {x = 399.2769,  y = -743.2401,  z = 29.2855, h = 92.2074},
    {x = 216.8035,  y = -1009.5715, z = 29.2544, h = 69.9031},
}

Translation = {
    ['de'] = {
        ['start_mission_text'] = '~g~[E]~s~ Müllfahrer-Job',
        ['cancel_mission_text'] = 'Drücke ~r~[G]~s~ um den Job zu beenden',
        ['already_startet_mission'] = 'Du hast bereits den Job gestartet',
        ['canceled_mission'] = 'Du hast den Job beendet',
        ['prop_blip_name'] = 'Müll',
        ['sucessfully_removed_prop'] = 'Du hast den Müll genommen',
        ['sucessfully_started_mission'] = 'Job erfolgreich gestartet. Fahr nun mit deinem Müllfahrzeug zu deiner Tour',
        ['step1'] = 'Bringe die Mülltonne jetzt zu dem Müllwagen',
        ['cant_do_in_vehicle'] = 'Du kannst dies nicht in einem Fahrzeug tun',
        ['reward'] = 'Du hast ~g~%s$~s~ erhalten',
        ['reward_title'] = 'Belohnung',
        ['bring_can_back'] = 'Bringe die leere Mülltonne wieder zurück',
        ['press_e_to_take_trash'] = 'Drücke ~g~[E]~s~ um die Mülltonne zu nehmen',
        ['press_to_bring_trash_back'] = 'Drücke ~g~[E]~s~ um die Mülltonne zurückzustellen',
        ['press_to_take_trunk'] = 'Drücke ~g~[E]~s~ um die Mülltonne zu entleeren',
        ['trash_empty'] = 'Die Mülltonne wird entleert...',
        ['took_bail'] = 'Ich habe dir eine Kaution in Höhe von ~r~%s$~s~ berechnet. Also bring das Fahrzeug wieder!',
        ['back_bail'] = 'Du hast deine Kaution wieder zurück erhalten [~g~%s$~w~]',
        ['trasher_not_nearby'] = 'Der Müllwagen ist nicht in der Nähe, weshalb du keine Kaution zurück erhälst!',
        
        -- New Translations
        ['menu_start_job'] = 'Starte den Job',
        ['menu_start_job_desc'] = 'Wähle eine Tour',
        ['menu_end_job'] = 'Job beenden',
        ['menu_end_job_desc'] = 'Beende deinen aktuellen Job',
        ['picturenotify_bonus_title'] = 'Tour abgeschlossen',
        ['picturenotify_bonus_desc'] = 'Du hast deinen ~o~Bonus~s~ in Höhe von ~g~%s$~s~ erhalten',
        ['truck_not_there'] = 'LKW nicht in Sichtweite',
        ['truck_not_there_desc'] = 'Dein LKW ist nicht in der Nähe. Du wirst keine Kaution zurück bekommen',
        ['job_not_started'] = 'Du hast den Job noch nicht gestartet',
        ['menu_change_clothing'] = 'Kleidung wechseln',
        ['menu_change_clothing_desc'] = 'Wechsel deine Kleidung zum Job Outfit',
        ['menu_choose_zone'] = 'Wähle eine Zone',
        ['choose_this_tour'] = 'Wähle diese Tour | %s Mülltonnen',
        ['already_done_tour'] = 'Diese Tour hattest du vor kurzem bereits!',
        ['check_start_this_tour'] = 'Möchtest du die Tour %s wirklich starten?',
        ['default'] = 'Standard',
        ['finished_tour_title'] = 'Tour abgeschlossen',
        ['finished_tour_desc'] = 'Du hast deine ~g~Tour abgeschlossen~s~. Fahre nun zurück zum Depot',
        ['trasherjob_blip'] = 'Trasher Job',
        ['current_trashcan'] = '~w~Aktuelle Mülltonnen ~g~%s~w~/~g~%s',
        ['found_trash'] = 'Du hast etwas im Müll gefunden!',
        ['dont_have_job'] = 'Du hast nicht den richtigen Job',
    },

    ['en'] = {
        ['start_mission_text'] = '~g~[E]~s~ Trasher-Job',
        ['cancel_mission_text'] = 'Press ~r~[G]~s~ to end the Job',
        ['already_startet_mission'] = 'You already started the Job',
        ['canceled_mission'] = 'You canceled the Job',
        ['prop_blip_name'] = 'Trash',
        ['sucessfully_removed_prop'] = 'You took the Trash',
        ['sucessfully_started_mission'] = 'You took your Trashcar. Now go and do your Job',
        ['step1'] = 'Now bring the Trashcan to the Car',
        ['cant_do_in_vehicle'] = 'You cant do this in a Vehicle',
        ['reward'] = 'You earned ~g~%s$',
        ['reward_title'] = 'Reward',
        ['bring_can_back'] = 'Bring the empty Trashcan back',
        ['press_e_to_take_trash'] = 'Press ~g~[E]~s~ to take the Trashcan',
        ['press_to_bring_trash_back'] = 'Press ~g~[E]~s~ to take the Trashcan back',
        ['press_to_take_trunk'] = 'Press ~g~[E]~s~ to empty the Trashcan',
        ['trash_empty'] = 'Trashcan will be emptied...',
        ['took_bail'] = 'I took ~r~%s$~s~ for the Trashcar, so bring it back to me later!',
        ['back_bail'] = 'You got the Cash back from the Trasher [~g~%s$~w~]',
        ['trasher_not_nearby'] = 'You dont brought the Trasher back. You dont get any Money back!',

        -- New Translations
        ['menu_start_job'] = 'Start the Job',
        ['menu_start_job_desc'] = 'Choose a Tour',
        ['menu_end_job'] = 'End Job',
        ['menu_end_job_desc'] = 'End your current Job',
        ['picturenotify_bonus_title'] = 'Tour Completed',
        ['picturenotify_bonus_desc'] = 'You have received your ~o~bonus~s~ of ~g~%s$~s~',
        ['truck_not_there'] = 'Truck not nearby',
        ['truck_not_there_desc'] = 'Your truck is not nearby. You will not get a deposit refund',
        ['job_not_started'] = 'You have not started the job yet',
        ['menu_change_clothing'] = 'Change Clothing',
        ['menu_change_clothing_desc'] = 'Change your clothing to the job outfit',
        ['menu_choose_zone'] = 'Choose a Zone',
        ['choose_this_tour'] = 'Choose this Tour | %s Trash Cans',
        ['already_done_tour'] = 'You have already done this Tour recently!',
        ['check_start_this_tour'] = 'Do you really want to start the Tour %s?',
        ['default'] = 'Default',
        ['finished_tour_title'] = 'Tour Completed',
        ['finished_tour_desc'] = 'You have ~g~completed your tour~s~. Now drive back to the depot',
        ['trasherjob_blip'] = 'Trasher Job',
        ['current_trashcan'] = '~w~Current Trash Cans ~g~%s~w~/~g~%s',
        ['found_trash'] = 'You found something in the Trash',
        ['dont_have_job'] = 'You dont have the Job',

    }

}
