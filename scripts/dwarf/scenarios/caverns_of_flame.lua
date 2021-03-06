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
--      scepter_of_fire_events.lua - Defines events for the Scepter of Fire campaign.
--
--      (c) Copyright 2014 by Andrettin
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

-- If Rugnur dies, any quests of the Scepter of Fire campaign currently being pursued fail
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if ((PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Bring the loaded Gnomish caravans and the envoy to your Mead Hall") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have one unit standing on each glyph at the same time") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Find Thursagan and bring him to your Mead Hall") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Mine 10000 gold and 20000 coal") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Get all heroes to the end of the tunnel") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Rugnur, Baglur and Thursagan must survive")) and (GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-rugnur") + GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-rugnur-steelclad") + GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-rugnur-thane")) < 1) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function() 
		RemovePlayerObjective(player, "- Bring the loaded Gnomish caravans and the envoy to your Mead Hall")
		RemovePlayerObjective(player, "- Have one unit standing on each glyph at the same time")
		RemovePlayerObjective(player, "- Find Thursagan and bring him to your Mead Hall")
		RemovePlayerObjective(player, "- Mine 10000 gold and 20000 coal")
		RemovePlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
		RemovePlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
		if (mapinfo.description == "Chaincolt Foothills" or mapinfo.description == "Caverns of Chaincolt" or mapinfo.description == "Northern Wastelands" or mapinfo.description == "Eastern Mines" or mapinfo.description == "Shorbear Hills" or mapinfo.description == "Svafnir's Lair" or mapinfo.description == "Caverns of Flame") then
			if (GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
				ActionDefeat()
				if (GrandStrategy) then
					if (PlayerHasObjective(GetThisPlayer(), "- Bring the loaded Gnomish caravans and the envoy to your Mead Hall")) then
						Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 2500 -- give the funds for Shinsplitter Clan if they managed to successfully stop the shipment
					end
					if (PlayerHasObjective(GetThisPlayer(), "- Have one unit standing on each glyph at the same time")) then
						Factions.NorlundClan.Gold = Factions.NorlundClan.Gold - 2500
						Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 2500
						-- if defenses have been breached, then the Shinsplitter Clan conquers the province
						WorldMapProvinces.CavernsOfChaincolt.Units.unit_gnomish_recruit = 0 -- kill off the gnomish envoy if the province has been conquered
						AcquireProvince(WorldMapProvinces.CavernsOfChaincolt, "Shinsplitter Clan")
					end
				end
			end
		end
		return false
	end
)

-- If Baglur dies, any quests of the Scepter of Fire campaign currently being pursued fail
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (
			(
				PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have one unit standing on each glyph at the same time")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Find Thursagan and bring him to your Mead Hall")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Mine 10000 gold and 20000 coal") 
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Get all heroes to the end of the tunnel")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Rugnur, Baglur and Thursagan must survive")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Durstorn and Baglur must survive")
			)
			and GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-baglur") + GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-baglur-thane") < 1
			and (GetFactionExists("Baglur") == false or GetPlayerData(GetFactionPlayer("Baglur"), "UnitTypesCount", "unit-hero-baglur") + GetPlayerData(GetFactionPlayer("Baglur"), "UnitTypesCount", "unit-hero-baglur-thane") < 1)
		) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function() 
		RemovePlayerObjective(player, "- Have one unit standing on each glyph at the same time")
		RemovePlayerObjective(player, "- Find Thursagan and bring him to your Mead Hall")
		RemovePlayerObjective(player, "- Mine 10000 gold and 20000 coal")
		RemovePlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
		RemovePlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
		if (GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
			ActionDefeat()
			if (GrandStrategy) then
				if (PlayerHasObjective(GetThisPlayer(), "- Have one unit standing on each glyph at the same time")) then
					Factions.NorlundClan.Gold = Factions.NorlundClan.Gold - 2500
					Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 2500
					-- if defenses have been breached, then the Shinsplitter Clan conquers the province
					WorldMapProvinces.CavernsOfChaincolt.Units.unit_gnomish_recruit = 0 -- kill off the gnomish envoy if the province has been conquered
					AcquireProvince(WorldMapProvinces.CavernsOfChaincolt, "Shinsplitter Clan")
				end
			end
		end
		return false
	end
)

