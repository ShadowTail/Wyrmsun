--       _________ __                 __
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      grand_strategy_events.lua - Defines the grand strategy events.
--
--      (c) Copyright 2015 by Andre Novellino Gouv�a
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--

local ChristianityEvents = {
	PalladiusBishopOfIreland = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �14.
		Name = "Palladius, Bishop of PROVINCE_NAME",
		Description = "The Pope has ordained the Briton deacon Palladius as the first bishop of PROVINCE_NAME, sending him to administer the small community of the faithful there, and to promote Christianity amongst the non-believers.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Ireland.Owner == EventFaction.Name
				and GrandStrategyYear == 431
			) then
				EventProvince = WorldMapProvinces.Ireland
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	PalladiusFailure = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �14.
		Name = "Palladius' Failure",
		Description = "The bishop of PROVINCE_NAME Palladius, faced with great difficulties, has desisted from his mission of promoting Christianity there. He left with his assistants for the northern parts of Great Britain, where his days ended.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Ireland.Owner == EventFaction.Name
				and SyncRand(100) < 80
			) then
				EventProvince = WorldMapProvinces.Ireland
				return true
			else
				return false
			end
		end,
		RequiredEvents = {
			PalladiusBishopOfIreland = true
		},
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research - 1
				GrandStrategyEvents.PalladiusTheApostleOfIreland = nil
			end
		},
		OptionTooltips = {"-1 Research"}
	},
	PalladiusTheApostleOfIreland = { -- ahistorical success of Palladius in converting the Irish
		Name = "Palladius, the Apostle of PROVINCE_NAME",
		Description = "Palladius has succeeded in converting the people of PROVINCE_NAME to the Christian faith!",
		Conditions = function(s)
			if (
				WorldMapProvinces.Ireland.Owner == EventFaction.Name
				and SyncRand(100) < 20
			) then
				EventProvince = WorldMapProvinces.Ireland
				return true
			else
				return false
			end
		end,
		RequiredEvents = {
			PalladiusBishopOfIreland = true
		},
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
				GrandStrategyEvents.PalladiusFailure = nil
				GrandStrategyEvents.PatrickTheApostleOfIreland = nil
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	PatrickTheApostleOfIreland = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �14.
		Name = "Patrick, the Apostle of Ireland",
		Description = "Patrick, the son of a deacon and grandson of a priest, was brought to PROVINCE_NAME as a slave when young, where he worked for six years as a shepherd. Having ran away from PROVINCE_NAME, he later had a dream instigating him to come back to the island and help propagate the Christian faith there. After his return to PROVINCE_NAME, Patrick personally baptized many thousands, successfully gaining the island for Christianity. \"The Irish\", he said, \"who never had the knowledge of God and worshipped only idols and unclean things, have lately become the people of the Lord\".",
		Conditions = function(s)
			if (
				WorldMapProvinces.Ireland.Owner == EventFaction.Name
				and GrandStrategyYear >= 440
				and GrandStrategyYear <= 493 -- when Patrick died
			) then
				EventProvince = WorldMapProvinces.Ireland
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	ColumbaMissionaryToScotland = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Columba, Missionary to PROVINCE_NAME",
		Description = "The Irish missionary Columba has arrived with twelve companions in the settlement of Hy in PROVINCE_NAME to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Scotland.Owner == EventFaction.Name
				and GrandStrategyYear == 563
			) then
				EventProvince = WorldMapProvinces.Scotland
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	MohonnaMissionaryToThePicts = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Mohonna, Missionary to the Picts",
		Description = "The missionary Mohonna has been sent by Columba to christianize the Picts.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Scotland.Owner == EventFaction.Name
			) then
				EventProvince = WorldMapProvinces.Scotland
				return true
			else
				return false
			end
		end,
		RequiredEvents = {
			ColumbaMissionaryToScotland = true
		},
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	TheMissionOfAugustine = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �10.
		Name = "The Mission of Augustine",
		Description = "The Pope has sent the Benedictine abbot Augustine on a mission to propagate Christianity in PROVINCE_NAME. He has arrived with thirty other monks, along with a priest called Laurentius and some translators. Augustine carried, besides papal instructions, letters of recommendation and a few books.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
				and GrandStrategyYear >= 596
				and GrandStrategyYear <= 604 -- when Augustine died
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		Options = {"~!Welcome him warmly", "Pay him no ~!heed"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
				GrandStrategyEvent(EventFaction, GrandStrategyEvents.AugustineArchbishopOfEngland)
			end,
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research", "+1 Research"}
	},
	AugustineArchbishopOfEngland = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �10.
		Name = "Augustine, Archbishop of PROVINCE_NAME",
		Description = "With our friendship, Augustine was able to perform his work with much efficaciousness. As a result of his successes, he has been ordained archbishop of PROVINCE_NAME.",
		TriggeredOnly = true,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	TheChurchAtCanterbury = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �10.
		Name = "The Church at Canterbury",
		Description = "Archbishop Augustine has built a church at Canterbury, which shall be the center of the Christian faith in PROVINCE_NAME.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
