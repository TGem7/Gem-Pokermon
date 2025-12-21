GEM.utils = {}

function GEM.utils.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function GEM.utils.filter(list, func)
  new_list = {}
  for _, v in pairs(list) do
    if func(v) then
      new_list[#new_list + 1] = v
    end
  end
  return new_list
end

function GEM.utils.for_each(list, func)
  for _, v in pairs(list) do
    func(v)
  end
end

function GEM.utils.copy_list(list)
  return GEM.utils.map_list(list, GEM.utils.id)
end

function GEM.utils.map_list(list, func)
  new_list = {}
  for _, v in pairs(list) do
    new_list[#new_list + 1] = func(v)
  end
  return new_list
end

function GEM.utils.id(a)
  return a
end

-- family utils functions
function GEM.find_family(cardname, get_index)
  for k, v in pairs(pokermon.family) do
    for x, y in pairs(v) do
      if y == cardname or (type(y) == "table" and y.key == cardname) then
        return get_index and {line = k, index = x} or k
      end
    end
  end
end

function GEM.append_to_family(existing_name, new_name, to_end)
  local family_line, family_index = pokermon.family[GEM.find_family(existing_name, true).line], GEM.find_family(existing_name, true).index
  table.insert(family_line, to_end and #family_line + 1 or family_index + 1, new_name)
end

-- metafunctions
function GEM.utils.hook_before_function(table, funcname, hook)
  if not table[funcname] then
    table[funcname] = hook
  else
    local orig = table[funcname]
    table[funcname] = function(...)
      return hook(...)
          or orig(...)
    end
  end
end

function GEM.utils.hook_after_function(table, funcname, hook)
  if not table[funcname] then
    table[funcname] = hook
  else
    local orig = table[funcname]
    table[funcname] = function(...)
      return orig(...)
          or hook(...)
    end
  end
end