Config = {}

Config.Font = 'font4thai'



Config.timeSell = 100 -- นับเวลาเป็น วินาที เวลาในการขาย
Config.PoliceWant = 0 -- จำนวนตำรวจ

Config.cleanmoney = false --จะให้ขายเป็นเงินเขียว หรือเงินแดง true == เงินเขียว // false == เงินแดง


-- todo หมวดตอนกดใช้ Item
Config.Itemuse = "seller"
Config.removeItemuse = false --จะให้ลบ item หลังกดใช้มั้ย true = ลบ , false = ไม่ลบ

Config.text = '<center>ไปขายยากัน<center>'
Config.texttype = "info" --เลือกสีได้ในนี้ https://forum.cfx.re/t/release-pnotify-in-game-js-notifications-using-noty/20659/7
Config.texttime = 3
Config.textlaout = "CenterLeft"

------------------------------------------------------todo ถ้าหมดเวลาจะขึ้นว่าอะไร
Config.timeoutText = '<center>หมดเวลาแล้วจ้า<center>'
Config.timeouttype = "info"
Config.timeouttime = 3
Config.timeoutlaout = "CenterLeft"

------------------------------------------------------todo ต้องการตำรวจเท่าไหร่
Config.noCopsText  = "<b style='color: red; text-align: center;'>ตำรวจไม่พอนะ</b>"
Config.noCopstype  = "error"
Config.noCopstime  = 5
Config.noCopslaout = "bottomCenter"

------------------------------------------------------todo ถ้าไม่มี item แล้วขาย
Config.Noitemtext   = '<span class="red-text">'.."ไม่มี Item อย่าเหลี่ยมครับ"..'</span>'
Config.Noitemtype   = "error"
Config.Noitemtime   = 3
Config.Noitemlayout = "bottomCenter"

------------------------------------------------------todo หมวดเลือกของที่จะขาย
Config.ItemsellText = {x = 0.830, y = 0.500, width = 1.0, height = 1.0, scale = 0.55, r = 255, g = 255, b = 255, a = 255}
Config.TextselectA  = "~r~กด ~w~[G] ~r~ขายItem ชื่อ: [" 
Config.TextselectB  = "] นะ"
Config.KeysSelect   = 'G'


------------------------------------------------------todo กดขาย
Config.PresssellText = {x = 0.930, y = 0.700, width = 1.0, height = 1.0, scale = 0.55, r = 255, g = 255, b = 255, a = 255}
Config.Pressselect   = "~r~กด [~w~ "
Config.Pressselect2   = "~r~ ] เพื่อขาย "
Config.KeysSelectGo    = 'E'

------------------------------------------------------todo ถ้าพลาดแล้ว อุ้มออกจากโซนจะเป็นยังไง
Config.DeadorAlive   = false --ถ้า True = ตาย , False = ตัวจะดีดกลับไปที่เดิม

-- ถ้าปรับข้างบนเป็น false จะใช้งานข้างล่างไม่ได้
Config.explosionType = 3
Config.damageScale   = 5
Config.isAudible     = true -- ถ้าระเบิดแล้ว จะให้มันมีเสียงมั้ย ถ้ามี ปรับ true ถ้าไม่ปรับ false


------------------------------------------------------todo แจ้งเตือนตอนขายพลาด
Config.AlertPhone = true

Config.Alert = "maxez-police:alertNet" 
Config.AlertType = "drug"

Config.Labelname = "unique_action_name"
Config.fail = 20 --วินาที ในการแช่แข็ง
Config.Labelfail = "เรียบร้อยยยย เกมมมมม" 

Config.randomsell = {1,1}



Config['sellDrug'] = 
{
	['weed_pooch'] ={
		sell = {name = "weed_pooch", nameInGame = "กัญชาอ่ะไอ่สัส",amount = {800,1500},luck = 10}
	}
	-- ['phone'] ={
	-- 	sell = {name = "phone",nameInGame = "ทรศศศศ", amount = {1000,5000},luck =30}
	-- },
    -- ['gacha_01'] ={
	-- 	sell = {name = "gacha_01",nameInGame = "กสชาาาาา", amount = {1000,5000},luck =40}
	-- }
}

Config['Npcped'] = 0xCF623A2C                   -- Name
Config['Npcname'] = 'u_m_y_antonb'              -- Hash

Config.prop = 'prop_coke_block_01' -- พร๊อพที่ต้องกดใช้อุปกรณ์

Config.trade = 'bkr_prop_duffel_bag_01a' -- พร๊อพที่ต้องกดใช้อุปกรณ์

Config.RequestAnimDict = 'mp_common' -- ประเภท
Config.TaskPlayAnim = 'givetake1_a' -- จำพวก


Config.WebHook = ""

