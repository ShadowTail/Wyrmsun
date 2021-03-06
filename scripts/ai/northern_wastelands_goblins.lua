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
--      northern_wastelands_goblins.lua - AI specific to the goblins in the Northern Wastelands map.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
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

function AiNorthernWastelandsGoblins()
	local loop_funcs = {
		function()
			AiForce(0, {AiSoldier(), 1})
			if not AiCheckForce(0) then AiForce(0, {AiShooter(), 1}) end
			return AiSleep(4500)
		end,
		function() return AiAttackWithForce(0) end,
      
		function()
			AiForce(0, {AiShooter(), 1})
			if not AiCheckForce(0) then AiForce(0, {AiSoldier(), 1}) end
			return AiSleep(4500)
		end,
		function() return AiAttackWithForce(0) end,
      
		function()
			stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = 0
			return false
		end
	}
	return function()
		return AiLoop(loop_funcs, stratagus.gameData.AIState.loop_index)
	end
end
DefineAi("northern-wastelands-goblins", "*", "northern-wastelands-goblins", AiNorthernWastelandsGoblins())
