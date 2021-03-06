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

-- Gathering Materials initial dialogue
-- based on the Gathering Materials scenario of the Sceptre of Fire campaign from Battle for Wesnoth

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "Searching for the Runecrafter") and PlayerHasObjective(GetThisPlayer(), "- Mine 10000 gold and 20000 coal") == false and GetNumUnitsAt(-1, "unit-gold-deposit", {0, 0}, {256, 256}) >= 1 and GetNumUnitsAt(-1, "unit-coal-mine", {0, 0}, {256, 256}) >= 2) then
			for i=0,14 do
				if (GetPlayerData(i, "RaceName") == "dwarf" and (GetPlayerData(i, "Name") == "Norlund Clan" or GetPlayerData(i, "Name") == "Shinsplitter Clan" or GetPlayerData(i, "Name") == "Knalga") and GetPlayerData(i, "Name") ~= "Shinsplitter Clan" and (GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-steelclad") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-thane")) >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur-thane") >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-thursagan") >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-dwarven-town-hall") >= 1) then
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
			"Those who went to the eastern mines were brave indeed. They were infested with goblins and other vile creatures, who thrived in the dark and gloom of the caves.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"",
				"And braver still were Rugnur and his companions, who had to spend two years in those tunnels. For mining is a lengthy business. But they could for the most part avoid the enemy. They only once had to venture into the very heart of the goblins' territory.",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Rugnur",
					"Well, these are the eastern mines. Goblins live here, be prepared to fight them; also be prepared to spend quite some time here - mining can take a while.",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"Thursagan",
						"For me to make the artifact Pypo wants, I need a special type of gold. I do not know where it was found, but Baglur said these mines were the source of it.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"Baglur",
							"Also, the only coal that wi' melt this gold is here.",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Rugnur",
								"So we're down here to, what, mine this gold and coal? That should be easy enough.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Thursagan",
									"Aye. But beware, there are goblins and such down here...",
									player,
									{"~!Continue"},
									{function(s)
										if (mapinfo.description == "Eastern Mines") then
											RemovePlayerObjective(player, "- Defeat your enemies")
										end
										AddPlayerObjective(player, "- Mine 10000 gold and 20000 coal")
										AddPlayerObjective(player, "- Rugnur, Baglur and Thursagan must survive")
									end},
									"dwarf/icons/thursagan.png"
								)
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
				nil,
				nil,
				GrandStrategy
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
		if (GameCycle > 3000) then
			for i=0,14 do
				if (PlayerHasObjective(i, "- Mine 10000 gold and 20000 coal")) then
					player = i
					return true
				end
			end
		end
		return false
	end,
	function()
		if (GetPlayerData(player, "UnitTypesCount", "unit-dwarven-miner") < 1) then
			Event(
				"Thursagan",
				"Don't forget to recruit the miners. Our warriors can clear the tunnels of goblins and worse, but once we find the gold and coal we need the miners to acquire it.",
				player,
				{"~!Continue"},
				{function(s)
				end},
				"dwarf/icons/thursagan.png"
			)
		end
		return false
	end
)

-- coal found
AddTrigger(
	function()
		local uncount = 0
		uncount = GetUnits(15)
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-coal-mine") then
				local unit_quantity = GetNumUnitsAt(GetThisPlayer(), "units", {GetUnitVariable(uncount[unit1],"PosX") - 6, GetUnitVariable(uncount[unit1],"PosY") - 6}, {GetUnitVariable(uncount[unit1],"PosX") + 6, GetUnitVariable(uncount[unit1],"PosY") + 6})
				if (unit_quantity > 0) then
					player = GetThisPlayer()
					return true
				end
			end
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"Here is some of the coal that we need! Bring the miners to take it!",
			player,
			{"~!Continue"},
			{function(s)
			end},
			"dwarf/icons/rugnur.png"
		)
		return false
	end
)