Config.SpawnNPC = { 
    [1] = {name = "Vinewood Hills",  x = -607.31, y = -802.33, z = 24.17, h = 267.02},
    [2] = {name = "Vinewood Hills",  x = -315.15, y = -4.58, z = 47.24, h = 339.27},
    [3] = {name = "Rockford Hills",x = -1051.85, y = 431.66 , z = 76.06 },
    [4] = {name = "Rockford Hills",x = -904.04 , y = 191.49 , z = 68.44 },
    [5] = {name = "Rockford Hills",x = -21.58  , y = -23.70 , z = 72.24 },
    [6] = {name = "Hawick"        ,x = -904.04 , y = 191.49 , z = 68.44 },
    [7] = {name = "Alta"          ,x = 225.39  , y = -283.63, z = 28.25 },
    [8] = {name = "Pillbox Hills" ,x = 5.62    , y = -707.72, z = 44.97 },
    [9] = {name = "Mission Row"   ,x = 284.50  , y = -938.50 , z = 28.35},
    [10] ={name = "Rancho"        ,x = 411.59  , y = -1487.54, z = 29.14},
    [11] ={name = "Davis"         ,x = 85.19   , y = -1958.18, z = 20.12},
    [12] ={name ="Chamberlain Hills",x = -213.00, y =-1617.35 , z =37.35},
    [13] ={name ="La puerta"      ,x = -1015.65, y =-1515.05 ,z = 5.51},
    [14] ={name ="chez un client" ,x= -1004.788, y=-1154.824,z = 1.64603},
    [15] ={name ="chez un client" ,x= -1113.937, y=-1193.136,z = 1.827304},
    [16] ={name ="chez un client" ,x= -1075.903, y=-1026.452,z = 4.031562},
    [17] ={name ="chez un client" ,x= -1056.485, y=-1001.234,z = 1.639098},
    [18] ={name ="chez un client" ,x= -1090.886, y=-926.188,z = 2.630009},
    [19] ={name ="chez un client" ,x= -1075.903, y=-1026.452,z = 4.031562},
    [20] ={name ="chez un client" ,x= -1181.652, y=-988.6455,z = 1.634243},
    [21] ={name ="chez un client" ,x= -1151.11, y=-990.905,z = 1.638789},
    [22] ={name ="chez un client" ,x= -1022.788, y=-896.3149,z = 4.908271},
    [23] ={name ="chez un client" ,x= -1060.738, y=-826.829,z = 18.69866},
    [24] ={name ="chez un client" ,x= -968.6487, y=-1329.453,z = 5.144861},
    [25] ={name ="chez un client" ,x= -1185.5, y=-1386.238,z = 4.112149},
    [26] ={name ="chez un client" ,x= -1132.848, y=-1456.029,z = 4.372081},
    [27] ={name ="chez un client" ,x= -1125.602, y=-1544.203,z = 5.391256},
    [28] ={name ="chez un client" ,x= -1084.74, y=-1558.709,z = 4.10145},
    [29] ={name ="chez un client" ,x= -1098.367, y=-1679.272,z = 3.853804},
    [30] ={name ="chez un client" ,x= -1155.863, y=-1574.202,z = 8.344403},
    [31] ={name ="chez un client" ,x= -1122.675, y=-1557.524,z = 5.277201},
    [32] ={name ="chez un client" ,x= -1108.679, y=-1527.393,z = 6.265457},
    [33] ={name ="chez un client" ,x= -1273.549, y=-1382.664,z = 3.81341},
    [34] ={name ="chez un client" ,x= -1342.454, y=-1234.849,z = 5.420023},
    [35] ={name ="chez un client" ,x= -1351.21, y=-1128.669,z = 3.626104},
    [36] ={name ="chez un client" ,x= -1343.232, y=-1043.639,z = 7.303696},
    [37] ={name ="chez un client" ,x= -729.2556, y=-880.1547,z = 22.22747},
    [38] ={name ="chez un client" ,x= -831.3006, y=-864.8558,z = 20.22383},
    [39] ={name ="chez un client" ,x= -810.4093, y=-978.4364,z = 13.74061},
    [40] ={name ="chez un client" ,x= -683.8874, y=-876.8568,z = 24.02004},
    [41] ={name ="chez un client" ,x= -1031.316, y=-903.0217,z = 3.692086},
    [42] ={name ="chez un client" ,x= -1262.703, y=-1123.342,z = 7.092357},
    [43] ={name ="chez un client" ,x= -1225.079, y=-1208.524,z = 7.619214},
    [44] ={name ="chez un client" ,x= -1207.095, y=-1263.851,z = 6.378308},
    [45] ={name ="chez un client" ,x= -1086.787, y=-1278.122,z = 5.09411},
    [46] ={name ="chez un client" ,x= -886.1298, y=-1232.698,z = 5.006698},
    [47] ={name ="chez un client" ,x= -753.5927, y=-1512.016,z = 4.370816},
    [48] ={name ="chez un client" ,x= -696.3545, y=-1386.89,z = 4.846177}
}
