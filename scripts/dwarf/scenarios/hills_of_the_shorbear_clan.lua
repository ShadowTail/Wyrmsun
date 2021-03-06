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

-- If the Gnomish Envoy dies, any quests of the Scepter of Fire campaign currently being pursued fail
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if ((PlayerHasObjective(GetThisPlayer(), "- Bring the loaded Gnomish caravans and the envoy to your Mead Hall") or PlayerHasObjective(GetThisPlayer(), "- Find Thursagan and bring him to your Mead Hall") or PlayerHasObjective(GetThisPlayer(), "- Defeat Glonoin, the Shorbear Clan leader") or PlayerHasObjective(GetThisPlayer(), "- Have all heroes in the Shorbear caves while no enemies are in the caves") or PlayerHasObjective(GetThisPlayer(), "- Move the Gnomish Envoy to the southern border east of the river")) and GetPlayerData(GetThisPlayer(), "UnitTypesCount", "unit-gnomish-recruit") < 1) then
			player = GetThisPlayer()
			return true
		end
		return false
	end,
	function()
		RemovePlayerObjective(player, "- Bring the loaded Gnomish caravans and the envoy to your Mead Hall")
		RemovePlayerObjective(player, "- Find Thursagan and bring him to your Mead Hall")
		RemovePlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
		RemovePlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
		if (mapinfo.description == "Chaincolt Foothills" or mapinfo.description == "Northern Wastelands" or mapinfo.description == "Shorbear Hills") then
			ActionDefeat()
			if (GrandStrategy and PlayerHasObjective(GetThisPlayer(), "- Bring the loaded Gnomish caravans and the envoy to your Mead Hall")) then
				Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 2500 -- give the funds for Shinsplitter Clan if they managed to successfully stop the shipment
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

