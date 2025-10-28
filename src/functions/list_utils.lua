list_utils = {}

function list_utils.id(a)
  return a
end

function list_utils.map(list, func)
  new_list = {}
  for _, v in pairs(list) do
    new_list[#new_list + 1] = func(v)
  end
  return new_list
end

function list_utils.for_each(list, func)
  for _, v in pairs(list) do
    func(v)
  end
end

function list_utils.copy(list)
  return list_utils.map(list, list_utils.id)
end

function list_utils.filter(list, func)
  new_list = {}
  for _, v in pairs(list) do
    if func(v) then
      new_list[#new_list + 1] = v
    end
  end
  return new_list
end

function list_utils.elem(list, item)
  for _, v in pairs(list) do
    if v == item then return true end
  end
  return false
end

return {
  name = "Gem List Helper Functions",
  key = "LIST_UTILS",
  value = list_utils
}
