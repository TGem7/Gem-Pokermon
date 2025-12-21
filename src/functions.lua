GEM = {}

local subdir = "src/functions/"
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)

for _, file in ipairs(files) do
  local func_lib = assert(SMODS.load_file(subdir .. file))()

  if func_lib.key and func_lib.value then
    GEM[func_lib.key] = func_lib.value
  end
end
