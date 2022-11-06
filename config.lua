Config = {}

Config.ShowBlips = true
Config.PromptKey = 0xE30CD707 -- R

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'

Config.LicenseRank = 1

Config.Locations = {
    ["duty"] = {
        [1] = vector3(1362.05, -1301.83, 77.77), -- Rhodes
        [2] = vector3(-1812.03, -354.09, 164.65), -- Strawberry
        [3] = vector3(-277.86, 807.47, 119.38), --valentine
    },
    ["stash"] = {
        [1] = vector3(1359.24, -1299.65, 77.76), -- Rhodes
        [2] = vector3(-1812.43, -355.87, 164.65), -- Strawberry
        [3] = vector3(-277.57, 810.22, 119.38) --valentine
    },
    ["vehicle"] = {
        [1] = vector4(-278.82, 826.41, 119.33, 7.5), -- Valentine Stable
        [2] = vector4(1380.34, -1329.07, 77.64, 176.64), -- Rhodes
    },
    ["armory"] = {
        [1] = vector3(1361.16, -1305.7, 77.76), -- Rhodes
        [2] = vector3(-1814.01, -354.93, 164.65), -- Strawberry
        [3] = vector3(-278.38, 805.15, 119.38), --valentine
    },
    ["evidence"] = {
        [1] = vector3(1361.39, -1303.77, 77.77), -- Rhodes
        [2] = vector3(-1812.43, -355.87, 164.65), -- Strawberry
        [3] = vector3(-278.61, 807.48, 119.38) --valentine
    },
    ["stations"] = {
        [1] = {label = "Sheriff", coords = vector3(1360.88, -1301.53, 77.77)}, -- Rhodes
        [2] = {label = "Marshal HQ", coords = vector3(2501.83, -1309.04, 48.95)}, -- Saint Denis
        [3] = {label = "Marshal Field Office", coords = vector3(-760.47, -1269.14, 44.04)}, -- Blackwater
        [4] = {label = "Sheriff", coords = vector3(-1810.57, -350.91, 164.66)}, -- Strawberry
        [5] = {label = "Sheriff", coords = vector3(-275.65, 808.62, 119.38)}, --valentine
    },
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 1
	[1] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 2
	[2] = {
		["policewagon01x"] = "Police Vagon",
	},
	-- Grade 3
	[3] = {
		["policewagon01x"] = "Police Vagon",
	}
}

Config.WeaponHashes = {}

Config.ArmoryWhitelist = {}
Config.WhitelistedVehicles = {}

Config.Items = {
    label = "Police Armory",
    slots = 6,
    items = {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3}
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3}
        },
        {
            name = "weapon_melee_lantern",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3}
        },
        {
            name = "weapon_lasso",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3}
        },
        {
            name = "ammo_revolver",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3}
        },
        {
            name = "ammo_repeater",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3}
        },
    }
}
