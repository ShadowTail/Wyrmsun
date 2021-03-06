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

-- The Wyrm initial dialogue
-- based on The Dragon scenario of the Sceptre of Fire campaign from Battle for Wesnoth
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Get all heroes to the end of the tunnel") == false) then
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
			"Thus the gnomish envoy escaped from his Shinsplitter pursuers. But the dwarves were not so lucky. I would say that, perhaps, their betrayal of Durstorn was coming back to haunt them. For the section of the old eastern mines that they reached in their flight had long since become the lair of Svafnir... the wyrm.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Rugnur",
				"Well, Thursagan, we've reached the eastern mines, but the Shinsplitters are hot on our trail. What do we do now?",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Thursagan",
					"Well, we have two choices. We may either stand and fight, and assuredly die, or run as quickly as possible down this path into the depths of the cave, where we may find something that will help us. Also, remember, the Shinsplitters will take some time to have their full strength here, so we may be able to get ahead of them and perhaps lay a trap.",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"Gryphon Rider",
						"Why don't we just surrender? All they want is that stone!",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"Rugnur",
							"If we give them the ruby, then what? They'll probably kill us anyway. And, that ruby is very valuable, they could use it to gain funds and become even more dangerous. We can't let it fall into the wrong hands.",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Thursagan",
								"Then we shall run.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Baglur",
									"So we're running away, eh? I dinna' like that, but it seems it's our only option.",
									player,
									{"~!Continue"},
									{function(s)
									Event(
										"Rugnur",
										"If it makes ye feel any better, we'll probably die this way, too.",
										player,
										{"~!Continue"},
										{function(s)
											if (mapinfo.description == "Svafnir's Lair") then
												RemovePlayerObjective(player, "- Defeat your enemies")
											end
											AddPlayerObjective(player, "- Get all heroes to the end of the tunnel")
											AddPlayerObjective(player, "- Rugnur, Baglur and Thursagan must survive")
										end},
										"dwarf/icons/rugnur.png"
									)
									end},
									"dwarf/icons/baglur.png"
								)
								end},
								"dwarf/icons/thursagan.png"
							)
							end},
							"dwarf/icons/rugnur.png"
						)
						end},
						"dwarf/icons/gryphon_rider.png"
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

-- make the Shinsplitter and kobold units chase Rugnur's dwarves
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
		uncount = GetUnits("any")
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1],"Ident") == "unit-hero-thursagan") then
				thursagan = uncount[unit1]
			end
		end

		if (thursagan == nil) then
			return true
		end

		-- make the initial Shinsplitter units attack (later units follow the normal AI attack pattern)
		if (GetFactionPlayer("Shinsplitter Clan") ~= GetThisPlayer()) then
			uncount = 0
			uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
			for unit1 = 1,table.getn(uncount) do 
				if (GetUnitVariable(uncount[unit1],"Level") >= 2 and GetUnitVariable(uncount[unit1],"Ident") ~= "unit-dwarven-miner" and GetUnitTypeData(GetUnitVariable(uncount[unit1], "Ident"), "Building") == false and IsUnitIdle(uncount[unit1])) then
					OrderUnit(1, GetUnitVariable(uncount[unit1],"Ident"), {GetUnitVariable(uncount[unit1],"PosX"), GetUnitVariable(uncount[unit1],"PosY")}, {GetUnitVariable(thursagan,"PosX"), GetUnitVariable(thursagan,"PosY")}, "attack")
				end
			end
			
			if (GetPlayerData(GetFactionPlayer("Svafnir"), "TotalNumUnits") > 1) then -- the wyrm and kobolds only attack after the kobolds have been generated, and they don't attack if the player is the Shinsplitter Clan
				uncount = 0
				uncount = GetUnits(GetFactionPlayer("Svafnir"))
				for unit1 = 1,table.getn(uncount) do 
					if (IsUnitIdle(uncount[unit1])) then
						OrderUnit(2, GetUnitVariable(uncount[unit1],"Ident"), {GetUnitVariable(uncount[unit1],"PosX"), GetUnitVariable(uncount[unit1],"PosY")}, {GetUnitVariable(thursagan,"PosX"), GetUnitVariable(thursagan,"PosY")}, "attack")
					end
				end
			end
		end

		return true
	end
)