-- If Thursagan dies, any quests of the Scepter of Fire campaign currently being pursued fail
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if ((PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Mine 10000 gold and 20000 coal") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Get all heroes to the end of the tunnel") or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Rugnur, Baglur and Thursagan must survive")) and GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-thursagan") < 1 and GetPlayerData(15, "UnitTypesCount", "unit-hero-thursagan") < 1) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function() 
		RemovePlayerObjective(player, "- Mine 10000 gold and 20000 coal")
		RemovePlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
		RemovePlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
		if (mapinfo.description == "Eastern Mines" or mapinfo.description == "Shorbear Hills" or mapinfo.description == "Svafnir's Lair" or mapinfo.description == "Caverns of Flame") then
			if (GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
				ActionDefeat()
			end
		end
		return false
	end
)

-- Caverns of Flame initial dialogue
-- based on the Caverns of Flame scenario of the Sceptre of Fire campaign from Battle for Wesnoth
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Explore as much of the cave as possible") == false) then
			for i=0,14 do
				if (GetPlayerData(i, "RaceName") == "dwarf" and (GetPlayerData(i, "Name") == "Norlund Clan" or GetPlayerData(i, "Name") == "Knalga") and (GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-steelclad") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-thane")) >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur-thane") >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-thursagan") >= 1) then
					player = i
					return true
				end
			end
		end
		return false
	end,
	function() 
		Event(
			"",
			"Rugnur and his companions had reached the realms of the goblins, with the Shinsplitters hot on their trail. And there was no exit from those caves, leaving the Norlunds no way out.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Rugnur",
				"Well, I think we've gotten a good distance ahead of the Shinsplitters. What do we do now?",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Thursagan",
					"We should keep going. This seems to be a volcano... I think we should try to cause it to erupt. It will kill all the Shinsplitters, and we might be able to find a safe place so the lava doesn't kill us.",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"Rugnur",
						"This sounds... plausible.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"Baglur",
							"Aye, an interesting plan. How do ye propose we do this?",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Thursagan",
								"I have a suspicion that there is an opening somewhere near here that leads to the surface. I have heard of ancient constructions such as I have seen here, of dwarven machinery of some kind that can cause the lava to flow.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Rugnur",
									"Very well. We will continue to explore until we find it.",
									player,
									{"~!Continue"},
									{function(s)
									Event(
										"Gryphon Rider",
										"My gryphon smells something... probably goblins in this cave!",
										player,
										{"~!Continue"},
										{function(s)
										Event(
											"Thursagan",
											"Indeed, there may be goblins lurking here. We should beware of them.",
											player,
											{"~!Continue"},
											{function(s)
												if (mapinfo.description == "Caverns of Flame") then
													RemovePlayerObjective(player, "- Defeat your enemies")
												end
												AddPlayerObjective(player, "- Explore as much of the cave as possible")
												AddPlayerObjective(player, "- Rugnur, Baglur and Thursagan must survive")
											end},
											"dwarf/icons/thursagan.png"
										)
										end},
										"dwarf/icons/gryphon_rider.png"
									)
									end},
									"dwarf/icons/baglur.png"
								)
								end},
								"dwarf/icons/thursagan.png"
							)
							end},
							"dwarf/icons/baglur.png"
						)
						end},
						"dwarf/icons/rugnur.png"
					)
					end},
					"dwarf/icons/thursagan.png"
				)
				end},
				"dwarf/icons/rugnur.png"
			)
			end},
			nil,
			nil,
			GrandStrategy
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Explore as much of the cave as possible") and GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "TotalNumUnits") < 1 and (GameCycle > 750 or (GetThisPlayer() == GetFactionPlayer("Shinsplitter Clan") and GameCycle > 350))) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		if (GrandStrategy == false) then
			unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y})
			OrderUnit(GetFactionPlayer("Shinsplitter Clan"), "unit-dwarven-thane", {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y}, {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7}, "move")
		elseif (GrandStrategyEventMap) then
			-- Shinsplitters
			local units_to_be_created = {}
			for i, unitName in ipairs(Units) do
				if (IsMilitaryUnit(unitName) and GetUnitTypeData(unitName, "Class") ~= "militia") then
					units_to_be_created[string.gsub(unitName, "-", "_")] = 0
					units_to_be_created[string.gsub(unitName, "-", "_")] = WorldMapProvinces.SouthernTunnels.Units[string.gsub(unitName, "-", "_")]
					WorldMapProvinces.SouthernTunnels.Units[string.gsub(unitName, "-", "_")] = WorldMapProvinces.SouthernTunnels.Units[string.gsub(unitName, "-", "_")] - units_to_be_created[string.gsub(unitName, "-", "_")]
				end
			end
			for i, unitName in ipairs(Units) do
				if (IsMilitaryUnit(unitName) and GetUnitTypeData(unitName, "Class") ~= "militia") then
					if (units_to_be_created[string.gsub(unitName, "-", "_")] > 0) then
						for i=1,(units_to_be_created[string.gsub(unitName, "-", "_")] * BattalionMultiplier) do
							unit = OldCreateUnit(unitName, 1, {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
							SetUnitVariable(unit, "CustomAIState", SyncRand(4)+1)
						end
					end
				end
			end
		end
			
		local shinsplitter_thane_name = ""
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-dwarven-thane") then
				shinsplitter_thane_name = GetUnitVariable(uncount[unit1], "Name")
			end
		end

		local event_player = player
		if (GetThisPlayer() == GetFactionPlayer("Shinsplitter Clan")) then
			event_player = GetFactionPlayer("Shinsplitter Clan")
		end

		Event(
			shinsplitter_thane_name,
			"We have caught up to the Norlunds. Now, prepare to destroy them!",
			event_player,
			{"~!Continue"},
			{function(s)
			if (GrandStrategy == false) then
				unit = CreateUnit("unit-surghan-mercenary-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 1)
				unit = CreateUnit("unit-surghan-mercenary-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 1)
				unit = CreateUnit("unit-surghan-mercenary-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 2)
				unit = CreateUnit("unit-surghan-mercenary-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 2)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 1)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 2)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 2)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 2)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 3)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 3)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 3)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 3)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				IncreaseUnitLevel(unit, 2, true)
				AcquireAbility(unit, "upgrade-critical-strike")
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 4)
				unit = CreateUnit("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), {Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.x, Players[GetFactionPlayer("Shinsplitter Clan")].StartPos.y + 7})
				SetUnitVariable(unit, "CustomAIState", 4)
			end
			RemovePlayerObjective(GetFactionPlayer("Shinsplitter Clan"), "- Defeat your enemies")
			AddPlayerObjective(GetFactionPlayer("Shinsplitter Clan"), "- Defeat the Norlunds")
			Event(
				"Rugnur",
				"Thursagan! The Shinsplitters are right on our tail; what should we do?",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Thursagan",
					"We could try to set off the volcano as soon as possible. Meanwhile, we should draw the Shinsplitters further into the caves, so they can't escape when it does erupt.",
					player,
					{"~!Continue"},
					{function(s)
					end},
					"dwarf/icons/thursagan.png"
				)
				end},
				"dwarf/icons/rugnur.png"
			)
			end},
			"dwarf/icons/thane.png"
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move onto one of the glyphs in the center of the volcano") == false) then
			local uncount = 0
			uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
			for unit1 = 1,table.getn(uncount) do 
				local unit_quantity = GetNumUnitsAt(-1, "unit-goblin-spearman", {GetUnitVariable(uncount[unit1],"PosX") - 4, GetUnitVariable(uncount[unit1],"PosY") - 4}, {GetUnitVariable(uncount[unit1],"PosX") + 4, GetUnitVariable(uncount[unit1],"PosY") + 4})
				if (unit_quantity > 0) then
					player = GetFactionPlayer("Norlund Clan")
					return true
				end
			end
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"These goblins appear to be guarding something.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Thursagan",
				"It is probably the ancient mechanism. Attack them!",
				player,
				{"~!Continue"},
				{function(s)
					AddPlayerObjective(player, "- Move onto one of the glyphs in the center of the volcano")
				end},
				"dwarf/icons/thursagan.png"
			)
			end},
			"dwarf/icons/rugnur.png"
		)
		return false
	end
)

-- make the Shinsplitter units chase Rugnur's dwarves
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		return true
	end,
	function() 
		local thursagan = nil
	
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1],"Ident") == "unit-hero-thursagan") then
				thursagan = uncount[unit1]
			end
		end

		if (thursagan == nil) then
			return true
		end

		-- make the Shinsplitter units attack (send a first wave of Surghan units, and then a subsequent wave of Shinsplitter units)
		uncount = 0
		uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (IsUnitIdle(uncount[unit1])) then
				if (GetUnitVariable(uncount[unit1],"CustomAIState") == 1 or (GetUnitVariable(uncount[unit1],"CustomAIState") == 2 and GameCycle >= 2500) or (GetUnitVariable(uncount[unit1],"CustomAIState") == 3 and GameCycle >= 3500) or (GetUnitVariable(uncount[unit1],"CustomAIState") == 4 and GameCycle >= 4500)) then
					OrderUnit(GetFactionPlayer("Shinsplitter Clan"), GetUnitVariable(uncount[unit1],"Ident"), {GetUnitVariable(uncount[unit1],"PosX"), GetUnitVariable(uncount[unit1],"PosY")}, {GetUnitVariable(thursagan,"PosX"), GetUnitVariable(thursagan,"PosY")}, "attack")
				end
			end
		end

		return true
	end
)

