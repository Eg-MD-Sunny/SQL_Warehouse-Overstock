---- OverStock Report (Warehouse wise)

SELECT pv.id
	,pv.name
	,SUM(cws.requiredstock) RequiredStock
	,SUM(cws.shelved) + SUM(cws.markedforrecall) Stocknow
	,w.Id [WarehouseId]
	,w.name [Warehouse Name]-- global

FROM CurrentWarehouseStock cws
JOIN productvariant pv ON pv.id = cws.ProductVariantId
JOIN Warehouse w ON w.id = cws.WarehouseId
JOIN ProductVariantPricing PVP ON pvp.ProductVariantId = pv.Id
WHERE pv.deleted = 0
    --AND PVP.MetropolitanAreaId = 1		-- DHA OverStock Report	-- DHA > 1, CTG > 2, JSR > 3
	--AND w.MetropolitanAreaId=1		-- DHA OverStock Report	-- DHA > 1, CTG > 2, JSR > 3
	and  PVP.MetropolitanAreaId is null--global
	AND pv.name NOT LIKE '%Gift From Chaldal%'
	AND pv.Name NOT LIKE '%Shopping Bag%'
	AND pv.Name NOT LIKE '%Poly Bag%'
	AND pv.Name NOT LIKE '%GP %'
	AND CostPrice IS NOT NULL
	AND pv.shelftype in (9)
	AND pv.DistributionNetworkId = 1

	
GROUP BY pv.id
	,pv.name
	,w.Id
	,w.name--global


HAVING SUM(cws.requiredstock) < SUM(cws.shelved) + SUM(cws.markedforrecall)
--ORDER BY 11 ASC



---- OverStock Report( AFTER VLOOKUP)

SELECT pv.id
	,pv.name
	,SUM(cws.requiredstock) RequiredStock
	,SUM(cws.shelved) + SUM(cws.markedforrecall) Stocknow
	,w.Id [WarehouseId]
	,w.name [Warehouse Name]