-- make the Norlunds move to the smithy
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionPlayer("Norlund Clan") == GetThisPlayer() or GetPlayerData(15, "UnitTypesCount", "unit-hero-thursagan") >= 1) then
			return false
		end
		return true
	end,
	function() 
		local smithy = nil
		local thursagan = nil
	
		local uncount = 0
		uncount = GetUnits("any")
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1],"Ident") == "unit-dwarven-smithy" and GetUnitVariable(uncount[unit1],"Player") ~= GetFactionPlayer("Shinsplitter Clan")) then
				smithy = uncount[unit1]
			elseif (GetUnitVariable(uncount[unit1],"Ident") == "unit-hero-thursagan") then
				thursagan = uncount[unit1]
			end
		end

		if (smithy == nil or thursagan == nil) then
			return true
		end

		-- make the initial Shinsplitter units attack (later units follow the normal AI attack pattern)
		uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1],"Ident") ~= "unit-dwarven-scout" and GetUnitTypeData(GetUnitVariable(uncount[unit1], "Ident"), "Building") == false and IsUnitIdle(uncount[unit1])) then
				if (GetUnitVariable(uncount[unit1],"Ident") ~= "unit-hero-thursagan") then
					OrderUnit(GetFactionPlayer("Norlund Clan"), GetUnitVariable(uncount[unit1],"Ident"), {GetUnitVariable(uncount[unit1],"PosX"), GetUnitVariable(uncount[unit1],"PosY")}, {GetUnitVariable(thursagan,"PosX"), GetUnitVariable(thursagan,"PosY")}, "move")
				else
					OrderUnit(GetFactionPlayer("Norlund Clan"), GetUnitVariable(uncount[unit1],"Ident"), {GetUnitVariable(uncount[unit1],"PosX"), GetUnitVariable(uncount[unit1],"PosY")}, {GetUnitVariable(smithy,"PosX"), GetUnitVariable(smithy,"PosY")}, "move")
				end
			end
		end
		
		return true
	end
)

-- event when Svafnir is sighted
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Svafnir"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-wyrm") then
				local unit_quantity = GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "any", {GetUnitVariable(uncount[unit1],"PosX") - 4, GetUnitVariable(uncount[unit1],"PosY") - 4}, {GetUnitVariable(uncount[unit1],"PosX") + 4, GetUnitVariable(uncount[unit1],"PosY") + 4})
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
			"Look, there's a wyrm in these caves!",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Thursagan",
				"I wonder which of the great wyrms this is...",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Rugnur",
					"I'd rather face one powerful wyrm than hundreds of mighty dwarves. Continue!",
					player,
					{"~!Continue"},
					{function(s)
					end},
					"dwarf/icons/rugnur.png"
				)
				end},
				"dwarf/icons/thursagan.png"
			)
			end},
			"dwarf/icons/rugnur.png"
		)
		return false
	end
)

-- event when a Surghan Mercenary is sighted
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-surghan-mercenary-steelclad" or GetUnitVariable(uncount[unit1], "Ident") == "unit-surghan-mercenary-thane") then
				local unit_quantity = GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "any", {GetUnitVariable(uncount[unit1],"PosX") - 4, GetUnitVariable(uncount[unit1],"PosY") - 4}, {GetUnitVariable(uncount[unit1],"PosX") + 4, GetUnitVariable(uncount[unit1],"PosY") + 4})
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
			"Thursagan",
			"What's this? This isn't a normal dwarven soldier!",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Baglur",
				"It must be one of those Surghan mercenaries. I'll bet those Shinsplitters have hired more of them. That's bad news for us, for they are deadly, combat-hardened warriors.",
				player,
				{"~!Continue"},
				{function(s)
				end},
				"dwarf/icons/baglur.png"
			)
			end},
			"dwarf/icons/thursagan.png"
		)
		return false
	end
)

-- event when the Gryphon Rider sees the forge
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-dwarven-gryphon-rider") then
				local unit_quantity = GetNumUnitsAt(-1, "unit-dwarven-smithy", {GetUnitVariable(uncount[unit1],"PosX") - 6, GetUnitVariable(uncount[unit1],"PosY") - 6}, {GetUnitVariable(uncount[unit1],"PosX") + 6, GetUnitVariable(uncount[unit1],"PosY") + 6})
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
			"Gryphon Rider",
			"Look, I've found something here!",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Thursagan",
				"It looks like a forge, heated by lava. It looks ancient, and it looks hot enough to make the Scepter.",
				player,
				{"~!Continue"},
				{function(s)
					AddPlayerObjective(player, "- Move Thursagan to the forge")
					AddPlayerObjective(player, "- Defend Thursagan until the Scepter of Fire is complete")
				end},
				"dwarf/icons/thursagan.png"
			)
			end},
			"dwarf/icons/gryphon_rider.png"
		)
		-- there should be a version of the dialogue if another unit finds the forge, too
		return false
	end
)