-- make the Rugnur's dwarves step onto the glyph
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionPlayer("Norlund Clan") == GetThisPlayer() or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Distract the Shinsplitters until the volcano erupts and kills them")) then
			return false
		end
		return true
	end,
	function() 
		local glyph = nil
	
		local uncount = 0
		uncount = GetUnits(15)
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1],"Ident") == "unit-glyph") then
				glyph = uncount[unit1]
			end
		end

		if (glyph == nil) then
			return true
		end

		uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (IsUnitIdle(uncount[unit1])) then
				OrderUnit(GetFactionPlayer("Norlund Clan"), GetUnitVariable(uncount[unit1],"Ident"), {GetUnitVariable(uncount[unit1],"PosX"), GetUnitVariable(uncount[unit1],"PosY")}, {GetUnitVariable(glyph,"PosX"), GetUnitVariable(glyph,"PosY")}, "move")
			end
		end

		return true
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move onto one of the glyphs in the center of the volcano") and GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "any", {36, 46}, {37, 47}) > 0 and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Distract the Shinsplitters until the volcano erupts and kills them") == false) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		PlaySound("rumble")
		PlaySound("rumble")
		Event(
			"Thursagan",
			"That's it! The volcano will erupt soon now that ye've triggered it.",
			player,
			{"~!Continue"},
			{function(s)
			PlaySound("rumble")
			PlaySound("rumble")
			Event(
				"Baglur",
				"Well, we've succeeded in stopping the Shinsplitters from getting the Scepter, I would say. But what do we do now?!",
				player,
				{"~!Continue"},
				{function(s)
				PlaySound("rumble")
				PlaySound("rumble")
				Event(
					"Thursagan",
					"Now, we must fight the goblins until we die, it's our only option.",
					player,
					{"~!Continue"},
					{function(s)
					PlaySound("rumble")
					PlaySound("rumble")
					Event(
						"Rugnur",
						"We cannot let any of the Shinsplitters or their mercenaries escape; they would tell where the Scepter of Fire is. Make sure they all die!",
						player,
						{"~!Continue"},
						{function(s)
						PlaySound("rumble")
						PlaySound("rumble")
						Event(
							"Thursagan",
							"We have to kill them quickly, before they realize what is happening.",
							player,
							{"~!Continue"},
							{function(s)
							PlaySound("rumble")
							PlaySound("rumble")
							local uncount = 0
							uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
							for unit1 = 1,table.getn(uncount) do 
								if (GetUnitVariable(uncount[unit1], "Ident") == "unit-hero-thursagan") then
									SetUnitVariable(uncount[unit1], "LastCycle", GameCycle)
								end
							end
							AddPlayerObjective(player, "- Distract the Shinsplitters until the volcano erupts and kills them")
							end},
							"dwarf/icons/thursagan.png"
						)
						end},
						"dwarf/icons/rugnur.png"
					)
					end},
					"dwarf/icons/thursagan.png"
				)
				end},
				"dwarf/icons/baglur.png"
			)
			end},
			"dwarf/icons/thursagan.png"
		)
		return false
	end
)