FROM CurrentWarehouseStock cws
JOIN productvariant pv ON pv.id = cws.ProductVariantId
JOIN Warehouse w ON w.id = cws.WarehouseId
JOIN ProductVariantPricing PVP ON pvp.ProductVariantId = pv.Id
WHERE pv.deleted = 0
    AND PVP.MetropolitanAreaId is null
	and w.MetropolitanAreaId=1
	AND pv.name NOT LIKE '%Gift From Chaldal%'
	AND pv.Name NOT LIKE '%Shopping Bag%'
	AND pv.Name NOT LIKE '%Poly Bag%'
	AND pv.Name NOT LIKE '%GP %'
	AND CostPrice IS NOT NULL
	--AND pv.shelftype in (9)
	--AND pv.DistributionNetworkId = 1

	and pv.id in (21408,6981,30175,28125,20238,16319,12218,29369,28642,27695,27412,29874,23644,27228,11667,15390,18607,19896,24978,11817,18533,22868,27451,2314,9023,27992,16705,13905,15346,27607,3681,13329,16071,28157,23739,23475,24292,26102,21935,19978,24514,28762,22055,21079,21189,3437,4303,13255,29337,29873,29470,2473,2653,8678,23221,20832,28861,3442,7859,2680,16948,18537,24858,11688,28150,24173,24597,27651,7188,23264,23745,18583,26644,7360,8710,12689,14064,22870,20714,27597,26103,2607,27674,26143,26906,28361,21069,22859,11806,18658,21672,27457,26047,2506,16990,21840,21673,7635,27544,29610,18540,26746,7621,23457,20694,9839,28398,29767,18569,12743,16971,23713,29374,16030,7929,29588,4104,29063,2125,26683,27596,28338,26817,23634,29707,28918,21423,26648,23303,21798,26136,7752,2987,19918,7097,28665,29419,23965,18695,27492,11702,20359,21997,27276,21977,29346,7862,15312,29587,24772,27524,27242,4285,28154,12362,29469,26482,3825,26312,12408,12506,28911,29687,3243,18449,14414,28167,26616,29465,18595,28520,29094,29452,23380,29559,13053,26104,7947,17171,23884,27101,8202,4084,12282,27657,29450,21371,26907,17068,18323,21398,26653,19822,26870,27065,28115,24553,21933,14968,29764,19875,29648,20708,8799,27842,28702,21893,7808,11358,10857,14978,15759,22230,16679,16937,18388,22557,12753,12163,21996,8053,12070,11663,29700,27733,27271,24171,5906,26471,8566,17221,22423,28988,28683,18712,2721,16115,16601,23858,10718,11111,20423,29021,29581,28102,11845,29145,27383,27824,22928,20693,3970,14077,15195,15650,26600,22094,21164,9850,3448,11021,23783,21946,19923,3074,21170,18423,12116,27614,23870,23289,27849,15795,27031,28063,20027,4586,18418,28366,5622,26154,26897,10976,15389,21972,29826,16056,13459,14392,22872,29402,26577,2321,10232,16148,18314,24642,7366,9335,23215,16110,26095,28919,20837,22367,15097,15578,22817,22875,21730,27298,21968,26485,16687,28939,21632,15703,24363,21630,10863,21831,2447,10031,16120,20322,8347,9155,9441,29865,22618,21168,2589,11465,28848,16954,22432,28667,26775,23755,17236,4412,6252,26881,10410,14292,16422,29077,30176,17233,29603,20601,2147,21171,24936,11353,21984,29119,29373,23599,29382,23969,21428,15066,6144,29082,29601,29645,23913,9391,10607,23386,27367,3146,20073,4583,8872,11352,20097,27501,26474,27055,14161,27815,14241,15664,22854,15160,28191,20141,20358,7615,29248,23967,24937,13623,28909,29242,20792,26546,10043,10409,10527,29606,27745,20115,17175,26155,26490,15521,27323,5903,13253,27632,21993,12446,12458,27037,11804,11656,15900,29433,19973,28280,26348,13331,16887,18468,24309,12525,16660,27678,23026,24551,16581,27485,13128,12167,27755,18610,20188,27600,20916,18689,2267,11408,28632,20948,7368,29137,3640,26811,3919,13866,26051,2114,12755,19778,22330,3807,9001,12360,29506,19979,21890,27350,10513,29508,24000,26939,12635,10648,16521,3457,20711,12850,3481,23238,3526,28226,24418,27724,28780,8769,3622,29388,22896,29694,17232,7631,9903,3869,2618,23217,21621,11215,2526,26602,5909,23279,7970,28781,8047,12515,15539,24207,9295,28704,29662,29713,29125,9821,24338,7593,3698,17234,10211,23039,28566,21623,7365,5651,29830,16615,28912,23143,29657,23127,27919,28526,28064,22916,15647,14129,20405,10089,27381,15349,10034,21479,29572,2883,2542,11366,15846,24958,27128,23848,23638,14459,15069,24295,26294,28110,26277,16953,27252,10100,2967,9199,27972,11542,13593,20331,26094,23942,2128,5683,23807,26283,22224,29845,10647,27896,28722,27662,23485,6100,5907,22157,8920,16717,2350,15803,9527,18576,24437,22070,27564,14460,12754,21814,29613,7845,26556,27139,15882,16108,24598,8971,10035,27301,24884,29698,11095,26630,24165,27436,19932,28116,4207,23793,8784,15830,10201,4589,28024,22442,11014,20198,2225,16493,22437,29527,11274,10002,22871,29468,18641,27106,29345,14167,2318,24920,24489,9400,7629,22091,27759,4291,29209,18605,8275,11957,12412,2981,5914,26972,23930,27582,16813,26803,2134,8533,8870,9029,20905,15123,21136,14882,26956,26552,22955,28163,12179,23981,4151,16827,15383,23832,29783,22101,20946,16210,11685,2199,9051,23987,12785,24657,26802,27147,7653,26435,18617,26000,24060,21913,10733,24166,28492,20183,27737,8334,6171,22470,29553,27187,27249,21596,27380,26537,10996,26944,29898,29144,29317,21886,26790,27565,26528,9429,9492,18542,28676,18465,22949,24303,22464,15181,21949,22789,22417,21180,6159,21811,26912,27452,20883,26950,11872,17176,3412,2432,11693,18518,3987,29282,14951,26544,27670,28645,29674,22997,13389,26696,29371,27877,21272,28528,24554,10508,10728,27796,3843,21566,23080,28785,27447,10041,11760,11929,6061,9012,2230,9971,23664,12068,13238,24301,9386,26494,26591,10057,14634,26688,11166,27277,8502,10032,26905,8470,11733,27611,18344,7917,18694,10707,11869,3907,14827,28760,24512,21446,12863,8754,2820,27762,26043,24012,22467,22357,4053,9206,14385,24576,12695,3697,22126,26975,27066,12543,10628,2453,28039,22496,20877,27734,29078,22661,24846,21584,12585,28625,29332,29902,15235,13058,13612,12599,24763,9689,29473,28132,29358,27738,8050,8522,28399,28294,15414,27943,26515,26021,27440,20511,17108,21314,27231,29574,24507,17165,22720,15388,24802,27302,4046,16179,27478,27311,16411,21994,26691,18331,30118,24518,26633,4505,26990,21237,23260,9519,28986,20420,28353,26816,10335,4152,27606,16828,13004,8427,24212,8708,19809,20564,4066,28779,24058,23852,7650,8332,16662,22662,27479,8105,29692,29228,27103,27414,28790,24167,28381,27385,12618,19806,16292,21602,20945,22995,3443,27798,21425,27940,21169,18685,9834,4106,23968,11435,12115,3468,24720,22783,12036,29171,27929,26875,26899,29562,15094,2362,10490,18631,29576,26592,9182,24809,9291,11545,22885,23392,12206,10428,28155,7699,18655,14514,27618,28728,10400,29768,18414,26850,29642,7611,17257,24869,17030,23952,28457,22276,20887,29133,28168,9059,22939,28743,27830,27162,23920,26263,28753,26061,15430,21316,2985,12396,8862,29092,21901,10770,26618,27499,27844,22786,28835,23445,26721,7774,26657,29210,14018,29349,20898,28034,26164,11239,16825,17034,27141,24711,11602,27313,21034,18543,2186,28842,16942,18341,26291,9481,6998,27360,28897,26968,23806,8612,6187,26025,23633,12188,18573,22758,23306,26753,16413,29467,26788,4098,9515,18517,18659,13652,17243,15382,28619,11544,24337,22653,8052,19957,26593,18705,29710,28072,21979,22194,26475,22717,26497,8718,12509,5882,21609,4044,22297,29589,29699,29289,27553,18559,24362,24906,23181,20647,29128,21424,23738,10474,10401,29778,15401,10240,24617,15096,18377,29664,12063,24021,22277,13227,23502,6127,14727,7558,21000,20520,20206,8204,22529,29859,24956,26057,27428,8199,15747,14454,11500,28977,6980,28087,27110,28757,3922,24015,16688,3704,26555,27665,15550,11459,11632,12622,20943,28133,27599,4051,23811,21084,16432,27763,26958,15589,26562,10554,28106,28706,16696,12280,18293,22308,2397,15392,2126,8790,27027,7527,17174,27892,21919,7837,2553,20653,29440,11286,2821,23126,29134,22629,9536,21697,14524,21692,19821,29027,2984,28086,30119,23465,27293,29586,24043,25995,20165,27075,26354,10083,16466,23263,9531,16415,29447,22558,29015,2816,28229,13257,28800,21482,18446,28641,9402,24641,29290,12312,15116,28746,7790,7818,22594,2218,28725,28906,16470,9230,15095,27700,16689,20893,30123,12285,17140,26082,20092,15515,20712,11584,24709,29472,12382,22371,23141,21838,27790,15949,29272,21763,29318,21568,24760,11160,27474,29901,28380,29543,15355,22603,17154,11330,16175,5908,24172,27074,16888,29421,20794,16851,27199,27270,29073,3538,19940,29955,18692,20272,27352,26741,12694,3938,26028,27296,21505,27392,13868,2989,13328,28147,26222,29357,5904,21662,3339,6782,28525,27337,7157,12541,24028,22615,27455,9064,20932,21992,29554,21475,28813,14327,22179,15514,21273,20797,17110,12851,26560,21037,22637,27913,24761,21674,3913,7921,29124,27594,26807,27720,27092,9473,20224,20076,27921,16815,30121,27907,3806,26533,23917,29663,3371,23245,22127,26651,10118,20674,21478,21595,11040,23336,28783,22058,23982,26698,28750,28644,26646,16497,26550,11070,24109,28755,29684,29702,15032,21018,10720,14107,15006,4082,27917,3574,27546,4295,3613,22061,20612,15704,24777,15104,26985,2566,21923,22625,8703,18670,21544,18330,29129,27035,24980,20777,23538,27174,23262,24837,26109,2714,27989,22869,10943,24010,21271,14275,27698,28679,14889,18416,9843,24934,30174,29578,10316,10735,19748,12212,21427,22810,11112,21059,2567,3105,16818,9053,24307,29348,24029,28466,29876,3478,23819,29372,28203,20707,18557,10111,28891,18558,26945,16118,22533,24300,27970,28776,23861,23950,13300,2470,23340,24538,2514,15868,26766,26974,29398,29120,28160,26296,13080,23595,17126,26826,28071,7897,29598,20498,4185,19865,21914,28890,15565,13313,18316,16154,22548,20419,11966,11245,4325,18328,9583,12613,29118,2390,26399,11695,19947,29325,4582,21603,26959,28519,23444,29980,23787,18632,21978,18338,19921,3489,20209,28845,6967,26706,27598,13001,9418,26394,23490,8245,27807,5818,16724,26438,22374,28631,27938,8889,26017,26150,27295,24290,22607,23220,14794,10393,3104,23665,26728,23679,11843,12322,23789,10591,20457,24095,21835,28984,23342,28068,20356,27610,29936,11499,15884,13365,29080,27675,13659,17051,15117,29186,27335,28494,29577,3210,19869,24189,29058,23964,27315,15223,18572,14101,27297,29665,4142,24247,24061,29067,14461,23902,28828,23805,28062,29775,12527,26398,28281,15766,13311,27937,29339,12777,22472,28061,27308,12347,29575,28969,24712,6229,23224,26468,28124,28917,27042,17262,8712,28137,2289,12783,23875,10945,10487,24215,9995,2463,20009,24984,18620,22456,23795,15823,23949,27401,21733,18378,28244,27107,20159,7757,28775,28701,4199,27550,10379,15284,14841,10989,4292,20120,19845,22465,18282,26612,16465,2902,26893,28808,29000,27033,3734,28418,8115,8244,10551,12792,18688,28069,26613,29479,26948,2226,23872,24593,22372,22713,20886,26378,21372,12132,27707,20210,3476,28001,21477,16296,20132,22112,27477,8567,7841,24650,26484,4574,28970,8684,22366,3073,5689,26092,16681,19841,27312,27197,28638,9831,26553,19803,10736,21052,11181,14492,3396,16015,21880,11861,21104,9692,21846,18357,21274,20810,24360,28012,26501,25997,3647,14537,29649,7308,16075,15281,27673,28646,16469,29300,23027,26637,18604,22956,24541,21617,2160,6194,27879,27991,21581,15677,10740,29392,7161,22919,28651,21082,18640,29188,12295,15256,4599,22012,22929,24791,8196,3397,10037,23752,12835,13264,7884,20577,26851,26760,8728,23477,29205,24745,27116,21074,22634,14244,18699,24267,18504,29441,29475,16809,12528,3838,26727,24770,26270,29712,22787,28975,28758,28606,3897,19830,23388,23903,28014,27237,21138,16155,10523,26128,22433,11360,18516,29643,23343,22073,4123,26156,27496,20899,3242,26416,10821,18553,26362,28162,12069,10110,20075,15744,21700,27694,22373,18415,8408,23484,8063,29354,20554,26580,29359,22399,16580,6779,27179,13025,22718,24257,7454,2546,27887,20185,20615,29659,23829,26058,28993,16675,28005,2208,12519,2446,26112,4588,16723,24162,21829,27640,24964,22834,18529,27494,29287,20207,12752,29253,12181,8998,27513,28283,29693,15083,10156,26661,28797,19981,20892,22396,27652,27124,11033,29456,21229,27525,27884,2248,2523,2376,16147,27756,22105,10323,27176,5873,18422,28374,12615,16627,10029,10509,16920,7625,22767,24708,19855,22306,26726,15259,10973,22901,20515,29220,21947,10977,28042,23393,4117,23842,21844,16467,26640,15794,10105,10172,7689,20947,18345,8967,6147,3720,20352,12318,10512,29417,26015,29615,23396,24230,20042,29667,29650,18435,3819,2819,29314,15431,28130,11561,12965,6055,27649,16083,15797,26324,12062,27915,27765,24579,22324,19909,18621,11965,14453,3637,2265,23970,11573,20672,24252,10123,24704,12853,12795,2817,22190,20754,27115,27591,16061,9149,12763,6230,16536,13878,24011,28978,2865,10578,29571,10611,26774,23244,5692,29265,28089,10200,23833,16914,28112,6697,16907,22663,24895,29315,29969,7507,12346,29483,24412,27507,28166,29038,27941,26543,20332,26077,3380,27405,7355,7899,26589,23801,4410,16016,17167,24755,18350,11506,26981,3968,17107,28152,18292,6111,19829,16176,12301,23962,13541,23334,29307,26551,19867,20582,3337,28575,6778,10894,27636,26608,23450,10038,16172,20441,23395,27396,19903,10488,28267,26356,9867,29266,18284,10946,28563,24604,21731,13288,8945,16697,16622,2200,8793,27685,28626,24701,22790,7772,12064,2983,13468,22068,28562,12056,27740,26955,27028,23860,15661,18430,12614,6211,27456,21085,26825,26023,3239,10095,2246,21111,22377,15585,29718,15255,22726,21676,29365,21481,27873,10979,24861,29114,15745,13805,8919,16490,24989,26579,23470,23684,27630,29460,20836,16109,16960,2482,26549,2591,18362,24862,28795,27671,23637,19908,10090,15793,14219,26808,24731,20014,4047,22531,11922,8410,29143,2448,21313,11668,27399,28363,23822,24017,2770,22441,9611,20182,27105,16945,23922,29391,2917,29556,27993,29599,20361,20565,17101,29255,24754,2286,7871,21543,2127,14927,24631,16974,20363,27317,12546,28803,11950,8432,23383,29093,2419,18337,24832,2961,29407,23883,18500,11827,21638,28058,27143,27693,17258,28666,20168,13563,20654,27601,24618,23344,9328,16481,23398,26815,21869,11659,21845,21849,23800,11202,7968,29463,20544,27660,10412,11649,2257,18718,11158,26701,12820,16464,27483,7145,13619,28070,27690,24296,3708,24018,14551,23138,9025,21656,28674,29464,2834,28091,21934,18312,28161,18501,21275,11851,21012,21597,22777,27089,23248,16654,16650,29551,28517,27227,27566,20320,29204,29794,27233,29618,11985,2518,2394,21991,11629,23046,29201,18536,14784,15998,10452,14281,21705,28741,28153,10101,18535,28716,4372,15282,19870,12944,9040,22535,9055,12778,27893,28794,18371,18582,12450,23614,27200,29705,26749,19956,27639,29560,16834,15832,22556,28372,10942,15873,23510,16482,16847,30089,2671,24795,28951,20573,22559,6735,29105,22855,28518,4409,2785,28637,29474,13867,18700,22746,22234,29390,22530,15681,29545,29617,23797,29368,12411,29360,10208,15105,17178,20032,26836,24308,8771,9396,23835,10752,28460,22056,26756,20521,23581,8274,14801,18608,17143,19780,20355,27165,18724,6101,2410,26964,20546,4348,5762,13356,23095,26772,3984,18538,29530,20944,29138,27764,26846,26915,27410,10650,12445,27480,28565,11119,27257,26988,4103,24361,2335,22612,7812,13265,26255,22457,28004,20749,16973,27424,21484,27142,23604,15423,14388,12701,13783,10933,13584,3802,2223,27146,27416,22534,28270,27706,3379,7867,2918,26935,13310,11272,11560,15112,3154,27272,29869,12264,20917,20240,22836,23307,27041,9826,23680,12832,21334,28599,15801,11818,23216,3623,2831,10503,27746,20553,26690,27602,21068,21230,22876,10159,23544,20662,16624,27114,18636,22043,27833,21397,11051,10570,3575,28744,4105,29552,17141,11052,9739,24753,11613,21837,29022,13034,15802,29566,20675,26672,11936,8528,27144,17027,26878,29580,9961,18554,28657,27894,22893,29817,7632,5857,23282,28015,26954,26620,29602,26097,28360,27473,16014,23394,22279,3252,28851,5900,19846,29616,6192,28379,13078,18351,27682,11077,23681,15838,22891,28846,11971,24725,15897,9725,24962,29091,15646,21571,17249,24216,12580,18348,27728,3651,22798,28789,20691,28394,28989,10571,14102,26810,27153,22728,21228,2163,21092,23894,18409,27207,27854,29389,26639,13953,2673,16293,19849,20507,15570,16611,22751,3364,9253,21426,3225,3302,27547,10665,16610,26660,13620,14065,28045,13051,23753,27878,24683,15563,20643,23643,24577,23955,21932,24804,28573,8783,15999,23523,18365,29689,17177,10475,20001,15899,23854,27624,6522,7783,28373,22106,26768,11521,27408,13002,2182,22181,23818,23515,27230,15131,23624,22071,29609,29355,2769,8057,15582,23381,27294,13879,23594,29760,3801,15428,15869,29651,11334,2334,26848,29544,22328,12791,28148,26813,21729,10160,21106,23626,22261,23772,23304,27770,17014,27906,20807,28123,8378,15106,10040,22972,27475,18332,6978,9251,15079,27766,3744,24580,2278,27586,29515,13067,22761,5815,26729,26617,28377,27935,18498,24718,28921,28827,23004,26391,29654,18333,29585,10003,27891,11686,24125,13097,12161,8861,26864,30173,17254,23547,27280,13551,11871,22336,29658,7120,14929,19922,20709,26902,7963,12182,24419,18720,24674,18591,7249,12725,10704,26396,21541,28737,3459,10088,3114,29563,3568,27157,18336,21337,29432,28726,27470,28784,17132,15872,22856,29343,16947,27029,11238,24248,26401,24738,14928,27278,28515,18628,3375,22725,9332,8714,16114,26554,24985,5616,29166,20919,6899,29937,2669,9442,8237,24744,24004,20000,15901,4282,21704,27338,21533,10548,15965,22044,28470,26980,2392,2451,2194,2159,9290,24208,2637,20652,10347,27444,12794,17168,29154,24299,5646,18502,8001,8828,11870,22497,7985,26719,27559,26797,20401,21038,26934,28777,21095,27307,12189,26110,26913,22400,9401,23097,15067,2716,9366,27749,14060,9133,26286,27603,23479,13447,26904,15492,23803,15387,15880,16618,18581,28617,10567,27426,16146,12452,10604,3958,11287,2236,21569,2408,12886,28251,28342,21497,12583,7560,26947,29900,22103,23567,28968,28983,11554,22884,9301,11023,28980,22626,13357,28822,29528,6212,15595,22853,23302,6975,15115,23456,29695,22729,20522,24064,21498,14798,16150,28516,10606,23385,10312,22900,11135,18564,24050,26963,3399,18618,22370,18270,6047,26662,28108,21078,17133,28009,19952,3847,29769,28801,11430,15857,2266,22799,16487,29446,28382,30124,14380,20518,10575,2404,2766,20570,29666,10106,24520,13622,20505,2512,27774,23600,22402,8801,29570,22303,28113,24340,23347,17248,23283,21031,18530,12453,15913,26153,9849,10024,29505,8160,23730,27987,17209,11805,20658,9696,4119,2564,23504,15385,20364,2288,29336,24438,18321,11690,6122,9052,21256,22167,23853,20827,27100,22658,23916,22341,27701,13364,26773,22096,18383,22784,9279,24203,26093,10210,19880,9050,23387,12811,23469,17173,26134,2327,27217,15843,27471,7813,16700,15678,3454,16641,29426,16582,12195,13450,23775,27069,16957,8051,12486,4286,24509,12114,28782,21373,23483,16116,24736,2416,27705,20634,21172,21998,23974,10033,12317,22108,22565,22461,27930,11917,2322,27224,24977,23382,16397,29430,7278,24091,9252,9132,22275,10238,7873,13141,20828,11062,22443,29709,26518,6504,21181,26022,6717,12012,26469,17138,16185,5804,16151,27581,26717,22883,2320,26663,22444,29352,27593,20112,26818,17260,17235,10535,20566,23777,28135,13588,2231,15065,21668,2679,29573,28972,29471,24415,3948,20339,13925,27036,16915,16949,21222,27616,27661,16661,17244,28151,16680,18463,26874,23618,16290,10179,6750,18556,2866,22309,20677,22375,16955,12625,15695,12782,7652,8243,29513,7902,24517,6075,21709,24190,29434,20786,28574,8791,16595,6711,14800,29568,21598,22617,14542,21732,26590,27084,3414,13906,27882,27208,27247,9482,12771,18443,19843,29401,27453,28671,28723,7872,23726,27167,29477,27076,26837,28867,23178,24031,8709,12148,29026,6166,26160,28974,20400,26806,22473,3939,27364,24220,21685,24174,23659,29779,8802,28793,27149,26257,26805,15643,28367,23780,28104,28854,28094,9854,21198,28735,26284,28913,18594,26921,16838,21192,26483,27621,26516,5866,27099,16921,21083,28357,28114,5652,13088,17088,26982,16242,16669,20624,12291,27113,27605,15257,12834,20365,15493,28512,29353,28889,24440,24913,28156,16846,14285,4273,29394,23878,28524,28792,18637,28467,11020,9426,24645,26615,29042,21402,21761,22124,23587,18627,24959,16119,26007,27423,26488,27407,12781,2355,27204,6236,20778,23346,11359,16241,24714,15596,9825,26493,15902,28414,10194,11866,27789,13026,12513,15258,29086,4101,27916,10413,29583,6213,16922,27275,30041,27950,30126,29126,21687,28843,26922,28838,26152,7371,9434,29717,28406,7033,15162,11424,26311,18545,26379,7705,24836,3945,8090,12451,29956,24062,11949,14938,22861,23972,12821,20594,16848,21900,23820,26761,24903,28527,5859,3270,26162,28680,16666,23814,27715,8674,20756,26470,29387,23539,28534,12873,28088,29192,3736,28078,27325,8002,10819,3603,26849,29200,26360,15254,24206,13907,9389,7832,15756,15497,18614,12915,20017,10086,26804,10951,22730,23718,5800,3991,15325,18544,14799,29546,11614,11285,3102,16414,29451,15611,2855,20446,10436,15660,10333,3692,18703,28522,29341,13399,8966,9121,23261,2474,13336,16958,27692,24214,19897,27484,28807,26395,21990,28837,27375,19963,29538,14764,20648,16144,15912,2221,14242,20628,28416,19797,13845,20366,26632,8965,24673,27441,22293,23828,27403,26949,29084,11326,26844,22820,7903,21770,10672,22952,21646,21123,4541,10173,23724,5927,19991,15883,6128,16579,2264,26789,22295,22645,3455,29249,20906,21871,12467,13143,18687,15822,15962,11269,27070,23620,23362,29399,27268,24896,4148,27969,2406,19825,27903,26847,15100,12269,11868,16208,11903,10751,23821,22458,28286,23815,10230,27897,28979,18532,16913,4587,21713,27905,4144,29584,18725,17161,15063,21570,26511,4075,14332,21738,29011,23125,11068,20002,14333,30090,22892,6248,26908,20402,13035,11389,2891,14918,16331,26381,28927,29155,29582,14416,26385,22041,8879,21794,29400,3440,15765,10039,20241,27256,5802,10760,28365,29028,22801,18638,12809,26108,20116,11611,29622,20113,20205,3413,22042,13621,21601,8680,20450,11810,20884,24414,15283,29454,13263,15834,11271,21534,24036,19944,27168,20357,22266,26389,13073,26561,29333,20440,24781,17040,27628,16612,10435,29075,2244,2590,26295,15805,20800,26960,8804,21702,13299,6165,19842,29320,2349,24370,21941,5653,15062,28352,22923,26919,28227,27761,10025,23882,27528,28652,8086,28603,23182,24990,29697,2254,24707,18629,22107,11488,18639,22092,27136,27732,16628,21325,21585,10705,23545,27000,26938,28732,29051,11571,28655,23951,19931,17029,24938,27814,29251,5810,8056,13064,27946,28002,9412,22520,23966,27619,29012,18426,26686,27398,27719,26689,23003,10254,10649,29103,11582,20135)

GROUP BY pv.id
	,pv.name
	,w.Id
	,w.name
HAVING SUM(cws.requiredstock) < SUM(cws.shelved) + SUM(cws.markedforrecall)
--ORDER BY 11 ASC