-- event when Thursagan reaches the forge
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (IfNearUnit(GetFactionPlayer("Norlund Clan"), ">=", 1, "unit-hero-thursagan", "unit-dwarven-smithy") and IfNearUnit(GetFactionPlayer("Norlund Clan"), ">=", 1, "unit-dwarven-smithy", "unit-hero-thursagan")) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function() 
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Norlund Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-hero-thursagan") then
				Event(
					"Thursagan",
					"This forge will work perfectly. Give me a few days here, and I can reforge the Scepter of Fire to become a proper artifact.",
					player,
					{"~!Continue"},
					{function(s)
						ChangeUnitOwner(uncount[unit1], 15)
						SetUnitVariable(uncount[unit1], "LastCycle", GameCycle)
					end},
					"dwarf/icons/thursagan.png"
				)
			end
		end
		return false
	end
)

-- kobolds come to Svafnir's rescue if it is attacked
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Svafnir"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-wyrm") then
				if (GetUnitVariable(uncount[unit1], "HitPoints") < GetUnitVariable(uncount[unit1], "HitPoints", "Max")) then
					player = GetThisPlayer()
					return true
				else
					return false
				end
			end
		end
		return false
	end,
	function() 
		Event(
			"Kobold Footpad A",
			"By the fiery Wyrmsun! The breastlings are attacking the ancient beast...!",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Kobold Footpad B",
				"We cannot allow one of the few surviving great wyrms to be slain! Get at them!",
				player,
				{"~!Continue"},
				{function(s)
					local uncount = 0
					uncount = GetUnits(GetFactionPlayer("Svafnir"))
					for unit1 = 1,table.getn(uncount) do 
						if (GetUnitVariable(uncount[unit1], "Ident") == "unit-wyrm") then
							unit = CreateUnit("unit-kobold-footpad", GetFactionPlayer("Svafnir"), {GetUnitVariable(uncount[unit1], "PosX"), GetUnitVariable(uncount[unit1], "PosY")})
							unit = CreateUnit("unit-kobold-footpad", GetFactionPlayer("Svafnir"), {GetUnitVariable(uncount[unit1], "PosX"), GetUnitVariable(uncount[unit1], "PosY")})
							unit = CreateUnit("unit-kobold-footpad", GetFactionPlayer("Svafnir"), {GetUnitVariable(uncount[unit1], "PosX"), GetUnitVariable(uncount[unit1], "PosY")})
						end
					end
				end},
				"kobold/icons/kobold_footpad.png"
			)
			end},
			"kobold/icons/kobold_footpad.png"
		)
		return false
	end
)

-- Thursagan completes the Scepter of Fire
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		local uncount = 0
		uncount = GetUnits(15)
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-hero-thursagan" and (GameCycle - GetUnitVariable(uncount[unit1], "LastCycle")) > 6000) then -- Scepter is crafted after 6000 cycles
				unit = CreateUnit("unit-scepter-of-fire", 15, {GetUnitVariable(uncount[unit1], "PosX"), GetUnitVariable(uncount[unit1], "PosY") + 1})
				player = GetFactionPlayer("Norlund Clan")
				return true
			end
		end
		return false
	end,
	function() 
		local uncount = 0
		uncount = GetUnits(15)
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-hero-thursagan") then
				ChangeUnitOwner(uncount[unit1], GetFactionPlayer("Norlund Clan"))
			end
		end
		Event(
			"Thursagan",
			"I have completed my work. Now it is truly the Scepter of Fire, a mighty artifact.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Rugnur",
				"Good. Now, let's get out of this cave, before the dwarves or kobolds kill us!",
				player,
				{"~!Continue"},
				{function(s)
					if (GrandStrategy) then
						KillUnitAt("unit-dwarven-guard-tower", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-guard-tower"), {0, 0}, {256, 256})
						KillUnitAt("unit-dwarven-scout", GetFactionPlayer("Norlund Clan"), GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-dwarven-scout"), {0, 0}, {256, 256})
					end
					if (GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
						if (player == GetThisPlayer() and GrandStrategy == false) then
							if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "The Wyrm") == false) then
								table.insert(wyr.preferences.QuestsCompleted, "The Wyrm")
							end
							SavePreferences()
						end
						ActionVictory()
					elseif (GetFactionPlayer("Shinsplitter Clan") == GetThisPlayer()) then
						Event(
							"",
							"The dwarves of the Norlund clan have disappeared into some nearby tunnel!",
							GetFactionPlayer("Shinsplitter Clan"),
							{"~!Continue"},
							{function(s)
								ActionDefeat()
							end}
						)
					end
				end},
				"dwarf/icons/rugnur.png"
			)
			end},
			"dwarf/icons/thursagan.png"
		)
		return false
	end
)
