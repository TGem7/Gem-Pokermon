GEM.list_utils = {}

function GEM.list_utils.id(a)
  return a
end

function GEM.list_utils.map(list, func)
  local new_list = {}
  for _, v in pairs(list) do
    new_list[#new_list+1] = func(v)
  end
  return new_list
end

function GEM.list_utils.for_each(list, func)
  for _, v in pairs(list) do
    func(v)
  end
end

function GEM.list_utils.shallow_copy(list)
  local copy = {}
  for k, v in pairs(list) do
    copy[k] = v
  end
  return copy
end

function GEM.list_utils.filter(list, func)
  local new_list = {}
  for _, v in pairs(list) do
    if func(v) then
      new_list[#new_list+1] = v
    end
  end
  return new_list
end

function GEM.list_utils.elem(list, item)
  for _, v in pairs(list) do
    if v == item then return true end
  end
  return false
end

function GEM.list_utils.any(list, func)
  -- if we didn't care about performance, we'd do it like this:
  -- return #GEM.list_utils.filter(list, func) > 0
  for _, v in pairs(list) do
    if func(v) then
      return true
    end
  end
  return false
end

function GEM.list_utils.all(list, func)
  -- if we didn't care about performance, we'd do it like this:
  -- return #GEM.list_utils.filter(list, func) == #list
  for _, v in pairs(list) do
    if not func(v) then
      return false
    end
  end
  return true
end

function GEM.list_utils.count_unique(list, optional_map)
  local seen, count = {}, 0
  for _, v in pairs(list) do
    if optional_map then v = optional_map(v) end
    if v and not seen[v] then
      seen[v] = true
      count = count + 1
    end
  end
  return count
end

function GEM.list_utils.rev(list)
  local rev_list = {}
  for i = #list, 1, -1 do
    table.insert(rev_list, list[i])
  end
  return rev_list
end