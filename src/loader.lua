local function load_file(file, load_item)
  if file.init then
    file.init()
  end
  if file.list then
    for _, item in ipairs(file.list) do
      if file.config_key then
        item.nacho_config_key = file.config_key
        if not nacho_config[item.nacho_config_key] then
          item.no_collection = true
        end
      end
      load_item(item)
    end
  end
end

local function load_directory(path, load_item, options)
  options = options or {}
  local files = NFS.getDirectoryItems(SMODS.current_mod.path .. path)

  for _, file_path in ipairs(files) do
    local file_type = NFS.getInfo(SMODS.current_mod.path .. path .. '/' .. file_path).type

    if file_type == "directory" then
      load_directory(path .. '/' .. file_path, load_item, options)
    elseif file_type ~= "symlink" then
      local file = assert(SMODS.load_file(path .. '/' .. file_path))()

      if type(file) == 'table' and file.can_load ~= false then
        if options.pre_load then options.pre_load(file) end
        load_file(file, load_item)
        if options.post_load then options.post_load(file) end
      end
    end
  end
end

local function load_sleeves(file)
  if (SMODS.Mods['CardSleeves'] or {}).can_load and CardSleeves
      and file.sleeves and #file.sleeves > 0 then
    for _, sleeve in ipairs(file.sleeves) do
      CardSleeves.Sleeve(sleeve)
    end
  end
end

local function load_pokemon(item)
  local custom_prefix = "nacho"
  local custom_atlas = item.atlas and string.find(item.atlas, "nacho")
  if not item.atlas then
    poke_load_atlas(item)
    poke_load_sprites(item)
  end
  pokermon.Pokemon(item, custom_prefix, custom_atlas)
end

local function load_pokemon_family(file)
  local names = GEM.utils.map_list(file.list, function(a) return a.name end)
  if file.family and #file.family > 1 then
    pokermon.add_family(file.family)
  elseif file.no_family then
  elseif #names > 1 then
    pokermon.add_family(names)
  end
end

return load_directory, {
  load_sleeves = load_sleeves,
  load_pokemon = load_pokemon,
  load_pokemon_family = load_pokemon_family,
}
