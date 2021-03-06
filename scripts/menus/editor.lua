--
--	editor-unit-types a sorted list of unit-types for the editor.
--	FIXME: this is only a temporary hack, for better sorted units.
--
editor_types = {

   "unit-germanic-worker",
   "unit-germanic-warrior",
   "unit-germanic-archer",
   "unit-germanic-old-man",
   "unit-germanic-town-hall",
   "unit-germanic-farm",
   "unit-germanic-barracks",
   "unit-germanic-carpenters-shop",
   "unit-germanic-smithy",

--- - - - - - - - - - - - - - - - - - -

   "unit-teuton-worker",
   "unit-teuton-swordsman",
   "unit-teuton-archer",
   "unit-teuton-old-man",
   "unit-teuton-catapult",
   "unit-teuton-town-hall",
   "unit-teuton-stronghold",
   "unit-teuton-farm",
   "unit-teuton-barracks",
   "unit-teuton-lumber-mill",
   "unit-teuton-smithy",
   "unit-teuton-watch-tower",
   "unit-teuton-guard-tower",

   "unit-hero-marbod",
   
--- - - - - - - - - - - - - - - - - - -

   "unit-celt-farm",
   
--- - - - - - - - - - - - - - - - - - -

   "unit-dwarven-miner",
   "unit-dwarven-militia",
   "unit-dwarven-axefighter",
   "unit-dwarven-steelclad",
   "unit-dwarven-thane",
   "unit-dwarven-scout",
   "unit-dwarven-yale-rider",
   "unit-dwarven-ballista",
   "unit-dwarven-gryphon-rider",

   "unit-dwarven-town-hall",
   "unit-dwarven-stronghold",
   "unit-dwarven-mushroom-farm",
   "unit-dwarven-barracks",
   "unit-dwarven-lumber-mill",
   "unit-dwarven-smithy",
   "unit-dwarven-sentry-tower",
   "unit-dwarven-guard-tower",

   "unit-surghan-mercenary-steelclad",
   "unit-surghan-mercenary-thane",

   "unit-hero-durin",
   "unit-hero-durin-thane",
   "unit-hero-rugnur",
   "unit-hero-rugnur-steelclad",
   "unit-hero-rugnur-thane",
   "unit-hero-baglur",
   "unit-hero-baglur-thane",
   "unit-hero-thursagan",
   "unit-hero-durstorn",

--- - - - - - - - - - - - - - - - - - -

   "unit-gnomish-worker",
   "unit-gnomish-recruit",
   "unit-gnomish-herbalist",
   "unit-gnomish-caravan",

   "unit-gnomish-town-hall",
   "unit-gnomish-farm",
   "unit-gnomish-barracks",

--- - - - - - - - - - - - - - - - - - -

   "unit-goblin-worker",
   "unit-goblin-spearman",
   "unit-goblin-archer",
   "unit-goblin-thief",
   "unit-goblin-war-machine",
   "unit-goblin-glider",

   "unit-goblin-town-hall",
   "unit-goblin-farm",
   "unit-goblin-mess-hall",
   "unit-goblin-lumber-mill",
   "unit-goblin-smithy",

   "unit-hero-greebo",

--- - - - - - - - - - - - - - - - - - -

   "unit-kobold-footpad",

--- - - - - - - - - - - - - - - - - - -

   "unit-gold-rock",
   "unit-gold-deposit",
   "unit-gold-mine",
   "unit-wood-pile",
   "unit-coal-mine",
   "unit-mercenary-camp",
   "unit-tree-stump",
   "unit-hole",
   "unit-gold-coins",
   "unit-gold-sack",
   "unit-gold-chest",
   "unit-gold-and-gems-chest",
   "unit-barrel",
   "unit-door",
   "unit-chair",
   "unit-table",
   "unit-alchemy-bench",
   "unit-bed",
   "unit-potion-of-healing",
   "unit-potion-of-decay",
   "unit-potion-of-slowness",
   "unit-cheese",
   "unit-carrots",
   "unit-gryphon-feather",
   "unit-caltrops",
   "unit-trap",
   "unit-scepter-of-fire",

   "unit-worm",
   "unit-bug",
   "unit-bee",
   "unit-fly",
   "unit-snail",
   "unit-slug",
   "unit-frog",
   "unit-rat",
   "unit-bird",
   "unit-crow",
   "unit-bat",
   "unit-blood-bat",
   "unit-dread-bat",
   "unit-slime",
   "unit-yale",
   "unit-gryphon",
   "unit-wyrm",
   "unit-long-swordsman",

--- - - - - - - - - - - - - - - - - - -

   "unit-goblin-banner",
   "unit-glyph",
   "unit-runestone",
   "unit-stairs",
   "unit-mushroom",
   "unit-mushroom-patch",
   "unit-flowers",
   "unit-large-flower",
   "unit-fern",
   "unit-twigs",
   "unit-log",
   "unit-small-rocks",
   "unit-stalagmites",
   "unit-bones",
   "unit-wyrm-skeleton",
   "unit-volcanic-crater",
   "unit-roaming-fog-small",
   "unit-roaming-fog",
   "unit-floor-decoration",
   "unit-shelf",
   "unit-outer-wall-decoration",
   "unit-inner-wall-decoration"
}