--[[
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-hero-thursagan" and (GameCycle - GetUnitVariable(uncount[unit1], "LastCycle")) > 3500 and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Distract the Shinsplitters until the volcano erupts and kills them")) then
				player = GetFactionPlayer("Norlund Clan")
				return true
			end
		end
		return false
	end,
	function()
		PlaySound("rumble")
		PlaySound("rumble")

		local shinsplitter_thane_name = ""
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-dwarven-thane") then
				shinsplitter_thane_name = GetUnitVariable(uncount[unit1], "Name")
			end
		end

		Event(
			shinsplitter_thane_name,
			"Wait, what's going on? The volcano is going to erupt! Everyone, try to get out of these caves!",
			player,
			{"~!Continue"},
			{function(s)
			end},
			"dwarf/icons/thane.png"
		)
		return false
	end
)
--]]

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-hero-thursagan" and (GameCycle - GetUnitVariable(uncount[unit1], "LastCycle")) > 3000 and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Distract the Shinsplitters until the volcano erupts and kills them")) then
				player = GetFactionPlayer("Norlund Clan")
				return true
			end
		end
		return false
	end,
	function()
		PlaySound("rumble")
		PlaySound("rumble")

		local shinsplitter_thane_name = ""
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-dwarven-thane") then
				shinsplitter_thane_name = GetUnitVariable(uncount[unit1], "Name")
			end
		end

		local event_player = player
		if (GetThisPlayer() == GetFactionPlayer("Shinsplitter Clan")) then
			event_player = GetFactionPlayer("Shinsplitter Clan")
		end
		
		Event(
			shinsplitter_thane_name,
			"Aghh!! The volcano is erupting, and now our exit has been blocked off!!",
			event_player,
			{"~!Continue"},
			{function(s)
				KillUnitAt("unit-dwarven-axefighter", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-dwarven-axefighter"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-steelclad", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-dwarven-steelclad"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-thane", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-dwarven-thane"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-scout", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-dwarven-scout"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-ballista", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-dwarven-ballista"), {0, 0}, {256, 256})
				KillUnitAt("unit-surghan-mercenary-steelclad", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-surghan-mercenary-steelclad"), {0, 0}, {256, 256})
				KillUnitAt("unit-surghan-mercenary-thane", GetFactionPlayer("Shinsplitter Clan"), GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "UnitTypesCount", "unit-surghan-mercenary-thane"), {0, 0}, {256, 256})
			end},
			"dwarf/icons/thane.png"
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "TotalNumUnits") < 1 and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Distract the Shinsplitters until the volcano erupts and kills them")) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"We have hidden the Scepter well, but now the volcano is going to erupt and kill us all.",
			player,
			{"~!Continue"},
			{function(s)
			KillUnitAt("unit-dwarven-axefighter", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-axefighter"), {0, 0}, {256, 256})
			KillUnitAt("unit-dwarven-steelclad", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-steelclad"), {0, 0}, {256, 256})
			KillUnitAt("unit-dwarven-thane", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-thane"), {0, 0}, {256, 256})
			KillUnitAt("unit-dwarven-scout", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-scout"), {0, 0}, {256, 256})
			KillUnitAt("unit-dwarven-ballista", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-ballista"), {0, 0}, {256, 256})
			KillUnitAt("unit-surghan-mercenary-steelclad", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-surghan-mercenary-steelclad"), {0, 0}, {256, 256})
			KillUnitAt("unit-surghan-mercenary-thane", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-surghan-mercenary-thane"), {0, 0}, {256, 256})
			KillUnitAt("unit-hero-rugnur", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-rugnur"), {0, 0}, {256, 256})
			KillUnitAt("unit-hero-rugnur-steelclad", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-rugnur-steelclad"), {0, 0}, {256, 256})
			KillUnitAt("unit-hero-rugnur-thane", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-rugnur-thane"), {0, 0}, {256, 256})
			KillUnitAt("unit-hero-baglur", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-baglur"), {0, 0}, {256, 256})
			KillUnitAt("unit-hero-baglur-thane", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-baglur-thane"), {0, 0}, {256, 256})
			KillUnitAt("unit-hero-thursagan", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-thursagan"), {0, 0}, {256, 256})
			Event(
				"Gryphon Rider",
				"Hm... I'll leave now!",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"",
					"And thus Rugnur died - a glorious death, in the eyes of the dwarven sages.",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"",
						"The gnomish envoy traveled south, to Untersberg, to Pypo I. To report the events of the past fifteen years.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"",
							"And a surviving gryphon rider followed the envoy. I know not how. But the gryphon rider made his way south, to the Brown Hills, and reached them about the time that the envoy did.",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"",
								"Together, they relayed the sad news to the king, that Rugnur and his companions did fulfill their promise to craft the Scepter, but died tragically in the Caverns of Flame.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"",
									"Pypo I thought it little wise to send forces to uncover the Scepter, with goblins swarming the region, and given that the volcano might still be too unstable. Aged and nearing the end of his life himself, he did not have the energy to undertake such an enterprise either. All he could do was sending the rest of the payment to the remnants of the Norlund Clan, as the promise to craft the Scepter was indeed fulfilled.",
									player,
									{"~!Continue"},
									{function(s)
									if (GrandStrategy) then
										Factions.NorlundClan.Gold = Factions.NorlundClan.Gold + 2500
										Factions.Untersberg.Gold = Factions.Untersberg.Gold - 2500
										AcquireProvince(WorldMapProvinces.ShorbearHills, "Norlund Clan")
										Factions.NorlundClan.Diplomacy.ShinsplitterClan = "Peace"
										Factions.ShinsplitterClan.Diplomacy.NorlundClan = "Peace"
										Factions.NorlundClan.Prestige = Factions.NorlundClan.Prestige + 100 -- a lot of prestige for completing the legendary scepter
									end
									Event(
										"",
										"The Shinsplitters, depleted by war and wary of the forces the Norlunds would be able to muster with the gnomish silver, accepted a peace, ceding the Shorbear Hold back to the Norlunds. The scepter would not be found until many generations after Pypo I, in the time of Rubezahl. During that time, it sat in the caves of the Northlands, unfound but undestroyed, moved around by goblins who never understood its true meaning.",
										player,
										{"~!Continue"},
										{function(s)
										Event(
											"",
											"But before it was found, legends grew up around it, and around its makers - Thursagan, most brilliant of the dwarven runesmiths, and Rugnur, one of the greatest dwarven heroes of old.",
											player,
											{"~!Continue"},
											{function(s)
												if (mapinfo.description == "Caverns of Flame" and GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
													if (player == GetThisPlayer() and GrandStrategy == false) then
														if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "Caverns of Flame") == false) then
															table.insert(wyr.preferences.QuestsCompleted, "Caverns of Flame")
														end
														SavePreferences()
													end
													ActionVictory()
												end
											end}
										)
										end}
									)
									end}
								)
								end}
							)
							end}
						)
						end}
					)
					end}
				)
				end},
				"dwarf/icons/gryphon_rider.png"
			)
			end},
			"dwarf/icons/rugnur.png"
		)
		Event(
			"",
			"Thus exploded the volcano, obliterating our valiant kin. The Norlunds seem to have done well in the eyes of the gnomish king, for he sent silver caravans with the rest of the payment to them. With our forces depleted and the Norlunds possessing the financial capability of mustering more soldiers, we had no choice but to sue for peace - resulting in our cession of the Shorbear Hold to the Norlund Clan.",
			GetFactionPlayer("Shinsplitter Clan"),
			{"~!Continue"},
			{function(s)
				if (GetFactionPlayer("Shinsplitter Clan") == GetThisPlayer()) then
					ActionDefeat()
				end
			end}
		)
		return false
	end
)