-- gold found
AddTrigger(
	function()
		local uncount = 0
		uncount = GetUnits(15)
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-gold-deposit") then
				local unit_quantity = GetNumUnitsAt(GetThisPlayer(), "units", {GetUnitVariable(uncount[unit1],"PosX") - 6, GetUnitVariable(uncount[unit1],"PosY") - 6}, {GetUnitVariable(uncount[unit1],"PosX") + 6, GetUnitVariable(uncount[unit1],"PosY") + 6})
				if (unit_quantity > 0) then
					player = GetThisPlayer()
					return true
				end
			end
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"Here is a mine of the precious gold! Send the miners this way.",
			player,
			{"~!Continue"},
			{function(s)
			end},
			"dwarf/icons/rugnur.png"
		)
		return false
	end
)

AddTrigger(
	function()
		for i=0,14 do
			if (PlayerHasObjective(i, "- Mine 10000 gold and 20000 coal") and GetPlayerData(i, "Resources", "coal") >= 20000) then
				player = i
				return true
			end
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"That's the last load of coal we need.",
			player,
			{"~!Continue"},
			{function(s)
				if (GetPlayerData(i, "Resources", "gold") >= 10000) then
					Event(
						"Thursagan",
						"This is all we need from these mines. Now we should go back further west, where there are no goblins, and mine there.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"",
							"(Later in the dwarven citadel...)",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Durstorn",
								"So, ye have returned. I assume ye have obtained the required materials? My jeweler Theganli has spent the last two years buying jewels from some of the northern clans. So now go to the forge and make yer scepter. What do ye need to annoy me for?",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Thursagan",
									"We don't. Not everything is about ye. We need to talk to Theganli.",
									player,
									{"~!Continue"},
									{function(s)
									Event(
										"Durstorn",
										"That makes sense, I guess ye would want to plan the scepter's design... what in particular do ye want him to do?",
										player,
										{"~!Continue"},
										{function(s)
										Event(
											"Thursagan",
											"I need to make the plans for the scepter, then have him cut the ruby to match them.",
											player,
											{"~!Continue"},
											{function(s)
											Event(
												"Durstorn",
												"Yer going to cut the jewel?! Are ye insane?",
												player,
												{"~!Continue"},
												{function(s)
												Event(
													"Rugnur",
													"What are ye talking about, sir? Ye knew all along the jewel would have to be cut to make the scepter out of.",
													player,
													{"~!Continue"},
													{function(s)
													Event(
														"Durstorn",
														"Oh... right, right. Fine. Theganli?",
														player,
														{"~!Continue"},
														{function(s)
														Event(
															"Kuhnar",
															"He's in his shop, in the southern tunnel.",
															player,
															{"~!Continue"},
															{function(s)
															Event(
																"Durstorn",
																"Whatever. Kuhnar, go, summon him here.",
																player,
																{"~!Continue"},
																{function(s)
																Event(
																	"Kuhnar",
																	"Theganli! Come out of there, Durstorn orders ye to come to the citadel.",
																	player,
																	{"~!Continue"},
																	{function(s)
																	Event(
																		"Theganli",
																		"I'm coming... coming... stop pounding on the door...",
																		player,
																		{"~!Continue"},
																		{function(s)
																		Event(
																			"Thursagan",
																			"He doesn't need to come here, I'll take the jewel to his shop. He'll need his tools anyway.",
																			player,
																			{"~!Continue"},
																			{function(s)
																			Event(
																				"Thursagan",
																				"Well, Theganli, what do ye think of this jewel?",
																				player,
																				{"~!Continue"},
																				{function(s)
																				Event(
																					"Theganli",
																					"Uh, um, aye, aye, very impressive jewel, impressive, aye...",
																					player,
																					{"~!Continue"},
																					{function(s)
																					Event(
																						"Thursagan",
																						"Do ye think ye could cut it in the manner my plans specify?",
																						player,
																						{"~!Continue"},
																						{function(s)
																						Event(
																							"Theganli",
																							"Well, uh, um, maybe... maybe... it will be hard... let me see...",
																							player,
																							{"~!Continue"},
																							{function(s)
																							Event(
																								"Thursagan",
																								"Very well. See what ye can do.",
																								player,
																								{"~!Continue"},
																								{function(s)
																								Event(
																									"",
																									"Theganli spent many months cutting the jewels that would go into the Scepter of Fire, and the Ruby of Fire he attempted last. But he could not cut it.",
																									player,
																									{"~!Continue"},
																									{function(s)
																									Event(
																										"Durstorn",
																										"Well, do you have anything yet?!",
																										player,
																										{"~!Continue"},
																										{function(s)
																										Event(
																											"Theganli",
																											"Ah, well, uh, no... no, not yet... unfortunately... it seems... it can't be cut... or scratched... or damaged at all... at least not by my tools...",
																											player,
																											{"~!Continue"},
																											{function(s)
																											Event(
																												"Thursagan",
																												"So what do ye propose we do? We need this jewel cut in a very specific way to make sure... well, it doesn't matter why.",
																												player,
																												{"~!Continue"},
																												{function(s)
																												Event(
																													"Theganli",
																													"Well... maybe... the Shorbear clan? They have good tools... aye, aye, they do...",
																													player,
																													{"~!Continue"},
																													{function(s)
																													Event(
																														"Rugnur",
																														"Who are they?",
																														player,
																														{"~!Continue"},
																														{function(s)
																														Event(
																															"Theganli",
																															"Another group... of dwarves... live south of here... above ground... aye... best jewelers I know of... have special tools... tools, aye...",
																															player,
																															{"~!Continue"},
																															{function(s)
																															Event(
																																"Durstorn",
																																"Well, Rugnur, what are ye waiting for? Go down and get these tools from them, and carve the jewel!",
																																player,
																																{"~!Continue"},
																																{function(s)
																																Event(
																																	"Baglur",
																																	"We can't just go in there and take their property. We'll have to buy, or rent, it from them.",
																																	player,
																																	{"~!Continue"},
																																	{function(s)
																																	Event(
																																		"Durstorn",
																																		"Fine. Go rent it from them.",
																																		player,
																																		{"~!Continue"},
																																		{function(s)
																																		Event(
																																			"Rugnur",
																																			"Very well. We'll go south now.",
																																			player,
																																			{"~!Continue"},
																																			{function(s)
																																			Event(
																																				"Durstorn",
																																				"Wait! Last time ye made a bargain by yerself ye lost us five thousand pieces of silver. I'm going with ye this time!",
																																				player,
																																				{"~!Continue"},
																																				{function(s)
																																				Event(
																																					"Kuhnar",
																																					"Are ye sure that is wise, lord?",
																																					player,
																																					{"~!Continue"},
																																					{function(s)
																																					Event(
																																						"Durstorn",
																																						"Of course! To be safe, though, ye and Noiraran are going to come with us.",
																																						player,
																																						{"~!Continue"},
																																						{function(s)
																																						Event(
																																							"Kuhnar",
																																							"Aye sir... (~<Sigh~>)",
																																							player,
																																							{"~!Continue"},
																																							{function(s)
																																								RemovePlayerObjective(player, "- Mine 10000 gold and 20000 coal")
																																								if (player == GetThisPlayer() and GrandStrategy == false) then
																																									if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "Gathering Materials") == false) then
																																										table.insert(wyr.preferences.QuestsCompleted, "Gathering Materials")
																																									end
																																									SavePreferences()
																																								end
																																								if (GrandStrategy) then
																																									--Factions.NorlundClan.Gold = Factions.NorlundClan.Gold + 10000
																																									Factions.NorlundClan.Commodities["Coal"] = 20000
																																								end
																																								if (mapinfo.description == "Eastern Mines" and GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
																																									ActionVictory()
																																								end
																																							end},
																																							"dwarf/icons/dwarven_steelclad.png"
																																						)
																																						end},
																																						"dwarf/icons/durstorn.png"
																																					)
																																					end},
																																					"dwarf/icons/dwarven_steelclad.png"
																																				)
																																				end},
																																				"dwarf/icons/durstorn.png"
																																			)
																																			end},
																																			"dwarf/icons/rugnur.png"
																																		)
																																		end},
																																		"dwarf/icons/durstorn.png"
																																	)
																																	end},
																																	"dwarf/icons/baglur.png"
																																)
																																end},
																																"dwarf/icons/durstorn.png"
																															)
																															end},
																															"dwarf/icons/dwarven_steelclad_gray_hair.png"
																														)
																														end},
																														"dwarf/icons/rugnur.png"
																													)
																													end},
																													"dwarf/icons/dwarven_steelclad_gray_hair.png"
																												)
																												end},
																												"dwarf/icons/thursagan.png"
																											)
																											end},
																											"dwarf/icons/dwarven_steelclad_gray_hair.png"
																										)
																										end},
																										"dwarf/icons/durstorn.png"
																									)
																									end}
																								)
																								end},
																								"dwarf/icons/thursagan.png"
																							)
																							end},
																							"dwarf/icons/dwarven_steelclad_gray_hair.png"
																						)
																						end},
																						"dwarf/icons/thursagan.png"
																					)
																					end},
																					"dwarf/icons/dwarven_steelclad_gray_hair.png"
																				)
																				end},
																				"dwarf/icons/thursagan.png"
																			)
																			end},
																			"dwarf/icons/thursagan.png"
																		)
																		end},
																		"dwarf/icons/dwarven_steelclad_gray_hair.png"
																	)
																	end},
																	"dwarf/icons/dwarven_steelclad.png"
																)
																end},
																"dwarf/icons/durstorn.png"
															)
															end},
															"dwarf/icons/dwarven_steelclad.png"
														)
														end},
														"dwarf/icons/durstorn.png"
													)
													end},
													"dwarf/icons/rugnur.png"
												)
												end},
												"dwarf/icons/durstorn.png"
											)
											end},
											"dwarf/icons/thursagan.png"
										)
										end},
										"dwarf/icons/durstorn.png"
									)
									end},
									"dwarf/icons/thursagan.png"
								)
								end},
								"dwarf/icons/durstorn.png"
							)
							end}
						)
						end},
						"dwarf/icons/thursagan.png"
					)
				end
			end},
			"dwarf/icons/rugnur.png"
		)
		return false
	end
)