editor_tilesets = { "cave", "conifer_forest_summer", "conifer_forest_autumn", "dungeon", "fairlimbed_forest", "swamp"}

--  Menu for new map to edit
local function RunEditorNewMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local tilesets = editor_tilesets
  local mapSizes = {"32", "64", "96", "128", "256"}

  menu:addLabel("Map Description:", offx + 208, offy + 104 + 32 * 0, Fonts["game"], false)
  local mapDescription = menu:addTextInputField("", offx + 208, offy + 104 + 32 * 1, 200)
  menu:addLabel("Terrain:", offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  local dropDownTileset = menu:addDropDown(editor_tilesets, offx + 208 + 60, offy + 104 + 32 * 2, function() end)

  menu:addLabel("Size:", offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)
  local mapSizex = menu:addDropDown(mapSizes, offx + 208 + 50, offy + 104 + 32 * 3, function() end)
  mapSizex:setWidth(50)
  menu:addLabel("x", offx + 208 + 110, offy + 104 + 32 * 3, Fonts["game"], false)
  local mapSizey = menu:addDropDown(mapSizes, offx + 208 + 125, offy + 104 + 32 * 3, function() end)
  mapSizey:setWidth(50)

  menu:addFullButton(_("~!New Map"), "n", offx + 208, offy + 104 + 36 * 5,
    function()
      -- TODO : check value
      Map.Info.Description = mapDescription:getText()
      Map.Info.MapWidth = mapSizes[1 + mapSizex:getSelected()]
      Map.Info.MapHeight = mapSizes[1 + mapSizey:getSelected()]
	  if (CanAccessFile("scripts/tilesets/" .. string.gsub(editor_tilesets[1 + dropDownTileset:getSelected()], "-", "_") .. ".lua")) then
			LoadTileModels("scripts/tilesets/" .. string.gsub(editor_tilesets[1 + dropDownTileset:getSelected()], "-", "_") .. ".lua")
	  else -- check if any mod has this tileset
			local mods = {}
		  
			local i
			local f
			local u = 1

			-- list the subdirectories in the mods folder
			local dirlist = {}
			local dirs = ListDirsInDirectory(ModDirectory)
			for i,f in ipairs(dirs) do
				dirlist[u] = f .. "/"
				u = u + 1
			end

			u = 1
			-- get mods in the subdirectories of the mods folder
			for j=1,table.getn(dirlist) do
				local fileslist = ListFilesInDirectory(ModDirectory .. dirlist[j])
				for i,f in ipairs(fileslist) do
					if (string.find(f, "info.lua")) then
						mods[u] = ModDirectory .. dirlist[j] .. f
						u = u + 1
					end
				end
			end

			u = 1
			-- get mod main files in the subdirectories of the mods folder
			for j=1,table.getn(dirlist) do
				local fileslist = ListFilesInDirectory(ModDirectory .. dirlist[j])
				for i,f in ipairs(fileslist) do
					if (string.find(f, "main.lua")) then
						mods[u] = ModDirectory .. dirlist[j] .. f
						u = u + 1
					end
				end
			end

			for i=1,table.getn(mods) do
				ModName = ""
				Load(tostring(string.gsub(mods[i], "main", "info")))
				if (CanAccessFile(string.gsub(mods[i], "main.lua", "scripts/tilesets/") .. string.gsub(editor_tilesets[1 + dropDownTileset:getSelected()], "-", "_") .. ".lua")) then
					LoadTileModels(string.gsub(mods[i], "main.lua", "scripts/tilesets/") .. string.gsub(editor_tilesets[1 + dropDownTileset:getSelected()], "-", "_") .. ".lua")
				end
			end		
	  end
      menu:stop()
      StartEditor(nil)
      RunEditorMenu()
    end)
  menu:addFullButton(_("~!Cancel"), "c", offx + 208, offy + 104 + 36 * 6, function() menu:stop(1); RunEditorMenu() end)
  return menu:run()
end

-- Menu for loading map to edit
local function RunEditorLoadMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local labelMapName
  local labelDescription
  local labelNbPlayer
  local labelMapSize
  
  -- update label content
  local function MapChanged()
    labelMapName:setCaption("File      : " .. string.sub(mapname, 6))
    labelMapName:adjustSize()

    labelNbPlayer:setCaption("Players  : " .. mapinfo.nplayers)
    labelNbPlayer:adjustSize()

    labelDescription:setCaption("Scenario : " .. _(mapinfo.description))
    labelDescription:adjustSize()

    labelMapSize:setCaption("Size      : " .. mapinfo.w .. " x " .. mapinfo.h)
    labelMapSize:adjustSize()
  end

  labelMapName = menu:addLabel("", offx + 208, offy + 104 + 36 * 0, Fonts["game"], false)
  labelDescription = menu:addLabel("", offx + 208, offy + 104 + 32 * 1, Fonts["game"], false)
  labelNbPlayer = menu:addLabel("", offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  labelMapSize = menu:addLabel("", offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)

  menu:addFullButton(_("~!Select Map"), "s", offx + 208, offy + 104 + 36 * 4,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)

  menu:addFullButton(_("~!Edit Map"), "e", offx + 208, offy + 104 + 36 * 5, function() menu:stop(); StartEditor(mapname); RunEditorMenu() end)
  menu:addFullButton(_("~!Cancel"), "c", offx + 208, offy + 104 + 36 * 6, function() menu:stop(1); RunEditorMenu() end)

  GetMapInfo(mapname)
  MapChanged()
  return menu:run()
end

-- root of the editor menu
function RunEditorMenu()
  wyrmsun.playlist = { "music/battle_theme_a.ogg" }
  SetPlayerData(GetThisPlayer(), "RaceName", "gnome")

  if not (IsMusicPlaying()) then
    PlayMusic("music/battle_theme_a.ogg")
  end

  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addLabel(_("~<Map Editor~>"), offx + 320, offy + 212 - 25)
  local buttonNewMap =
  menu:addFullButton(_("~!New Map"), "n", offx + 208, offy + 104 + 36*3, function() RunEditorNewMapMenu(); menu:stop() end)
  menu:addFullButton(_("~!Load Map"), "l", offx + 208, offy + 104 + 36*4, function() RunEditorLoadMapMenu(); menu:stop() end)
  menu:addFullButton(_("~!Cancel"), "c", offx + 208, offy + 104 + 36*5, function() menu:stop() end)
  return menu:run()
end

function RunEditorSaveMap(browser, name, menu)
  local saved = EditorSaveMap(browser.path .. name)
  if (saved == -1) then
    local confirm = WarGameMenu(panel(3))
    confirm:resize(300,120)
    confirm:addLabel("Cannot save map to file:", 300 / 2, 11)
    confirm:addLabel(browser.path .. name, 300 / 2, 31)
    confirm:addHalfButton("~!OK", "o", 1 * (300 / 3), 120 - 16 - 27, function() confirm:stop() end)
    confirm:run(false)
  else
    UI.StatusLine:Set("Saved map to: " .. browser.path .. name)
    menu:stop()
  end
end

--
--  Save map from the editor
--
function RunEditorSaveMenu()
  local menu = WarGameMenu(panel(3))

  menu:resize(384, 256)

  menu:addLabel("Save Game", 384 / 2, 11)

  local t = menu:addTextInputField("game.smp",
    (384 - 300 - 18) / 2, 11 + 36, 318)

  local browser = menu:addBrowser(MapDirectories[1], ".smp.gz$",
    (384 - 300 - 18) / 2, 11 + 36 + 22, 318, 126)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton(_("~!Cancel"), "c", 384 - ((384 - 300 - 18) / 2) - 106, 256 - 16 - 27, function() menu:stop() end)
  menu:addHalfButton("~!Save", "s", (384 - 300 - 18) / 2, 256 - 16 - 27,
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- strip .gz
      if (string.find(name, ".gz$") ~= nil) then
        name = string.sub(name, 1, string.len(name) - 3)
      end
      -- append .smp
      if (string.find(name, ".smp$") == nil) then
        name = name .. ".smp"
      end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      if (browser:exists(name .. ".gz")) then
        local confirm = WarGameMenu(panel(3))
        confirm:resize(300,120)
        confirm:addLabel(name, 300 / 2, 11)
        confirm:addLabel("File exists, are you sure ?", 300 / 2, 31)
        confirm:addHalfButton("~!Yes", "y", 1 * (300 / 3) - 90, 120 - 16 - 27,
          function()
            confirm:stop()
            RunEditorSaveMap(browser, name, menu)
          end)
        confirm:addHalfButton("~!No", "n", 3 * (300 / 3) - 116, 120 - 16 - 27, function() confirm:stop() end)
        confirm:run(false)
      else
        RunEditorSaveMap(browser, name, menu)
      end
    end)

  menu:run(false)
end

--
--  Load a other map to edit.
--
function RunEditorLoadMenu()
-- TODO : fill this function correctly
--[[
--  RunSelectScenarioMenu()
--  if (buttonStatut == 1) then
--    EditorLoadMap(mapname)
--    StartEditor(mapname)
--  end
--]]
end

--
--  Change player properties from the editor
--
function RunEditorPlayerProperties()
-- TODO : manage edition.
-- TODO : find a correct backgroung menu
  local menu = WarGameMenu()
  local sizeX = 500
  local sizeY = 480

  menu:resize(sizeX, sizeY)
  menu:addLabel("Player Properties", sizeX / 2, 11)

  local offxPlayer = 15
  local offxType = 70
  local offxRace = 170
  local offxAI = 285
  local offxGold = 375
  local offxLumber = 425
  local offxOil = 470

  local types = {"neutral", "nobody", "computer", "person", "rescue-passive", "rescue-active"}
  local racenames = {"celt", "dwarf", "germanic", "gnome", "goblin", "goth", "greek", "kobold", "latin", "norse", "teuton"}
  local ais = { "passive", "land-attack", "northern-wastelands-goblins" }

  menu:addLabel("#", 15, 36)
  menu:addLabel("Type", offxType, 36)
  menu:addLabel("Civilization", offxRace, 36)
  menu:addLabel("AI", offxAI, 36)
  menu:addLabel("Gold", offxGold, 36)
  menu:addLabel("Lumber", offxLumber, 36)
  menu:addLabel("Stone", offxOil, 36)
--  menu:addLabel("Oil", offxOil, 36)

  local playersProp = {nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil}
  for i = 0, 14 do
    local playerLine = {
      type = nil,
      race = nil,
      ai = nil,
      gold = nil,
      lumber = nil,
      oil = nil,
      stone = nil
    }
    local offy_i = 36 + 25 * (i + 1)
    local index = i -- use for local function

    local function updateProp(ind)
      local b = (playersProp[1 + ind].type:getSelected() ~= 1) -- != nobody
      playersProp[1 + ind].race:setVisible(b)
      playersProp[1 + ind].ai:setVisible(b)
      playersProp[1 + ind].gold:setVisible(b)
      playersProp[1 + ind].lumber:setVisible(b)
      playersProp[1 + ind].stone:setVisible(b)
--      playersProp[1 + ind].oil:setVisible(b)
    end

    playersProp[1 + i] = playerLine

    menu:addLabel("p" .. (i + 1), offxPlayer, offy_i)

    playersProp[1 + i].type = menu:addDropDown(types, offxType - 40, offy_i, function() updateProp(index) end)
    playersProp[1 + i].type:setSelected(Map.Info.PlayerType[i] - 2)
    playersProp[1 + i].type:setWidth(115)

    playersProp[1 + i].race = menu:addDropDown(racenames, offxRace - 20, offy_i, function() end)
    playersProp[1 + i].race:setSelected(Players[i].Race)
    playersProp[1 + i].race:setWidth(65)

    playersProp[1 + i].ai = menu:addDropDown(ais, offxAI - 65, offy_i, function() end)
    for j = 0,3 do
      if (ais[1 + j] == Players[i].AiName) then playersProp[1 + i].ai:setSelected(j) end
    end
    playersProp[1 + i].ai:setWidth(130)

    playersProp[1 + i].gold = menu:addTextInputField(Players[i].Resources[1], offxGold - 20, offy_i, 40)
    playersProp[1 + i].lumber = menu:addTextInputField(Players[i].Resources[2], offxLumber - 20, offy_i, 40)
    playersProp[1 + i].stone = menu:addTextInputField(Players[i].Resources[5], offxOil - 20, offy_i, 40)
--    playersProp[1 + i].oil = menu:addTextInputField(Players[i].Resources[3], offxOil - 20, offy_i, 40)
    updateProp(i)
  end

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 4) - 106 - 10, sizeY - 16 - 27,
    function()
      for i = 0, 14 do
        Map.Info.PlayerType[i] = playersProp[1 + i].type:getSelected() + 2
        Players[i].Race = playersProp[1 + i].race:getSelected()
        Players[i].AiName = ais[1 + playersProp[1 + i].ai:getSelected()]
        Players[i].Resources[1] = playersProp[1 + i].gold:getText()
        Players[i].Resources[2] = playersProp[1 + i].lumber:getText()
        Players[i].Resources[5] = playersProp[1 + i].stone:getText()
--        Players[i].Resources[3] = playersProp[1 + i].oil:getText()
      end
      menu:stop()
    end)

  menu:addHalfButton(_("~!Cancel"), "c", 3 * (sizeX / 4) - 106 - 10, sizeY - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Change player properties from the editor
--
function RunEditorMapProperties()
-- TODO : manage edition of all properties.
  local menu = WarGameMenu(panel(3))

  local sizeX = 384
  local sizeY = 256

  menu:resize(sizeX, sizeY)
  menu:addLabel("Map Properties", sizeX / 2, 11)

  menu:addLabel("Map Name: ", 45, 11 + 36, nil, false)
  local desc = menu:addTextInputField(Map.Info.Description, 15, 36 * 2, 350)

  menu:addLabel("Size    : " .. Map.Info.MapWidth .. " x " .. Map.Info.MapHeight, 45, 36 * 3, nil, false)
--  menu:addLabel("Size : ", 15, 36 * 3, nil, false)
--  local sizeX = menu:addTextInputField(Map.Info.MapWidth, 75, 36 * 3, 50)
--  menu:addLabel(" x ", 130, 36 * 3, nil, false)
--  local sizeY = menu:addTextInputField(Map.Info.MapHeight, 160, 36 * 3, 50)

  menu:addLabel("Tileset : ", 45, 36 * 4, nil, false)

  local list = { "Cave", "Conifer Forest (Summer)", "Conifer Forest (Autumn)", "Dungeon", "Fairlimbed Forest", "Swamp"}
  for i=table.getn(list)+1, table.getn(editor_tilesets) do
	table.insert(list, FullyCapitalizeString(string.gsub(editor_tilesets[i], "_", " ")))
  end
  local dropDownTileset = menu:addDropDown(list, 130, 36 * 4, function() end)
  for i = 0,table.getn(list)-1 do
    if (list[1 + i] == Map.Tileset.Name) then dropDownTileset:setSelected(i)
    end
  end
  dropDownTileset:setEnabled(false) -- TODO : manage this properties

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 3) - 106 - 10, sizeY - 16 - 27,
    function()
      Map.Info.Description = desc:getText()
      -- TODO : Add others properties
      menu:stop()
    end
    )

  menu:addHalfButton(_("~!Cancel"), "c", 3 * (sizeX / 3) - 106 - 10, sizeY - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Main menu in editor.
--
function RunInEditorMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Editor Menu", 128, 11)

  menu:addFullButton("Save (~<F11~>)", "f11", 16, 40, RunEditorSaveMenu)
  local buttonEditorLoad = -- To be removed when enabled.
  menu:addFullButton("Load (~<F12~>)", "f12", 16, 40 + 36 * 1, RunEditorLoadMenu)
  menu:addFullButton("Map Properties (~<F5~>)", "f5", 16, 40 + 36 * 2, RunEditorMapProperties)
  menu:addFullButton("Player Properties (~<F6~>)", "f6", 16, 40 + 36 * 3, RunEditorPlayerProperties)

  buttonEditorLoad:setEnabled(false) -- To be removed when enabled.

  menu:addFullButton("E~!xit to Menu", "x", 16, 40 + 36 * 4,
    function() Editor.Running = EditorNotRunning; menu:stopAll(); end)
  menu:addFullButton("Return to Editor (~<Esc~>)", "escape", 16, 288 - 40,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Function to edit unit properties in Editor
--
function EditUnitProperties()

  if (GetUnitUnderCursor() == nil) then
    return;
  end
  local menu = WarGameMenu(panel(1))
  local sizeX = 256
  local sizeY = 200 -- 288

  menu:resize(sizeX, sizeY)
  menu:addLabel("Unit Properties", sizeX / 2, 11)

  if (GetUnitUnderCursor().Type.GivesResource == 0) then
    menu:addLabel("Artificial Intelligence", sizeX / 2, 11 + 36)
    local activeCheckBox = menu:addImageCheckBox("Active", 15, 11 + 72)
    activeCheckBox:setMarked(GetUnitUnderCursor().Active)

    menu:addHalfButton("~!Ok", "o", 24, sizeY - 40,
      function() GetUnitUnderCursor().Active = activeCheckBox:isMarked();  menu:stop() end)
  else
--    local resourceName = {"gold", "lumber", "oil"}
    local resourceName = {"gold", "lumber", "stone"}
    local resource = GetUnitUnderCursor().Type.GivesResource - 1
    menu:addLabel("Amount of " .. resourceName[1 + resource] .. " :", 24, 11 + 36, nil, false)
	local resourceValue = menu:addTextInputField(GetUnitUnderCursor().ResourcesHeld, sizeX / 2 - 30, 11 + 36 * 2, 60)

    menu:addHalfButton("~!Ok", "o", 24, sizeY - 40,
      function() GetUnitUnderCursor().ResourcesHeld = resourceValue:getText();  menu:stop() end)
  end
  menu:addHalfButton(_("~!Cancel"), "c", 134, sizeY - 40,
    function() menu:stop() end)
  menu:run(false)
end
