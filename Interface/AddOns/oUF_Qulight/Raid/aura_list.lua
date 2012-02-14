local _, ns = ...

local spellcache = setmetatable({}, {__index=function(t,v) local a = {GetSpellInfo(v)} if GetSpellInfo(v) then t[v] = a end return a end})
local function GetSpellInfo(a)
    return unpack(spellcache[a])
end

ns.auras = {
    -- Ascending aura timer
    -- Add spells to this list to have the aura time count up from 0
    -- NOTE: This does not show the aura, it needs to be in one of the other list too.
    ascending = {
        [GetSpellInfo(92956)] = true, -- Wrack
    },

    -- Any Zone
    debuffs = {
        --[GetSpellInfo(6788)] = 16, -- Weakened Soul
        [GetSpellInfo(39171)] = 9, -- Mortal Strike
        [GetSpellInfo(76622)] = 9, -- Sunder Armor
		-- Death Knight
		[GetSpellInfo(47476)] = 3, --strangulate
	-- Druid
		[GetSpellInfo(33786)] = 3, --Cyclone
		[GetSpellInfo(2637)] = 3, --Hibernate
		[GetSpellInfo(339)] = 3, --Entangling Roots
		[GetSpellInfo(80964)] = 3, --Skull Bash
		[GetSpellInfo(78675)] = 3, --Solar Beam
	-- Hunter
		[GetSpellInfo(3355)] = 3, --Freezing Trap Effect
		[GetSpellInfo(1513)] = 3, --scare beast
		[GetSpellInfo(19503)] = 3, --scatter shot
		[GetSpellInfo(34490)] = 3, --silence shot
	-- Mage
		[GetSpellInfo(31661)] = 3, --Dragon's Breath
		[GetSpellInfo(61305)] = 3, --Polymorph
		[GetSpellInfo(18469)] = 3, --Silenced - Improved Counterspell
		[GetSpellInfo(122)] = 3, --Frost Nova
		[GetSpellInfo(55080)] = 3, --Shattered Barrier
	-- Paladin
		[GetSpellInfo(20066)] = 3, --Repentance
		[GetSpellInfo(10326)] = 3, --Turn Evil
		[GetSpellInfo(853)] = 3, --Hammer of Justice
	-- Priest
		[GetSpellInfo(605)] = 3, --Mind Control
		[GetSpellInfo(64044)] = 3, --Psychic Horror
		[GetSpellInfo(8122)] = 3, --Psychic Scream
		[GetSpellInfo(9484)] = 3, --Shackle Undead
		[GetSpellInfo(15487)] = 3, --Silence
		--[GetSpellInfo(6788)] = 1, --󴢊	-- Rogue
		[GetSpellInfo(2094)] = 3, --Blind
		[GetSpellInfo(1776)] = 3, --Gouge
		[GetSpellInfo(6770)] = 3, --Sap
		[GetSpellInfo(18425)] = 3, --Silenced - Improved Kick
	-- Shaman
		[GetSpellInfo(51514)] = 3, --Hex
		[GetSpellInfo(3600)] = 3, --Earthbind
		[GetSpellInfo(8056)] = 3, --Frost Shock
		[GetSpellInfo(63685)] = 3, --Freeze
		[GetSpellInfo(39796)] = 3, --Stoneclaw Stun
	-- Warlock
		[GetSpellInfo(710)] = 3, --Banish
		[GetSpellInfo(6789)] = 3, --Death Coil
		[GetSpellInfo(5782)] = 3, --Fear
		[GetSpellInfo(5484)] = 3, --Howl of Terror
		[GetSpellInfo(6358)] = 3, --Seduction
		[GetSpellInfo(30283)] = 3, --Shadowfury
		[GetSpellInfo(89605)] = 3, --Aura of Foreboding
	-- Warrior
		[GetSpellInfo(20511)] = 3, --Intimidating Shout
	-- Racial
		[GetSpellInfo(25046)] = 3, --Arcane Torrent
		[GetSpellInfo(20549)] = 3, --War Stomp
    },
	tankauras = {
		[GetSpellInfo(871)] = 1,	-- 盾墙
		[GetSpellInfo(12975)] = 1,	--破釜沉舟
		[GetSpellInfo(97463)] = 1,	--集结呐喊
		[GetSpellInfo(2565)] = 1,	--盾牌格挡
		--------------------------骑士---------------
		[GetSpellInfo(642)] = 1,	--圣盾术
		[GetSpellInfo(86659)] = 1,	--远古列王守卫
		[GetSpellInfo(70940)] = 1,	--神圣守卫
		[GetSpellInfo(31850)] = 1,	--炽热防御者
		[GetSpellInfo(498)] = 1,	--圣佑术
		[GetSpellInfo(1022)] = 1,	--保护之手
		[GetSpellInfo(1038)] = 1,	--拯救之手
		[GetSpellInfo(6940)] = 1,	--牺牲之手
		
		--------------------------DK---------------
		[GetSpellInfo(48707)] = 1,	--反魔法护罩
		[GetSpellInfo(50461)] = 1,	--反魔法领域
		--[GetSpellInfo(49222)] = 1,	--白骨之盾
		[GetSpellInfo(48792)] = 1,	--冰封之韧
		[GetSpellInfo(55233)] = 1,	--吸血鬼之血
		------------------------德鲁伊---------------
		[GetSpellInfo(22812)] = 1,	--树皮术
		[GetSpellInfo(22842)] = 1,	--狂暴回复
		[GetSpellInfo(61336)] = 1,	--生存本能
		------------------------牧师--------------------
		[GetSpellInfo(33206)] = 1, --痛苦压制
		[GetSpellInfo(47788)] = 1, --守护之魂
	},

    buffs = {
        --[GetSpellInfo(32223)] = 15, -- Just for testing
        --[GetSpellInfo(871)] = 15, -- Shield Wall
    },

    -- Raid Debuffs
    instances = {
        --["MapID"] = {
        --	[Name or GetSpellInfo(#)] = PRIORITY,
        --},

        [800] = { --[[ Firelands ]]--
				--Firelands
			--Flamewaker Forward Guard
			[GetSpellInfo(76622)] = 5,	--Sunder Armor
			[GetSpellInfo(99610)] = 6,	--Shockwave
			--Flamewaker Pathfinder
			[GetSpellInfo(99695)] = 5,	--Flaming Spear
			[GetSpellInfo(99800)] = 5, 		--Ensnare
			--Flamewaker Cauterizer
			--[GetSpellInfo(99625)] = 5,	--Conflagration (Magic/dispellable)
			--Fire Scorpion
			[GetSpellInfo(99993)] = 5,	--Fiery Blood
			--Molten Lord
			[GetSpellInfo(100767)] = 5,	--Melt Armor
			--Ancient Core Hound
			--[GetSpellInfo(99692, 1, 4, 4) 		--Terrifying Roar (Magic/dispellable)
			[GetSpellInfo(99693)] = 5,	--Dinner Time
			--Magma
			[GetSpellInfo(97151)] = 5,	--Magma

			--Beth'tilac
			[GetSpellInfo(99506)] = 5,		--The Widow's Kiss
			--Cinderweb Drone
			[GetSpellInfo(49026)] = 7,		--Fixate
			--Cinderweb Spinner
			[GetSpellInfo(97202)] = 6,		--Fiery Web Spin
			--Cinderweb Spiderling99693
			[GetSpellInfo(97079)] = 5,		--Seeping Venom
			--Cinderweb Broodling
			--Also cast fixate, same one as above?

			--Lord Rhyolith
			[GetSpellInfo(98492)] = 5,	--Eruption

			--Alysrazor
			[GetSpellInfo(101729)] = 6,	--Blazing Claw
			[GetSpellInfo(100094)] = 5,	--Fieroblast
			[GetSpellInfo(99389)] = 6,	--Imprinted
			[GetSpellInfo(99308)] = 5,	--Gushing Wound
			[GetSpellInfo(100640)] = 7,	--Harsh Winds
			[GetSpellInfo(100555)] = 7,	--Smouldering Roots
			--Do we want to show these?
			[GetSpellInfo(99461)] = 5,	--Blazing Power
			--[GetSpellInfo(98734)] = 5,	--Molten Feather
			--[GetSpellInfo(98619)] = 5,	--Wings of Flame
			--[GetSpellInfo(100029)] = 5,	--Alysra's Razor

			--Shannox
			[GetSpellInfo(99936)] = 5,	--Jagged Tear
			[GetSpellInfo(99837)] = 8,	--Crystal Prison Trap Effect
			[GetSpellInfo(101208)] = 5,	--Immolation Trap
			[GetSpellInfo(99840)] = 5,	--Magma Rupture
			-- Riplimp
			--[GetSpellInfo(99937, 41, 5, 5, true, true) 		--Jagged Tear
			-- Rageface
			[GetSpellInfo(99947)] = 7,	--Face Rage
			[GetSpellInfo(100415)] = 6,	--Rage

			--Baleroc
			[GetSpellInfo(99252)] = 6,	--Blaze of Glory
			[GetSpellInfo(99256)] = 6,	--Torment
			[GetSpellInfo(99403)] = 7,	--Tormented
			[GetSpellInfo(99516)] = 8,	--Countdown
			[GetSpellInfo(99353)] = 8,	--Decimating Strike
			[GetSpellInfo(100908)] = 7,	--Fiery Torment

			--Majordomo Staghelm
			[GetSpellInfo(98535)] = 5,	--Leaping Flames
			[GetSpellInfo(98443)] = 6,	--Fiery Cyclone
			[GetSpellInfo(98450)] = 5,	--Searing Seeds
			--Burning Orbs
			[GetSpellInfo(100210)] = 6,	--Burning Orb
			-- ?
			[GetSpellInfo(96993)] = 5,	--Stay Withdrawn?

			--Ragnaros
			[GetSpellInfo(99399)] = 6,	--Burning Wound
			[GetSpellInfo(100293)] = 6,	--Lava Wave
			[GetSpellInfo(100238)] = 5,	--Magma Trap Vulnerability
			[GetSpellInfo(98313)] = 5,	--Magma Blast
			--Lava Scion
			[GetSpellInfo(100460)] = 8,	--Blazing Heat
			--Dreadflame?
			--Son of Flame
			--Lava
			[GetSpellInfo(98981)] = 6,	--Lava Bolt
			--Molten Elemental
			--Living Meteor
			[GetSpellInfo(100249)] = 6,	--Combustion
			--Molten Wyrms
			[GetSpellInfo(99613)] = 7,	--Molten Blast
        },

        [752] = { --[[ Baradin Hold ]]--

            [GetSpellInfo(88954)] = 6, -- Consuming Darkness
        },
        
        [754] = { --[[ Blackwing Descent ]]--

            --Magmaw
            [GetSpellInfo(78941)] = 6, -- Parasitic Infection
            [GetSpellInfo(89773)] = 7, -- Mangle

            --Omnitron Defense System
            [GetSpellInfo(79888)] = 6, -- Lightning Conductor
            [GetSpellInfo(79505)] = 8, -- Flamethrower
            [GetSpellInfo(80161)] = 7, -- Chemical Cloud
            [GetSpellInfo(79501)] = 8, -- Acquiring Target
            [GetSpellInfo(80011)] = 7, -- Soaked in Poison
            [GetSpellInfo(80094)] = 7, -- Fixate
            [GetSpellInfo(92023)] = 9, -- Encasing Shadows
            [GetSpellInfo(92048)] = 9, -- Shadow Infusion
            [GetSpellInfo(92053)] = 9, -- Shadow Conductor
            --[GetSpellInfo(91858)] = 6, -- Overcharged Power Generator
            
            --Maloriak
            [GetSpellInfo(92973)] = 8, -- Consuming Flames
            [GetSpellInfo(92978)] = 8, -- Flash Freeze
            [GetSpellInfo(92976)] = 7, -- Biting Chill
            [GetSpellInfo(91829)] = 7, -- Fixate
            [GetSpellInfo(92787)] = 9, -- Engulfing Darkness

            --Atramedes
            [GetSpellInfo(78092)] = 7, -- Tracking
            [GetSpellInfo(78897)] = 8, -- Noisy
            [GetSpellInfo(78023)] = 7, -- Roaring Flame

            --Chimaeron
            [GetSpellInfo(89084)] = 8, -- Low Health
            [GetSpellInfo(82881)] = 7, -- Break
            [GetSpellInfo(82890)] = 9, -- Mortality

            --Nefarian
            [GetSpellInfo(94128)] = 7, -- Tail Lash
            --[GetSpellInfo(94075)] = 8, -- Magma
            [GetSpellInfo(79339)] = 9, -- Explosive Cinders
            [GetSpellInfo(79318)] = 9, -- Dominion
        },

        [758] = { --[[ The Bastion of Twilight ]]--

            --Halfus
            [GetSpellInfo(39171)] = 7, -- Malevolent Strikes
            [GetSpellInfo(86169)] = 8, -- Furious Roar

            --Valiona & Theralion
            [GetSpellInfo(86788)] = 6, -- Blackout
            [GetSpellInfo(86622)] = 7, -- Engulfing Magic
            [GetSpellInfo(86202)] = 7, -- Twilight Shift

            --Council
            [GetSpellInfo(82665)] = 7, -- Heart of Ice
            [GetSpellInfo(82660)] = 7, -- Burning Blood
            [GetSpellInfo(82762)] = 7, -- Waterlogged
            [GetSpellInfo(83099)] = 7, -- Lightning Rod
            [GetSpellInfo(82285)] = 7, -- Elemental Stasis
            [GetSpellInfo(92488)] = 8, -- Gravity Crush

            --Cho'gall
            [GetSpellInfo(86028)] = 6, -- Cho's Blast
            [GetSpellInfo(86029)] = 6, -- Gall's Blast
            [GetSpellInfo(93189)] = 7, -- Corrupted Blood
            [GetSpellInfo(93133)] = 7, -- Debilitating Beam
            [GetSpellInfo(81836)] = 8, -- Corruption: Accelerated
            [GetSpellInfo(81831)] = 8, -- Corruption: Sickness
            [GetSpellInfo(82125)] = 8, -- Corruption: Malformation
            [GetSpellInfo(82170)] = 8, -- Corruption: Absolute

            --Sinestra
            [GetSpellInfo(92956)] = 9, -- Wrack
        },

        [773] = { --[[ Throne of the Four Winds ]]--

            --Conclave
            [GetSpellInfo(85576)] = 9, -- Withering Winds
            [GetSpellInfo(85573)] = 9, -- Deafening Winds
            [GetSpellInfo(93057)] = 7, -- Slicing Gale
            [GetSpellInfo(86481)] = 8, -- Hurricane
            [GetSpellInfo(93123)] = 7, -- Wind Chill
            [GetSpellInfo(93121)] = 8, -- Toxic Spores

            --Al'Akir
            --[GetSpellInfo(93281)] = 7, -- Acid Rain
            [GetSpellInfo(87873)] = 7, -- Static Shock
            [GetSpellInfo(88427)] = 7, -- Electrocute
            [GetSpellInfo(93294)] = 8, -- Lightning Rod
            [GetSpellInfo(93284)] = 9, -- Squall Line
        },
		-- Dragon Soul
	   [824] = {
		  --Morchok
		  [GetSpellInfo(103687)] = 11, --Crush Armor
		  [GetSpellInfo(103821)] = 12, --Earthen Vortex
		  [GetSpellInfo(103785)] = 13, --Black Blood of the Earth
		  [GetSpellInfo(103534)] = 14, --Danger (Red)
		  [GetSpellInfo(103536)] = 15, --Warning (Yellow)
		  -- Don't need to show Safe people
		  [GetSpellInfo(103541)] = 16, --Safe (Blue)

		  --Warlord Zon'ozz
		  [GetSpellInfo(104378)] = 21, --Black Blood of Go'rath
		  [GetSpellInfo(103434)] = 22, --Disrupting Shadows (dispellable)

		  --Yor'sahj the Unsleeping
		  [GetSpellInfo(104849)] = 31, --Void Bolt
		  [GetSpellInfo(105171)] = 32, --Deep Corruption

		  --Hagara the Stormbinder
		  [GetSpellInfo(105316)] = 41, --Ice Lance
		  [GetSpellInfo(105465)] = 42, --Lightning Storm
		  [GetSpellInfo(105369)] = 43, --Lightning Conduit
		  [GetSpellInfo(105289)] = 44, --Shattered Ice (dispellable)
		  [GetSpellInfo(105285)] = 45, --Target (next Ice Lance)
		  [GetSpellInfo(104451)] = 46, --Ice Tomb
		  [GetSpellInfo(110317)] = 47, --Watery Entrenchment

		  --Ultraxion
		  [GetSpellInfo(105925)] = 51, --Fading Light
		  [GetSpellInfo(106108)] = 52, --Heroic Will
		  [GetSpellInfo(105984)] = 53, --Timeloop
		  [GetSpellInfo(105927)] = 54, --Faded Into Twilight

		  --Warmaster Blackhorn
		  [GetSpellInfo(108043)] = 61, --Sunder Armor
		  [GetSpellInfo(107558)] = 62, --Degeneration
		  [GetSpellInfo(107567)] = 64, --Brutal Strike
		  [GetSpellInfo(108046)] = 64, --Shockwave

		  --Spine of Deathwing
		  [GetSpellInfo(105563)] = 71, --Grasping Tendrils
		  [GetSpellInfo(105479)] = 72, --Searing Plasma
		  [GetSpellInfo(105490)] = 73, --Fiery Grip

		  --Madness of Deathwing
		  [GetSpellInfo(105445)] = 81, --Blistering Heat
		  [GetSpellInfo(105841)] = 82, --Degenerative Bite
		  [GetSpellInfo(106385)] = 83, --Crush
		  [GetSpellInfo(106730)] = 84, --Tetanus
		  [GetSpellInfo(106444)] = 85, --Impale
		  [GetSpellInfo(106794)] = 86, --Shrapnel (target)
	   },
    },
}