--				and ProvinceHasBuildingType(WorldMapProvinces.England, "temple")
				and GrandStrategyYear <= 604 -- when Augustine died
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		RequiredEvents = {
			AugustineArchbishopOfEngland = true
		},
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	TheConferenceAtAugustinesOak = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �11.
		Name = "The Conference at Augustine's Oak",
		Description = "Augustine, the archbishop of Canterbury, has arranged with our king's aid a conference with the Briton bishops. The meeting took place in Sussex, near the banks of the Severn under an oak. Augustine sought to make them give up their local religious traditions and accept the customs practiced in Rome, which they resisted. The Briton bishops said they needed the approval of their people to give up the old traditions, and asked for a second, larger conference to be held later.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
				and GrandStrategyYear <= 604 -- when Augustine died
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		RequiredEvents = {
			AugustineArchbishopOfEngland = true,
			TheChurchAtCanterbury = true -- to make this event happen a bit later
		},
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research - 1
			end
		},
		OptionTooltips = {"-1 Research"}
	},
	AugustinesSecondConference = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �11.
		Name = "Augustine's Second Conference",
		Description = "The Briton bishops have met archbishop Augustine in a second conference, having brought with them several scholars from the Convent of Bangor. The bishops had been advised by a venerated hermit to accept Augustine's propositions only if he stood up to talk to them, instead of speaking to them with arrogance from his seat. Augustine remained seated. He demanded that they accept Roman customs and help him in the conversion of PROVINCE_NAME. The bishops refused Augustine, who then predicted that they would suffer divine punishment through the Anglo-Saxons.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
				and GrandStrategyYear <= 604 -- when Augustine died
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		RequiredEvents = {
			TheConferenceAtAugustinesOak = true
		},
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research - 1
			end
		},
		OptionTooltips = {"-1 Research"}
	},
	MellitusConsecratedBishopOfLondon = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �10.
		Name = "Mellitus Ordained Bishop of PROVINCE_SETTLEMENT_NAME",
		Description = "Mellitus, a priest sent by the Pope to PROVINCE_NAME, has been consecrated bishop of PROVINCE_SETTLEMENT_NAME.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
				and GrandStrategyYear == 604
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	JustusConsecratedBishopOfRochester = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �10.
		Name = "Justus Ordained Bishop of Rochester",
		Description = "Justus, a priest sent by the Pope to PROVINCE_NAME, has been consecrated bishop of Rochester.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
				and GrandStrategyYear == 604
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	ColumbanusMissionaryToFrance = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Columbanus, Missionary to PROVINCE_NAME",
		Description = "The Irish missionary Columbanus has arrived with twelve companions in PROVINCE_NAME to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.France.Owner == EventFaction.Name
				and GrandStrategyYear == 612
			) then
				EventProvince = WorldMapProvinces.France
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	PaulinusAppointedArchbishopOfYork = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �10.
		Name = "Paulinus Appointed Archbishop of York",
		Description = "Paulinus, who had been sent by the Pope to PROVINCE_NAME to aid in the promotion of Christianity there, has been appointed the archbishop of York.",
		Conditions = function(s)
			if (
				WorldMapProvinces.England.Owner == EventFaction.Name
				and GrandStrategyYear == 625
			) then
				EventProvince = WorldMapProvinces.England
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	KilianMissionaryToFranconia = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Kilian, Missionary to Franconia",
		Description = "The Irish missionary Kilian has arrived with twelve companions in Franconia to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Bavaria.Owner == EventFaction.Name
				and WorldMapProvinces.Bavaria.Civilization == "germanic" -- Franconia wouldn't have that name if it isn't germanic-culture (since it receives its name from the Franks, a germanic tribe)
				and GrandStrategyYear == 680
			) then
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	EloquiusMissionaryToBelgium = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Eloquius, Missionary to PROVINCE_NAME",
		Description = "The Irish missionary Eloquius has arrived with twelve companions in PROVINCE_NAME to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Belgium.Owner == EventFaction.Name
				and GrandStrategyYear == 680
			) then
				EventProvince = WorldMapProvinces.Belgium
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	WillibrordMissionaryToFriesland = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Willibrord, Missionary to PROVINCE_NAME",
		Description = "The missionary Willibrord, who studied for twelve years in Ireland, has arrived with twelve companions in PROVINCE_NAME to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Netherlands.Owner == EventFaction.Name
				and GrandStrategyYear == 692
			) then
				EventProvince = WorldMapProvinces.Netherlands
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	RupertMissionaryToBavaria = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Rupert, Missionary to PROVINCE_NAME",
		Description = "The Irish missionary Rupert has arrived with twelve companions in PROVINCE_NAME to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Bavaria.Owner == EventFaction.Name
				and GrandStrategyYear == 700
			) then
				EventProvince = WorldMapProvinces.Bavaria
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	},
	ForannanMissionaryToFrontierOfBelgium = { -- Source: Philip Schaff, "History of the Christian Church", 1997, �15.
		Name = "Forannan, Missionary to the Frontier of PROVINCE_NAME",
		Description = "The Irish missionary Forannan has arrived with twelve companions in the frontier of PROVINCE_NAME to spread the Christian faith.",
		Conditions = function(s)
			if (
				WorldMapProvinces.Belgium.Owner == EventFaction.Name
				and GrandStrategyYear == 970
			) then
				EventProvince = WorldMapProvinces.Belgium
				return true
			else
				return false
			end
		end,
		Options = {"~!OK"},
		OptionEffects = {
			function(s)
				EventFaction.Research = EventFaction.Research + 1
			end
		},
		OptionTooltips = {"+1 Research"}
	}
}
	
AddEventTable(ChristianityEvents)