local map_list = GEM.utils.map_list
local DipTile = assert(SMODS.load_file("src/settings/tile.lua"))()
local content = assert(SMODS.load_file("src/settings/contents.lua"))()

local function create_tile_spacer()
  return { n = G.UIT.B, config = { w = 0.1, h = 3.5 } }
end

local function create_tile_grid(args)
  local page_options = {}

  for i, _ in ipairs(content.pages) do
    page_options[#page_options + 1] = localize('k_page') .. " " .. i .. "/" .. #content.pages
  end

  local current_page = content.pages[args.page_num]

  local first_row = { n = G.UIT.R, config = { align = "cm" }, nodes = { create_tile_spacer() } }
  local second_row = { n = G.UIT.R, config = { align = "cm" }, nodes = { create_tile_spacer() } }

  local tiles = current_page.tiles and map_list(current_page.tiles, function(tile)
    return DipTile {
      label = tile.label(),
      display_cards = tile.list,
      ref_table = GEM.config,
      ref_value = tile.config_key,
      mod_req = tile.mod_req,
    }
  end) or {}
  
  for i, tile in ipairs(tiles) do
    if i < 4 then
      table.insert(first_row.nodes, tile:render())
      table.insert(first_row.nodes, create_tile_spacer())
    else
      table.insert(second_row.nodes, tile:render())
      table.insert(second_row.nodes, create_tile_spacer())
    end
  end
  
  return {
    n = G.UIT.ROOT,
    config = { colour = G.C.CLEAR },
    nodes = {
      {
        n = G.UIT.C,
        nodes = {
          {
            n = G.UIT.R,
            config = { align = "cm", padding = 0.2 },
            nodes = {
              { n = G.UIT.T, config = { text = current_page.title(), colour = G.C.UI.TEXT, scale = 0.5 } },
            }
          },
          first_row,
          second_row,
          {
            n = G.UIT.R,
            config = { align = "cm", padding = 0.2 },
            nodes = {
              create_option_cycle({
                options = page_options,
                current_option = args.page_num,
                opt_callback = "nacho_update_config_page",
                scale = 0.8,
                colour = G.C.RED,
                cycle_shoulders = false,
                no_pips = true
              })
            }
          }
        }
      }
    }
  }
end

function G.FUNCS.nacho_update_config_page(e)
  if not e or not e.cycle_config then return end
  
  local grid_wrap = G.OVERLAY_MENU:get_UIE_by_ID("nacho_grid_wrap")
  if grid_wrap then
    grid_wrap.config.object:remove()
    grid_wrap.config.object = UIBox {
      definition = create_tile_grid { page_num = e.cycle_config.current_option },
      config = { parent = grid_wrap, type = "cm" },
    }
    grid_wrap.UIBox:recalculate()
  end
end

function SMODS.current_mod.extra_tabs()
	return {
    {
      label = 'Pokemon Config',
      tab_definition_function = function ()
        local grid = UIBox {
          definition = create_tile_grid { page_num = 1 },
          config = { type = "cm" },
        }
        return {
          n = G.UIT.ROOT,
          config = {
            r = 0.1,
            minw = 14,
            minh = 8.5,
            align = "cm",
            colour = G.C.BLACK,
            emboss = 0.05,
          },
          nodes = {
            { n = G.UIT.O, config = { id = "Gem_grid_wrap", object = grid } }
          }
        }
      end
    },
		-- insert more tables with the same structure here
    {
      label = 'Extra',
      tab_definition_function = function ()
        return {
          n = G.UIT.ROOT,
          config = {
            r = 0.1,
            minw = 7,
            minh = 3,
            align = "cm",
            colour = G.C.BLACK,
            emboss = 0.05,
          },
          nodes = {
            {
              n = G.UIT.C,
              config = {
                  align = "cm",
                  padding = 0.1,
                  r = 0.1,
                  colour = G.C.GREY,
                  emboss = 0.05,
              }
            }
          }
        }
      end
    },
	}
end
