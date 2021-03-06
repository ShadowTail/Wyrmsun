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
--      events.lua - Defines events for the Germanic civilization.
--
--      (c) Copyright 2015 by Andrettin
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

if (LoadedGame == false) then
	if (GrandStrategy == false) then
		local rome_player = GetFactionPlayer("Rome")
		SetPlayerData(rome_player, "Allow", "upgrade-teuton-masonry", "R")
	elseif (GrandStrategyEventMap) then
		SetAiType(0, "grand-strategy-battle")
		SetAiType(1, "grand-strategy-battle")
		
		local units_to_be_created = {}
		
		-- Suebi units
		for i, unitName in ipairs(Units) do
			if (IsMilitaryUnit(unitName)) then
				units_to_be_created[string.gsub(unitName, "-", "_")] = 0
				units_to_be_created[string.gsub(unitName, "-", "_")] = WorldMapProvinces.Brandenburg.Units[string.gsub(unitName, "-", "_")]
				WorldMapProvinces.Brandenburg.Units[string.gsub(unitName, "-", "_")] = WorldMapProvinces.Brandenburg.Units[string.gsub(unitName, "-", "_")] - units_to_be_created[string.gsub(unitName, "-", "_")]
			end
		end
		for i, unitName in ipairs(Units) do
			if (IsMilitaryUnit(unitName)) then
				if (units_to_be_created[string.gsub(unitName, "-", "_")] > 0) then
					for i=1,(units_to_be_created[string.gsub(unitName, "-", "_")] * BattalionMultiplier) do
						unit = CreateUnit(unitName, 0, {Players[0].StartPos.x, Players[0].StartPos.y})
					end
				end
			end
		end
		
		-- Roman units
		for i, unitName in ipairs(Units) do
			if (IsMilitaryUnit(unitName)) then
				units_to_be_created[string.gsub(unitName, "-", "_")] = 0
				units_to_be_created[string.gsub(unitName, "-", "_")] = math.floor(WorldMapProvinces.Galicia.Units[string.gsub(unitName, "-", "_")] / 4)
				WorldMapProvinces.Galicia.Units[string.gsub(unitName, "-", "_")] = WorldMapProvinces.Galicia.Units[string.gsub(unitName, "-", "_")] - units_to_be_created[string.gsub(unitName, "-", "_")]
			end
		end
		for i, unitName in ipairs(Units) do
			if (IsMilitaryUnit(unitName)) then
				if (units_to_be_created[string.gsub(unitName, "-", "_")] > 0) then
					for i=1,(units_to_be_created[string.gsub(unitName, "-", "_")] * BattalionMultiplier) do
						unit = CreateUnit(unitName, 1, {Players[1].StartPos.x, Players[1].StartPos.y})
					end
				end
			end
		end
	end
end

-- Moving into Galicia introduction
AddTrigger(
	function()
		if (GameCycle == 0) then
			return false
		end
		if (GetFactionExists("Suebi Tribe") and PlayerHasObjective(GetFactionPlayer("Suebi Tribe"), "- Take Bracara Augusta") == false) then
			player = GetFactionPlayer("Suebi Tribe")
			return true
		end
		return false
	end,
	function()
		Event(
			"",
			"Times are changing. The Roman Empire, once invincible, is now falling prey to a conjunction of domestic troubles and external pressures. Our group of Suebi has decided to take on this opportunity, journeying deep into Roman territory, and seeking a land to take for ourselves.",
			player,
			{"~!Continue"},
			{function(s)
			Event(
				"",
				"We have crossed the Rhine into Gaul, but that was not to be our final destination: we moved to the south, to Iberia, to the Roman province of Galicia. The walls of Bracara Augusta, the province's capital, is now all that stands between us and the establishment of a new dominion in Roman lands!",
				player,
				{"~!Continue"},
				{function(s)
					RemovePlayerObjective(player, "- Defeat your enemies")
					AddPlayerObjective(player, "- Take Bracara Augusta")
				end}
			)
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
		if (GetFactionExists("Suebi Tribe") and PlayerHasObjective(GetFactionPlayer("Suebi Tribe"), "- Take Bracara Augusta") and GetPlayerData(GetFactionPlayer("Rome"), "TotalNumUnits") == 0) then
			player = GetFactionPlayer("Suebi Tribe")
			return true
		end
		return false
	end,
	function()
		Event(
			"",
			"Victory is ours! Bracara Augusta has been taken, and we have laid the foundations of a new realm!",
			player,
			{"~!Continue"},
			{function(s)
				if (player == GetThisPlayer()) then
					if (GrandStrategy == false) then
						if (GetArrayIncludes(wyr.preferences.QuestsCompleted, "Moving into Galicia") == false) then
							table.insert(wyr.preferences.QuestsCompleted, "Moving into Galicia")
						end
						SavePreferences()
					end
					ActionVictory()
				end
			end}
		)
		return false
	end
)