-- Hills of the Shorbear Clan initial dialogue
-- based on the Hills of the Shorbear Clan scenario of the Sceptre of Fire campaign from Battle for Wesnoth

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader") == false and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves") == false and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") == false) then
			for i=0,14 do
				if (GetPlayerData(i, "RaceName") == "dwarf" and (GetPlayerData(i, "Name") == "Norlund Clan" or GetPlayerData(i, "Name") == "Knalga") and (GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-steelclad") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-thane")) >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur-thane") >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-thursagan") >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-hero-durstorn") >= 1 and GetPlayerData(i, "UnitTypesCount", "unit-dwarven-town-hall") >= 1) then
					player = i
					return true
				end
			end
		end
		return false
	end,
	function()
		local event_player = player
		if (GetThisPlayer() == GetFactionPlayer("Shorbear Clan")) then
			event_player = GetFactionPlayer("Shorbear Clan")
		end
		
		Event(
			"",
			"All dwarves are known for a love of gold and a heart of stone. The Shorbears were no exception. They were crafters of crafters - they made tools. The best in the land. And they bartered well.",
			event_player,
			{"~!Continue"},
			{function(s)
			Event(
				"Kuhnar",
				"Here we are; the hills of the Shorbear clan. What are we here for, anyway?",
				event_player,
				{"~!Continue"},
				{function(s)
				Event(
					"Rugnur",
					"If I understand it correctly, we're here to bargain with the Shorbears, and arrange for us to use their tools to cut the ruby.",
					event_player,
					{"~!Continue"},
					{function(s)
					Event(
						"Thursagan",
						"Exactly.",
						event_player,
						{"~!Continue"},
						{function(s)
						Event(
							"Durstorn",
							"And I'll be doing the talking; I remember what happened last time ye negotiated a deal! We lost five thousand pieces of silver.",
							event_player,
							{"~!Continue"},
							{function(s)
							Event(
								"Glonoin",
								"Och, it's some o' them cave-dwarves. What business do ye have here?",
								event_player,
								{"~!Continue"},
								{function(s)
								Event(
									"Durstorn",
									"I'm Lord Durstorn, king of my tribe. I have been told ye are great jeweler-workers, and so we come to rent some of yer tools for a short time, a few years at most.",
									event_player,
									{"~!Continue"},
									{function(s)
									Event(
										"Glonoin",
										"Yer a king?! Must be a pretty small kingdom for ye to come yerself to bargain with us!",
										event_player,
										{"~!Continue"},
										{function(s)
										Event(
											"Durstorn",
											"Ye insult me! Do ye want my business, or not?",
											event_player,
											{"~!Continue"},
											{function(s)
											Event(
												"Glonoin",
												"Well, fine, I'll hear yer offer.",
												event_player,
												{"~!Continue"},
												{function(s)
												Event(
													"Durstorn",
													"We'd like to rent yer best tools for a short period of time. We'll only be cutting one jewel with it. My starting offer is two hundred silver.",
													event_player,
													{"~!Continue"},
													{function(s)
													Event(
														"Glonoin",
														"It must be worth a lot for ye to come this way and offer that much! How much are ye going to sell it for, eh?",
														event_player,
														{"~!Continue"},
														{function(s)
														Event(
															"Durstorn",
															"That's none of yer concern!",
															event_player,
															{"~!Continue"},
															{function(s)
															Event(
																"Glonoin",
																"I'll take twenty-five hundred, minimum.",
																event_player,
																{"~!Continue"},
																{function(s)
																Event(
																	"Rugnur",
																	"(Whisper) Durstorn, that would be a quarter of all our gains!",
																	event_player,
																	{"~!Continue"},
																	{function(s)
																	Event(
																		"Durstorn",
																		"I know that. Uh, Glonoin, how about five hundred?",
																		event_player,
																		{"~!Continue"},
																		{function(s)
																		Event(
																			"Glonoin",
																			"Twenty-three hundred is my lowest offer. I can tell I don't need the money as much as ye need the jewel cut!",
																			event_player,
																			{"~!Continue"},
																			{function(s)
																			Event(
																				"Durstorn",
																				"Ye must be mad! I'll offer one thousand, but no higher!",
																				event_player,
																				{"~!Continue"},
																				{function(s)
																				Event(
																					"Glonoin",
																					"Two thousand, and I'll go no lower!",
																					event_player,
																					{"~!Continue"},
																					{function(s)
																					Event(
																						"Rugnur",
																						"(Whisper) What are we going to do? We can't go much higher!",
																						event_player,
																						{"~!Continue"},
																						{function(s)
																						Event(
																							"Baglur",
																							"(Whisper) Offer him fifteen hundred, but don't go up, even if he refuses.",
																							event_player,
																							{"~!Continue"},
																							{function(s)
																							Event(
																								"Durstorn",
																								"(Whisper) Bah! Getting this cut isn't worth that much; what with Rugnur's mistake earlier, and all the other expenses, if we pay more than a thousand we'll barely even make a profit!",
																								event_player,
																								{"~!Continue"},
																								{function(s)
																								Event(
																									"Thursagan",
																									"(Whisper) So what are ye going to do?",
																									event_player,
																									{"~!Continue"},
																									{function(s)
																									Event(
																										"Durstorn",
																										"(Whisper) Fight him, and take the tools by force.",
																										event_player,
																										{"~!Continue"},
																										{function(s)
																										Event(
																											"Thursagan",
																											"(Whisper) Are ye mad?!",
																											event_player,
																											{"~!Continue"},
																											{function(s)
																											Event(
																												"Durstorn",
																												"Of course not! Now, Glonoin; one thousand was my final offer. If ye won't accept it, we will take the tools from ye by force!",
																												event_player,
																												{"~!Continue"},
																												{function(s)
																												Event(
																													"Glonoin",
																													"I'd like to see ye try!",
																													event_player,
																													{"~!Continue"},
																													{function(s)
																													Event(
																														"Thursagan",
																														"Yer making a mistake, Durstorn.",
																														event_player,
																														{"~!Continue"},
																														{function(s)
																														Event(
																															"Durstorn",
																															"Shut up, all of ye! Attack them!",
																															event_player,
																															{"~!Continue"},
																															{function(s)
																																if (GrandStrategy == false) then
																																	unit = CreateUnit("unit-gnomish-recruit", 0, {6, 5}) -- gnomish envoy
																																	IncreaseUnitLevel(unit, 1, true)
																																	AcquireAbility(unit, "upgrade-sword-mastery")
																																end
																																if (mapinfo.description == "Shorbear Hills") then
																																	RemovePlayerObjective(player, "- Defeat your enemies")
																																end
																																AddPlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
																																AddPlayerObjective(player, "- Rugnur, Baglur, Thursagan, Durstorn and the Gnomish Envoy must survive")
																																RemovePlayerObjective(GetFactionPlayer("Shorbear Clan"), "- Defeat your enemies")
																																AddPlayerObjective(GetFactionPlayer("Shorbear Clan"), "- Defeat the Norlunds")
																																--[[
																																if (GrandStrategy) then
																																	Factions.NorlundClan.Diplomacy.ShorbearClan = "War"
																																	Factions.ShorbearClan.Diplomacy.NorlundClan = "War"
																																end
																																--]]
																															end},
																															"dwarf/icons/durstorn.png"
																														)
																														end},
																														"dwarf/icons/thursagan.png"
																													)
																													end},
																													"dwarf/icons/thane_gray_hair.png"
																												)
																												end},
																												"dwarf/icons/durstorn.png"
																											)
																											end},
																											"dwarf/icons/thursagan.png",
																											nil,
																											event_player ~= GetFactionPlayer("Norlund Clan")
																										)
																										end},
																										"dwarf/icons/durstorn.png",
																										nil,
																										event_player ~= GetFactionPlayer("Norlund Clan")
																									)
																									end},
																									"dwarf/icons/thursagan.png",
																									nil,
																									event_player ~= GetFactionPlayer("Norlund Clan")
																								)
																								end},
																								"dwarf/icons/durstorn.png",
																								nil,
																								event_player ~= GetFactionPlayer("Norlund Clan")
																							)
																							end},
																							"dwarf/icons/baglur.png",
																							nil,
																							event_player ~= GetFactionPlayer("Norlund Clan")
																						)
																						end},
																						"dwarf/icons/rugnur.png",
																						nil,
																						event_player ~= GetFactionPlayer("Norlund Clan")
																					)
																					end},
																					"dwarf/icons/thane_gray_hair.png"
																				)
																				end},
																				"dwarf/icons/durstorn.png"
																			)
																			end},
																			"dwarf/icons/thane_gray_hair.png"
																		)
																		end},
																		"dwarf/icons/durstorn.png"
																	)
																	end},
																	"dwarf/icons/rugnur.png",
																	nil,
																	event_player ~= GetFactionPlayer("Norlund Clan")
																)
																end},
																"dwarf/icons/thane_gray_hair.png"
															)
															end},
															"dwarf/icons/durstorn.png"
														)
														end},
														"dwarf/icons/thane_gray_hair.png"
													)
													end},
													"dwarf/icons/durstorn.png"
												)
												end},
												"dwarf/icons/thane_gray_hair.png"
											)
											end},
											"dwarf/icons/durstorn.png"
										)
										end},
										"dwarf/icons/thane_gray_hair.png"
									)
									end},
									"dwarf/icons/durstorn.png"
								)
								end},
								"dwarf/icons/thane_gray_hair.png"
							)
							end},
							"dwarf/icons/durstorn.png",
							nil,
							event_player ~= GetFactionPlayer("Norlund Clan")
						)
						end},
						"dwarf/icons/thursagan.png",
						nil,
						event_player ~= GetFactionPlayer("Norlund Clan")
					)
					end},
					"dwarf/icons/rugnur.png",
					nil,
					event_player ~= GetFactionPlayer("Norlund Clan")
				)
				end},
				"dwarf/icons/dwarven_steelclad.png",
				nil,
				event_player ~= GetFactionPlayer("Norlund Clan")
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
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader") and (GameCycle > 1500 or (GrandStrategy and GameCycle > 500)) and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves") == false) then
			for i=0,14 do
				if (
					GetPlayerData(i, "RaceName") == "dwarf" and (GetPlayerData(i, "Name") == "Norlund Clan" or GetPlayerData(i, "Name") == "Knalga")
					and (GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-steelclad") + GetPlayerData(i, "UnitTypesCount", "unit-hero-rugnur-thane")) >= 1
					and GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur") + GetPlayerData(i, "UnitTypesCount", "unit-hero-baglur-thane") >= 1
					and GetPlayerData(i, "UnitTypesCount", "unit-hero-thursagan") >= 1
					and GetPlayerData(i, "UnitTypesCount", "unit-hero-durstorn") >= 1
					and (GetPlayerData(i, "UnitTypesCount", "unit-dwarven-town-hall") >= 1 or GetPlayerData(i, "UnitTypesCount", "unit-dwarven-stronghold") >= 1)
				) then
					player = i
					return true
				end
			end
		end
		return false
	end,
	function()
		if (GetFactionPlayer("Shinsplitter Clan") ~= GetThisPlayer()) then
			OrderUnit(GetFactionPlayer("Shinsplitter Clan"), "unit-dwarven-thane", {2, 70}, {8, 64}, "move")
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
		elseif (GetThisPlayer() == GetFactionPlayer("Shorbear Clan")) then
			event_player = GetFactionPlayer("Shorbear Clan")
		end

		Event(
			shinsplitter_thane_name,
			"Aha! I've spent years looking for ye Norlunds, but now I've found ye! Prepare to die!",
			event_player,
			{"~!Continue"},
			{function(s)
			Event(
				"Glonoin",
				"Who the devil are ye?",
				event_player,
				{"~!Continue"},
				{function(s)
				Event(
					"Rugnur",
					"I thought we left the Shinsplitters behind at the gates four years ago! It seems we have two enemies now.",
					event_player,
					{"~!Continue"},
					{function(s)
					Event(
						"Glonoin",
						"So, Shinsplitters, are ye against these dwarves too? They're attacking my clan for absolutely no reason!",
						event_player,
						{"~!Continue"},
						{function(s)
						Event(
							shinsplitter_thane_name,
							"I see. So ye don't have the ruby?",
							event_player,
							{"~!Continue"},
							{function(s)
							Event(
								"Glonoin",
								"No, they do. They wanted to rent my tools to cut it, but they didn't offer me nearly enough!",
								event_player,
								{"~!Continue"},
								{function(s)
								Event(
									shinsplitter_thane_name,
									"How about this - I help ye defeat them, and ye let me keep the ruby when we have?",
									event_player,
									{"~!Continue"},
									{function(s)
									Event(
										"Glonoin",
										"Deal!",
										event_player,
										{"~!Continue"},
										{function(s)
										Event(
											"Durstorn",
											"Ah, they don't scare me! We can take both of them!",
											event_player,
											{"~!Continue"},
											{function(s)
											Event(
												"Thursagan",
												"Don't be a fool! We can't take the Shinsplitters, and it was a mistake to attack the Shorbears, but if we have to fight we should retreat once we get what we came for, the tools!",
												event_player,
												{"~!Continue"},
												{function(s)
													AddPlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
													RemovePlayerObjective(GetFactionPlayer("Shinsplitter Clan"), "- Defeat your enemies")
													AddPlayerObjective(GetFactionPlayer("Shinsplitter Clan"), "- Defeat the Norlunds")
												end},
												"dwarf/icons/thursagan.png"
											)
											end},
											"dwarf/icons/durstorn.png"
										)
										end},
										"dwarf/icons/thane_gray_hair.png"
									)
									end},
									"dwarf/icons/thane.png"
								)
								end},
								"dwarf/icons/thane_gray_hair.png"
							)
							end},
							"dwarf/icons/thane.png"
						)
						end},
						"dwarf/icons/thane_gray_hair.png"
					)
					end},
					"dwarf/icons/rugnur.png"
				)
				end},
				"dwarf/icons/thane_gray_hair.png"
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
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader") and GetPlayerData(1, "UnitTypesCount", "unit-dwarven-thane") < 1) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		RemovePlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
		Event(
			"Durstorn",
			"Ha! Now we can get those tools easily, and go back to our own caves.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Thursagan",
				"And how do ye plan on doing that? There are Shinsplitters swarming these hills, trying to kill us.",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Durstorn",
					"Ye are right... well, we will be able to break out eventually, and while we're here, we'll be able to finally make the scepter.",
					player,
					{"~!Continue"},
					{function(s)
					if (GetNumUnitsAt(1, "units", {26, 23}, {51, 44}) + GetNumUnitsAt(2, "units", {26, 23}, {51, 44}) >= 1) then
						if ((GetNumUnitsAt(player, "unit-hero-rugnur", {26, 23}, {51, 44}) + GetNumUnitsAt(player, "unit-hero-rugnur-steelclad", {26, 23}, {51, 44}) + GetNumUnitsAt(player, "unit-hero-rugnur-thane", {26, 23}, {51, 44})) >= 1 and (GetNumUnitsAt(player, "unit-hero-baglur", {26, 23}, {51, 44}) + GetNumUnitsAt(player, "unit-hero-baglur-thane", {26, 23}, {51, 44})) >= 1 and GetNumUnitsAt(player, "unit-hero-thursagan", {26, 23}, {51, 44}) >= 1 and GetNumUnitsAt(player, "unit-hero-durstorn", {26, 23}, {51, 44}) >= 1 and GetNumUnitsAt(player, "unit-gnomish-recruit", {26, 23}, {51, 44}) >= 1) then
							Event(
								"Thursagan",
								"Well, back to the battle - we are all in the caves, but there are still enemies in here also!",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Durstorn",
									"Indeed. Kill them! And make sure no more enter. Then we can close the gates.",
									player,
									{"~!Continue"},
									{function(s)
									end},
									"dwarf/icons/durstorn.png"
								)
								end},
								"dwarf/icons/thursagan.png"
							)
						else
							Event(
								"Thursagan",
								"Well, back to the battle - we need everyone to get into the Shorbear caves. And then stop any enemies from coming in here.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Durstorn",
									"Indeed. Everyone to the caves, and kill those still inside!",
									player,
									{"~!Continue"},
									{function(s)
									end},
									"dwarf/icons/durstorn.png"
								)
								end},
								"dwarf/icons/thursagan.png"
							)
						end
					elseif (((GetNumUnitsAt(player, "unit-hero-rugnur", {26, 23}, {51, 44}) + GetNumUnitsAt(player, "unit-hero-rugnur-steelclad", {26, 23}, {51, 44}) + GetNumUnitsAt(player, "unit-hero-rugnur-thane", {26, 23}, {51, 44})) >= 1 and (GetNumUnitsAt(player, "unit-hero-baglur", {26, 23}, {51, 44}) + GetNumUnitsAt(player, "unit-hero-baglur-thane", {26, 23}, {51, 44})) >= 1 and GetNumUnitsAt(player, "unit-hero-thursagan", {26, 23}, {51, 44}) >= 1 and GetNumUnitsAt(player, "unit-hero-durstorn", {26, 23}, {51, 44}) >= 1 and GetNumUnitsAt(player, "unit-gnomish-recruit", {26, 23}, {51, 44}) >= 1) == false) then
						Event(
							"Thursagan",
							"Well, back to the battle - we need everyone to get into the Shorbear caves. And then stop any enemies from coming in here.",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Durstorn",
								"Indeed. Everyone to the caves, and kill those still inside!",
								player,
								{"~!Continue"},
								{function(s)
								end},
								"dwarf/icons/durstorn.png"
							)
							end},
							"dwarf/icons/thursagan.png"
						)
					end
					end},
					"dwarf/icons/durstorn.png"
				)
				end},
				"dwarf/icons/thursagan.png"
			)
			end},
			"dwarf/icons/durstorn.png"
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves")) then
			if (GetNumUnitsAt(1, "any", {26, 23}, {51, 44}) + GetNumUnitsAt(2, "any", {26, 23}, {51, 44}) < 1) then
				if ((GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur", {26, 23}, {51, 44}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur-steelclad", {26, 23}, {51, 44}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur-thane", {26, 23}, {51, 44})) >= 1 and (GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-baglur", {26, 23}, {51, 44}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-baglur-thane", {26, 23}, {51, 44})) >= 1 and GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-thursagan", {26, 23}, {51, 44}) >= 1 and GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-durstorn", {26, 23}, {51, 44}) >= 1 and GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-gnomish-recruit", {26, 23}, {51, 44}) >= 1) then
					player = GetFactionPlayer("Norlund Clan")
					return true
				end
			end
		end
		return false
	end,
	function()
		Event(
			"Durstorn",
			"We have driven all of the Shorbears and Shinsplitters out of these caves! Now, seal the gates!",
			player,
			{"~!Continue"},
			{function(s)
				RemovePlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
				RemovePlayerObjective(player, "- Rugnur, Baglur, Thursagan, Durstorn and the Gnomish Envoy must survive")
				KillUnitAt("unit-dwarven-town-hall", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-town-hall"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-stronghold", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-stronghold"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-mushroom-farm", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-mushroom-farm"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-barracks", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-barracks"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-smithy", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-smithy"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-lumber-mill", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-lumber-mill"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-sentry-tower", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-sentry-tower"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-guard-tower", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-guard-tower"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-miner", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-miner"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-axefighter", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-axefighter"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-steelclad", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-steelclad"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-thane", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-thane"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-scout", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-scout"), {0, 0}, {256, 256})
				KillUnitAt("unit-dwarven-ballista", player, GetPlayerData(player, "UnitTypesCount", "unit-dwarven-ballista"), {0, 0}, {256, 256})
				local uncount = 0
				uncount = GetUnits(0)
				for unit1 = 1,table.getn(uncount) do 
					if (GetUnitBoolFlag(uncount[unit1], "Hero") or GetUnitVariable(uncount[unit1], "Ident") == "unit-gnomish-recruit") then
						if (GetUnitVariable(uncount[unit1],"PosX") >= 26 and GetUnitVariable(uncount[unit1],"PosX") <= 51 and GetUnitVariable(uncount[unit1],"PosY") >= 23 and GetUnitVariable(uncount[unit1],"PosY") <= 44) then
--							MoveUnit(uncount[unit1], {41, 41}) -- move all units to this spot to open up place for buildings -- the "MoveUnit" is not working properly for some reason: buildings will still be blocked from being created at the unit's original location, and when Durstorn dies, after his corpse disappears the game crashes
							SetUnitVariable(uncount[unit1], "HitPoints", GetUnitVariable(uncount[unit1], "HitPoints", "Max")) -- heal the heroes
						end
					end
				end
				-- create settlement for the Norlund Clan in the Shorbear Hold, after its conquest
				unit = CreateUnit("unit-dwarven-stronghold", 0, {37, 32})
				if (GrandStrategy == false) then
					unit = CreateUnit("unit-dwarven-miner", 0, {38, 33})
					unit = CreateUnit("unit-dwarven-miner", 0, {38, 33})
					unit = CreateUnit("unit-dwarven-miner", 0, {38, 33})
					unit = CreateUnit("unit-dwarven-miner", 0, {38, 33})
					unit = CreateUnit("unit-dwarven-miner", 0, {38, 33})
				end

				unit = CreateUnit("unit-dwarven-guard-tower", 0, {29, 29})
				unit = CreateUnit("unit-dwarven-guard-tower", 0, {29, 37})
				unit = CreateUnit("unit-dwarven-guard-tower", 0, {38, 25})
				unit = CreateUnit("unit-dwarven-guard-tower", 0, {47, 29})
				unit = CreateUnit("unit-dwarven-guard-tower", 0, {47, 35})

				unit = CreateUnit("unit-dwarven-barracks", 0, {31, 33})
				unit = CreateUnit("unit-dwarven-smithy", 0, {43, 28})
				unit = CreateUnit("unit-dwarven-mushroom-farm", 0, {32, 30})
				unit = CreateUnit("unit-dwarven-mushroom-farm", 0, {40, 28})
				unit = CreateUnit("unit-dwarven-mushroom-farm", 0, {44, 36})

				if (GrandStrategy == false) then
					unit = CreateUnit("unit-dwarven-thane", 2, {5, 65}) -- Gaenlar

					-- create second encampment for Shinsplitters
					unit = CreateUnit("unit-dwarven-town-hall", 2, {40, 10})
					unit = CreateUnit("unit-dwarven-miner", 2, {40, 10})
					unit = CreateUnit("unit-dwarven-miner", 2, {40, 10})
					unit = CreateUnit("unit-dwarven-miner", 2, {40, 10})
					unit = CreateUnit("unit-dwarven-miner", 2, {40, 10})
					unit = CreateUnit("unit-dwarven-miner", 2, {40, 10})
					unit = CreateUnit("unit-dwarven-thane", 2, {40, 10}) -- Glinan

					-- create third encampment for Shinsplitters
					unit = CreateUnit("unit-dwarven-town-hall", 2, {60, 60})
					unit = CreateUnit("unit-dwarven-miner", 2, {60, 60})
					unit = CreateUnit("unit-dwarven-miner", 2, {60, 60})
					unit = CreateUnit("unit-dwarven-miner", 2, {60, 60})
					unit = CreateUnit("unit-dwarven-miner", 2, {60, 60})
					unit = CreateUnit("unit-dwarven-miner", 2, {60, 60})
					unit = CreateUnit("unit-dwarven-thane", 2, {60, 60}) -- Kalnar
				elseif (GrandStrategyEventMap) then
					-- Shinsplitters
					local units_to_be_created = {}
					for i, unitName in ipairs(Units) do
						if (IsMilitaryUnit(unitName)) then
							units_to_be_created[string.gsub(unitName, "-", "_")] = 0
							units_to_be_created[string.gsub(unitName, "-", "_")] = math.floor(WorldMapProvinces.SouthernTunnels.Units[string.gsub(unitName, "-", "_")] / 4)
							WorldMapProvinces.SouthernTunnels.Units[string.gsub(unitName, "-", "_")] = WorldMapProvinces.SouthernTunnels.Units[string.gsub(unitName, "-", "_")] - units_to_be_created[string.gsub(unitName, "-", "_")]
						end
					end
					if (units_to_be_created.unit_dwarven_thane < 1 and WorldMapProvinces.SouthernTunnels.Units.unit_dwarven_thane >= 1) then
						units_to_be_created.unit_dwarven_thane = 1
						WorldMapProvinces.SouthernTunnels.Units.unit_dwarven_thane = WorldMapProvinces.SouthernTunnels.Units.unit_dwarven_thane - 1
					end
					for i, unitName in ipairs(Units) do
						if (IsMilitaryUnit(unitName)) then
							if (units_to_be_created[string.gsub(unitName, "-", "_")] > 0) then
								for i=1,(units_to_be_created[string.gsub(unitName, "-", "_")] * BattalionMultiplier) do
									unit = CreateUnit(unitName, 2, {40, 10})
								end
							end
						end
					end
					
					-- if in grand strategy mode, give the province to the Shinsplitters
					AcquireProvince(WorldMapProvinces.ShorbearHills, "Shinsplitter Clan")
				end
				
				
				Event(
					"",
					"Durstorn's rash action led to many problems. Not the least of which was being surrounded by the Shinsplitters.",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"",
						"The Norlunds spent several years trapped in those caves, the Shinsplitters besieging them. The Norlunds could not leave, for there were far too many Shinsplitters, and there was no way out of the caverns other than above ground. But the Shinsplitters could not enter, for the impregnable dwarven gates were closed.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"",
							"During this time, Thursagan crafted the Scepter of Fire, first cutting the jewel, then putting it, the gold and the cold steel into the heat of the flame. The scepter was crafted, but something was not right. No matter what he did to the Scepter, the ruby couldn't be properly bound to the metal.",
							player,
							{"~!Continue"},
							{function(s)
								AddPlayerObjective(player, "- Move Rugnur to the northeast cave entrance")
								AddPlayerObjective(player, "- Move the Gnomish Envoy to the southern border east of the river")
								AddPlayerObjective(player, "- Rugnur, Baglur, Thursagan and the gnomish envoy must survive")
							end}
						)
						end}
					)
					end}
				)
			end},
			"dwarf/icons/durstorn.png"
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") and GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-durstorn") >= 1) then
			for i=0,14 do
				if (GetPlayerData(i, "RaceName") == "dwarf" and (GetPlayerData(i, "Name") == "Norlund Clan" or GetPlayerData(i, "Name") == "Knalga")) then
					player = i
					return true
				end
			end
		end
		return false
	end,
	function()
		local shinsplitter_thane_name = ""
		local uncount = 0
		uncount = GetUnits(GetFactionPlayer("Shinsplitter Clan"))
		for unit1 = 1,table.getn(uncount) do 
			if (GetUnitVariable(uncount[unit1], "Ident") == "unit-dwarven-thane") then
				shinsplitter_thane_name = GetUnitVariable(uncount[unit1], "Name")
			end
		end
		
		Event(
			"Rugnur",
			"Well, Thursagan has reached a conclusion. He can't make the scepter with the materials he has here, but he has the final plans for it, and all the jewels and gold he needs. Shouldn't we leave now?",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"Durstorn",
				"All this time and he couldn't make it? Fine, we should try to leave... but it's not like we could leave if we wanted to. We're surrounded!",
				player,
				{"~!Continue"},
				{function(s)
				Event(
					"Baglur",
					"If ye'll permit me to say so, sir, yer wrong. We could-",
					player,
					{"~!Continue"},
					{function(s)
					Event(
						"Durstorn",
						"Shut up, Baglur! Ye don't know what yer talking about. I've analyzed the situation, and we're doomed. Our best hope is to surrender. Perhaps if we give the Shinsplitters the plans for the Scepter of Fire they will let us survive.",
						player,
						{"~!Continue"},
						{function(s)
						Event(
							"Rugnur",
							"Yes, of course, let's just all be cowards! What happened to your honor, Durstorn?!",
							player,
							{"~!Continue"},
							{function(s)
							Event(
								"Durstorn",
								"Ye little fool, honor is less important than life! So, I'm ordering Thursagan to give the plans and the ruby to the Shinsplitters, as a peace offering. Then maybe we'll walk out of here alive.",
								player,
								{"~!Continue"},
								{function(s)
								Event(
									"Thursagan",
									"Ye don't have authority over me, Durstorn. And I wouldn't give the Scepter to them even if ye did. It's not yers to give, it's mine, and Rugnur's, and Baglur's. The gryphon riders have done more for its existence than ye have! And yet, ye still get the profits from selling it to Pypo.",
									player,
									{"~!Continue"},
									{function(s)
									Event(
										"Durstorn",
										"So what, all of ye want to die? Fine by me, but I won't die with ye! And if ye won't give the Scepter to the Shinsplitters, I'll take it from ye!",
										player,
										{"~!Continue"},
										{function(s)
										PlaySound("attack-miss")
										Event(
											"Thursagan",
											"Nice try, Durstorn, but ye missed. Now, I'd say that attacking an ally constitutes treason, wouldn't ye?",
											player,
											{"~!Continue"},
											{function(s)
											Event(
												"Durstorn",
												"Yer not my ally. Yer more against me than the Shinsplitters are; all they want is the ruby, but ye want us dead!",
												player,
												{"~!Continue"},
												{function(s)
												Event(
													"Rugnur",
													"If that's what yer thinking, yer not fit to be ruler over us! So step down, or we'll force ye.",
													player,
													{"~!Continue"},
													{function(s)
													Event(
														"Durstorn",
														"Never!",
														player,
														{"~!Continue"},
														{function(s)
															PlaySound("axe-attack")
															KillUnitAt("unit-hero-durstorn", player, 1, {0, 0}, {256, 256})
															Event(
																"Rugnur",
																"Well, I suppose we were right to silence him, but I don't like this. In any case, now we should try to get out of here.",
																player,
																{"~!Continue"},
																{function(s)
																Event(
																	"Thursagan",
																	"Aye. So, see the area to the northeast of us?",
																	player,
																	{"~!Continue"},
																	{function(s)
																	Event(
																		"Thursagan",
																		"That's where there are the least Shinsplitter guards, so we have the greatest chance of success there. I think we should try to get to it.",
																		player,
																		{"~!Continue"},
																		{function(s)
																		Event(
																			"Gnomish Envoy",
																			"This plan, it isn't worse than staying here to be killed, but it isn't likely to succeed either. Even if it does, what will it accomplish? We will be cornered there.",
																			player,
																			{"~!Continue"},
																			{function(s)
																			Event(
																				"Thursagan",
																				"I don't know if we will be cornered. That cave looks like it goes deep, and we can lose the Shinsplitters in the caves. Once we get out, we'll make our way back to Knalga.",
																				player,
																				{"~!Continue"},
																				{function(s)
																				Event(
																					"Rugnur",
																					"The country between here and Knalga will be swarming with Shinsplitter warriors. We had better head back to the abandoned mines north of the Arkan-thoria, where we gathered our gold and coal. At least there the gnomes will have some hope of finding us.",
																					player,
																					{"~!Continue"},
																					{function(s)
																					Event(
																						"Gnomish Envoy",
																						"That's fine for you, you are used to the deep underground, but I ain't! What am I supposed to do?",
																						player,
																						{"~!Continue"},
																						{function(s)
																						Event(
																							"Rugnur",
																							"Well, ye are a member of the army of Untersberg. Why don't ye rejoin it? See if ye can run past those Shinsplitters to our southeast...",
																							player,
																							{"~!Continue"},
																							{function(s)
																							Event(
																								"Rugnur",
																								"... and then ride south until ye reach one of yer outposts.",
																								player,
																								{"~!Continue"},
																								{function(s)
																								Event(
																									"Gnomish Envoy",
																									"I'm not going to do that, it's suicide! And in any case, I've been with you for ten years, almost as long as I was in the Untersberg army; I'd prefer to fight with you.",
																									player,
																									{"~!Continue"},
																									{function(s)
																									Event(
																										"Thursagan",
																										"Ye going south has more of a chance of success for ye than staying here or going back to the mines! And getting news to Pypo of what has happened is also the best way to get help to us.",
																										player,
																										{"~!Continue"},
																										{function(s)
																										Event(
																											"Gnomish Envoy",
																											"I suppose...",
																											player,
																											{"~!Continue"},
																											{function(s)
																											Event(
																												shinsplitter_thane_name,
																												"Come out, Norlunds, and surrender! Or die in that cave, yer choice.",
																												player,
																												{"~!Continue"},
																												{function(s)
																												end},
																												"dwarf/icons/thane.png"
																											)
																											end},
																											"gnome/icons/gnomish_recruit.png"
																										)
																										end},
																										"dwarf/icons/thursagan.png"
																									)
																									end},
																									"gnome/icons/gnomish_recruit.png"
																								)
																								end},
																								"dwarf/icons/rugnur.png"
																							)
																							end},
																							"dwarf/icons/rugnur.png"
																						)
																						end},
																						"gnome/icons/gnomish_recruit.png"
																					)
																					end},
																					"dwarf/icons/rugnur.png"
																				)
																				end},
																				"dwarf/icons/thursagan.png"
																			)
																			end},
																			"gnome/icons/gnomish_recruit.png"
																		)
																		end},
																		"dwarf/icons/thursagan.png"
																	)
																	end},
																	"dwarf/icons/thursagan.png"
																)
																end},
																"dwarf/icons/rugnur.png"
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
			"dwarf/icons/rugnur.png"
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") and GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-gnomish-recruit", {44, 76}, {256, 256}) >= 1) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"My gnomish friend, ride as fast as ye can south. Tell Pypo we are heading northeast, towards the old eastern mines, and if he wants his precious scepter he should send forces to meet us there as soon as he can!",
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
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") and (GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur", {69, 14}, {69, 14}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur-steelclad", {69, 14}, {69, 14}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur-thane", {69, 14}, {69, 14})) >= 1) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		Event(
			"Rugnur",
			"I don't know what is in these caves, but whatever it is can't be worse than staying here to die.",
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
		if (GameCycle == 0) then
			return false
		end
		if (PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Move Rugnur to the northeast cave entrance") and (GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur", {69, 14}, {69, 14}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur-steelclad", {69, 14}, {69, 14}) + GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-hero-rugnur-thane", {69, 14}, {69, 14})) >= 1 and GetNumUnitsAt(GetFactionPlayer("Norlund Clan"), "unit-gnomish-recruit", {44, 76}, {256, 256}) >= 1) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		if (mapinfo.description == "Shorbear Hills" and GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
			if (player == GetThisPlayer() and GrandStrategy == false) then
				if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "Hills of the Shorbear Clan") == false) then
					table.insert(wyr.preferences.QuestsCompleted, "Hills of the Shorbear Clan")
				end
				SavePreferences()
			end
			ActionVictory()
		end
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionPlayer("Shinsplitter Clan") == GetThisPlayer() and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves")) then
			if (GetPlayerData(GetFactionPlayer("Shinsplitter Clan"), "TotalNumUnits") < 1) then
				player = GetFactionPlayer("Shinsplitter Clan")
				return true
			end
		end
		return false
	end,
	function()
		KillUnitAt("any", GetFactionPlayer("Shorbear Clan"), GetPlayerData(GetFactionPlayer("Shorbear Clan"), "TotalNumUnits"), {0, 0}, {256, 256})
		Event(
			"",
			"The Norlunds have defeated our forces at the hills, garrisoning themselves inside the Shorbear Hold after destroying the Shorbears. Our reinforcements established control over the hills and kept the siege on the Norlunds, but eventually they escaped to some nearby caves...",
			player,
			{"~!Continue"},
			{function(s)
				if (GrandStrategyEventMap) then
					-- if in grand strategy mode, give the province to the Shinsplitters
					AcquireProvince(WorldMapProvinces.ShorbearHills, "Shinsplitter Clan")
				end
				ActionDraw()
			end}
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionPlayer("Shorbear Clan") == GetThisPlayer() and PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves")) then
			if (GetPlayerData(GetFactionPlayer("Shorbear Clan"), "TotalNumUnits") < 1) then
				player = GetFactionPlayer("Shorbear Clan")
				return true
			end
		end
		return false
	end,
	function()
		Event(
			"",
			"The Norlunds have obliterated our defenses, taking Shorbear Hold for themselves.",
			player,
			{"~!Continue"},
			{function(s)
				if (GrandStrategyEventMap) then
					-- if in grand strategy mode, give the province to the Shinsplitters
					AcquireProvince(WorldMapProvinces.ShorbearHills, "Shinsplitter Clan")
				end
				ActionDefeat()
			end}
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionPlayer("Shinsplitter Clan") == GetThisPlayer() and PlayerHasObjective(GetFactionPlayer("Shinsplitter Clan"), "- Defeat the Norlunds")) then
			if (GetNumUnitsAt(0, "any", {0, 0}, {256, 256}) < 1) then
				player = GetFactionPlayer("Shinsplitter Clan")
				return true
			end
		end
		return false
	end,
	function()
		Event(
			"",
			"On this day we have slain the most valiant of the Norlund warriors. With the Norlund leaders dead, not only did we manage to exact the silver from the clan to make peace, but we now have the valuable ruby with us, which we can trade for a hefty sum.",
			player,
			{"~!Continue"},
			{function(s)
				if (GrandStrategyEventMap) then
					Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 10000 -- gold gained from the ruby's sale
					Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 2500 -- gained the silver via peace treaty with the Norlunds
					Factions.NorlundClan.Gold = Factions.NorlundClan.Gold - 2500
					Factions.NorlundClan.Diplomacy.ShinsplitterClan = "Peace"
					Factions.ShinsplitterClan.Diplomacy.NorlundClan = "Peace"
				end
				ActionVictory()
			end}
		)
		return false
	end
)

AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionPlayer("Shorbear Clan") == GetThisPlayer() and PlayerHasObjective(GetFactionPlayer("Shorbear Clan"), "- Defeat the Norlunds")) then
			if (GetNumUnitsAt(0, "any", {0, 0}, {256, 256}) < 1) then
				player = GetFactionPlayer("Shorbear Clan")
				return true
			end
		end
		return false
	end,
	function()
		Event(
			"",
			"With the help of the Shinsplitter Clan, we have managed to free ourselves from the Norlund threat! With their leaders dead, there shall now be a durable peace.",
			player,
			{"~!Continue"},
			{function(s)
				if (GrandStrategyEventMap) then
					Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 10000 -- gold gained from the ruby's sale
					Factions.ShinsplitterClan.Gold = Factions.ShinsplitterClan.Gold + 2500 -- gained the silver via peace treaty with the Norlunds
					Factions.NorlundClan.Gold = Factions.NorlundClan.Gold - 2500
					Factions.NorlundClan.Diplomacy.ShinsplitterClan = "Peace"
					Factions.ShinsplitterClan.Diplomacy.NorlundClan = "Peace"
				end
				ActionVictory()
			end}
		)
		return false
	end
)

-- If Durstorn dies, any quests of the Scepter of Fire campaign currently being pursued fail
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (
			(
				PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Defeat Glonoin, the Shorbear Clan leader")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Have all heroes in the Shorbear caves while no enemies are in the caves")
				or PlayerHasObjective(GetFactionPlayer("Norlund Clan"), "- Durstorn and Baglur must survive")
			)
			and GetPlayerData(GetFactionPlayer("Norlund Clan"), "UnitTypesCount", "unit-hero-durstorn") < 1
		) then
			player = GetFactionPlayer("Norlund Clan")
			return true
		end
		return false
	end,
	function()
		RemovePlayerObjective(player, "- Defeat Glonoin, the Shorbear Clan leader")
		RemovePlayerObjective(player, "- Have all heroes in the Shorbear caves while no enemies are in the caves")
		if (GetFactionPlayer("Norlund Clan") == GetThisPlayer()) then
			ActionDefeat()
		end
		return false
	end
)
