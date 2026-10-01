local pages = {}

local function parse_name(str)
  return str:gsub('(%l)(%u)', '%1 %2')
end

local joker_name_wrapper = function(name)
  local func = function()
    local loc_entry = localize({ type = "name_text", set = "Joker", key = name })
    return parse_name(loc_entry)
  end
  return func
end

local populate_pages = function(list, loc_entry, header)
  local pageOpts = math.ceil(#list / 6)
  local startIndex = 0
  for i = 1, pageOpts do
    SMODS.process_loc_text(G.localization.misc.dictionary, loc_entry..i, header.." "..i.."/"..pageOpts)
    local page = {
      title = function() return localize(loc_entry..i) end,
      tiles = {}
    }
    for j = 1, 6 do
      local index = startIndex + j
      if not list[index] then break end
      local config_name = list[index].list[1]
      table.insert(page.tiles,
        {
          label = list[index].label and function() return list[index].label end or joker_name_wrapper(config_name),
          list = list[index].list,
          config_key = list[index].config_key,
        }
      )
    end
    startIndex = startIndex + 6
    pages[#pages+1] = page
  end
end

local main_list = GEM.config_list
populate_pages(main_list, 'Gem_pokemon', "Pokemon")

return {pages = pages}