AddTrigger(
	function()
		for i=0,14 do
			if (PlayerHasObjective(i, "- Mine 10000 gold and 20000 coal") and GetPlayerData(i, "Resources", "coal") >= 20000 and GetPlayerData(i, "Resources", "gold") >= 10000) then
				player = i
				return true
			end
		end
		return false
	end,
	function()
		Event(
			"Thursagan",
			"This is all we need from these mines. Now we should go back further west, where there are no goblins, and mine there.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"",
				"(Later in the dwarven citadel...)",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Durstorn",
					"So, ye have returned. I assume ye have obtained the required materials? My jeweler Theganli has spent the last two years buying jewels from some of the northern clans. So now go to the forge and make your scepter. What do ye need to annoy me for?",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"Thursagan",
						"We don't. Not everything is about ye. We need to talk to Theganli.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"Durstorn",
							"That makes sense, I guess ye would want to plan the scepter's design... what in particular do ye want him to do?",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Thursagan",
								"I need to make the plans for the scepter, then have him cut the ruby to match them.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Durstorn",
									"Yer going to cut the jewel?! Are ye insane?",
									player,
									{"~!Continue"},
									{function(s)
									Event(
										"Rugnur",
										"What are ye talking about, sir? Ye knew all along the jewel would have to be cut to make the scepter out of.",
										player,
										{"~!Continue"},
										{function(s)
										Event(
											"Durstorn",
											"Oh... right, right. Fine. Theganli?",
											player,
											{"~!Continue"},
											{function(s)
											Event(
												"Kuhnar",
												"He's in his shop, in the southern tunnel.",
												player,
												{"~!Continue"},
												{function(s)
												Event(
													"Durstorn",
													"Whatever. Kuhnar, go, summon him here.",
													player,
													{"~!Continue"},
													{function(s)
													Event(
														"Kuhnar",
														"Theganli! Come out of there, Durstorn orders ye to come to the citadel.",
														player,
														{"~!Continue"},
														{function(s)
														Event(
															"Theganli",
															"I'm coming... coming... stop pounding on the door...",
															player,
															{"~!Continue"},
															{function(s)
															Event(
																"Thursagan",
																"He doesn't need to come here, I'll take the jewel to his shop. He'll need his tools anyway.",
																player,
																{"~!Continue"},
																{function(s)
																Event(
																	"Thursagan",
																	"Well, Theganli, what do ye think of this jewel?",
																	player,
																	{"~!Continue"},
																	{function(s)
																	Event(
																		"Theganli",
																		"Uh, um, aye, aye, very impressive jewel, impressive, aye...",
																		player,
																		{"~!Continue"},
																		{function(s)
																		Event(
																			"Thursagan",
																			"Do ye think ye could cut it in the manner my plans specify?",
																			player,
																			{"~!Continue"},
																			{function(s)
																			Event(
																				"Theganli",
																				"Well, uh, um, maybe... maybe... it will be hard... let me see...",
																				player,
																				{"~!Continue"},
																				{function(s)
																				Event(
																					"Thursagan",
																					"Very well. See what ye can do.",
																					player,
																					{"~!Continue"},
																					{function(s)
																					Event(
																						"",
																						"(Theganli spent many months cutting the jewels that would go into the Scepter of Fire, and the Ruby of Fire he attempted last. But he could not cut it.)",
																						player,
																						{"~!Continue"},
																						{function(s)
																						Event(
																							"Durstorn",
																							"Well, do you have anything yet?!",
																							player,
																							{"~!Continue"},
																							{function(s)
																							Event(
																								"Theganli",
																								"Ah, well, uh, no... no, not yet... unfortunately... it seems... it can't be cut... or scratched... or damaged at all... at least not by my tools...",
																								player,
																								{"~!Continue"},
																								{function(s)
																								Event(
																									"Thursagan",
																									"So what do ye propose we do? We need this jewel cut in a very specific way to make sure... well, it doesn't matter why.",
																									player,
																									{"~!Continue"},
																									{function(s)
																									Event(
																										"Theganli",
																										"Well... maybe... the Shorbear clan? They have good tools... aye, aye, they do...",
																										player,
																										{"~!Continue"},
																										{function(s)
																										Event(
																											"Rugnur",
																											"Who are they?",
																											player,
																											{"~!Continue"},
																											{function(s)
																											Event(
																												"Theganli",
																												"Another group... of dwarves... live south of here... above ground... aye... best jewelers I know of... have special tools... tools, aye...",
																												player,
																												{"~!Continue"},
																												{function(s)
																												Event(
																													"Durstorn",
																													"Well, Rugnur, what are ye waiting for? Go down and get these tools from them, and carve the jewel!",
																													player,
																													{"~!Continue"},
																													{function(s)
																													Event(
																														"Baglur",
																														"We can't just go in there and take their property. We'll have to buy, or rent, it from them.",
																														player,
																														{"~!Continue"},
																														{function(s)
																														Event(
																															"Durstorn",
																															"Fine. Go rent it from them.",
																															player,
																															{"~!Continue"},
																															{function(s)
																															Event(
																																"Rugnur",
																																"Very well. We'll go south now.",
																																player,
																																{"~!Continue"},
																																{function(s)
																																Event(
																																	"Durstorn",
																																	"Wait! Last time ye made a bargain by yerself ye lost us five thousand pieces of silver. I'm going with ye this time!",
																																	player,
																																	{"~!Continue"},
																																	{function(s)
																																	Event(
																																		"Kuhnar",
																																		"Are ye sure that is wise, lord?",
																																		player,
																																		{"~!Continue"},
																																		{function(s)
																																		Event(
																																			"Durstorn",
																																			"Of course! To be safe, though, ye and Noiraran are going to come with us.",
																																			player,
																																			{"~!Continue"},
																																			{function(s)
																																			Event(
																																				"Kuhnar",
																																				"Aye sir... (~<Sigh~>)",
																																				player,
																																				{"~!Continue"},
																																				{function(s)
																																					RemovePlayerObjective(player, "- Mine 10000 gold and 20000 coal")
																																					if (player == GetThisPlayer() and GrandStrategy == false) then
																																						if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "Gathering Materials") == false) then
																																							table.insert(wyr.preferences.QuestsCompleted, "Gathering Materials")
																																						end
																																						SavePreferences()
																																					end
																																					if (GrandStrategy) then
																																						--Factions.NorlundClan.Gold = Factions.NorlundClan.Gold + 10000
																																						Factions.NorlundClan.Commodities["Coal"] = 20000
																																					end
																																					if (mapinfo.description == "Eastern Mines" and GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
																																						ActionVictory()
																																					end
																																				end},
																																				"dwarf/icons/dwarven_steelclad.png"
																																			)
																																			end},
																																			"dwarf/icons/durstorn.png"
																																		)
																																		end},
																																		"dwarf/icons/dwarven_steelclad.png"
																																	)
																																	end},
																																	"dwarf/icons/durstorn.png"
																																)
																																end},
																																"dwarf/icons/rugnur.png"
																															)
																															end},
																															"dwarf/icons/durstorn.png"
																														)
																														end},
																														"dwarf/icons/baglur.png"
																													)
																													end},
																													"dwarf/icons/durstorn.png"
																												)
																												end},
																												"dwarf/icons/dwarven_steelclad_gray_hair.png"
																											)
																											end},
																											"dwarf/icons/rugnur.png"
																										)
																										end},
																										"dwarf/icons/dwarven_steelclad_gray_hair.png"
																									)
																									end},
																									"dwarf/icons/thursagan.png"
																								)
																								end},
																								"dwarf/icons/dwarven_steelclad_gray_hair.png"
																							)
																							end},
																							"dwarf/icons/durstorn.png"
																						)
																						end}
																					)
																					end},
																					"dwarf/icons/thursagan.png"
																				)
																				end},
																				"dwarf/icons/dwarven_steelclad_gray_hair.png"
																			)
																			end},
																			"dwarf/icons/thursagan.png"
																		)
																		end},
																		"dwarf/icons/dwarven_steelclad_gray_hair.png"
																	)
																	end},
																	"dwarf/icons/thursagan.png"
																)
																end},
																"dwarf/icons/thursagan.png"
															)
															end},
															"dwarf/icons/dwarven_steelclad_gray_hair.png"
														)
														end},
														"dwarf/icons/dwarven_steelclad.png"
													)
													end},
													"dwarf/icons/durstorn.png"
												)
												end},
												"dwarf/icons/dwarven_steelclad.png"
											)
											end},
											"dwarf/icons/durstorn.png"
										)
										end},
										"dwarf/icons/rugnur.png"
									)
									end},
									"dwarf/icons/durstorn.png"
								)
								end},
								"dwarf/icons/thursagan.png"
							)
							end},
							"dwarf/icons/durstorn.png"
						)
						end},
						"dwarf/icons/thursagan.png"
					)
					end},
					"dwarf/icons/durstorn.png"
				)
				end}
			)
			end},
			"dwarf/icons/thursagan.png"
		)
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
