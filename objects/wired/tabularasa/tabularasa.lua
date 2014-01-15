-- OmnipotentEntity compiled in support for doing config="{...JSON...}" so this approach is how we'll proceed
function init(virtual)
if virtual then return nil end
entity.setInteractive(true)
world.logInfo("tabularasa.lua:init(): tabularasa has done its init")

interfaceconfig = { config="/interface/tabularasa/tabularasa.config" , 
["filter"]={"mod"} }

config = setupConfig()
--world.logInfo(config)

entity.setAnimationState("tabulaState","animate")
end

function onInteraction(args)
  world.logInfo("tabularasa.lua:onInteraction(): Got interacted with!")
  return { "OpenCraftingInterface", interfaceconfig }
end

function setupConfig()
local buttonArrayX = 100
local buttonArrayY = 100
local buttonArrayMaxWidth = 2
local buttonArrayMaxHeight = 20
local buttonArrayHSpacing = 65
local buttonArrayVSpacing = 22

buttons = entity.configParameter("filterButtons")

world.logInfo("'buttons' is set to %s",buttons)

local header = [[
    requiresBlueprint = false,
          paneLayout = {
            panefeature = {
              ["type"] = "panefeature",
              keyDismissable = true,
              persistent = true
            },
            background = {
              ["type"] = "background",
              fileHeader = "/interface/crafting/craftingheader.png",
              fileBody = "/interface/crafting/craftingbody.png",
              fileFooter = "/interface/crafting/craftingfooter.png"
            },
            close = {
              ["type"] = "button",
              base = "/interface/inventory/x.png",
              hover = "/interface/inventory/xhover.png",
              press = "/interface/inventory/xpress.png",
              position = {322, 261}
            },
            windowtitle = {
              ["type"] = "title",
              title = "  TABULA RASA CRAFTING",
              subtitle = "  Unified Crafting Interface!",
              position = {-5, 252},
              icon = {
                ["type"] = "image",
                file = "/interface/crafting/craftingtable.png",
                position = {0, -20},
                zlevel = -1
              }
            },
            lblSchematics = {
              ["type"] = "label",
              position = {88, 243},
              hAnchor = "mid",
              value = "SCHEMATICS"
            },
            lblProducttitle = {
              ["type"] = "label",
              position = {265, 243},
              hAnchor = "mid",
              value = "PRODUCT"
            },
            spinCount = {
              ["type"] = "spinner",
              position = {202, 40},
              upOffset = 34
            },
            tbSpinCount = {
              ["type"] = "textbox",
              position = {214, 40},
              textAlign = "center",
              maxWidth = 15,
              regex = "x?\\d{0,3}",
              hint = ""
            },
            lblAmountInput = {
              ["type"] = "image",
              file = "/interface/crafting/amount.png",
              position = {208, 39},
              zlevel = -3
            },
            lbllvlSort = {
              ["type"] = "image",
              file = "/interface/crafting/organizelevelhigher.png",
              position = {123, 232},
              zlevel = -3
            },
            btnCraft = {
              ["type"] = "button",
              base = "/interface/button.png",
              hover = "/interface/buttonhover.png",
              position = {274, 38},
              caption = "Craft"
            },
            btnFilterHaveMaterials = {
              ["type"] = "button",
              base = "/interface/crafting/checkboxnocheck.png",
              baseImageChecked = "/interface/crafting/checkboxcheck.png",
              checkable = true,
              checked = false,
              position = {26, 84}
            },
            lblProduct = {
              ["type"] = "label",
              position = {51, 83},
              hAnchor = "left",
              value = "MATERIALS AVAILABLE"
            },

            scrollArea = {
              ["type"] = "scrollArea",
              rect = {5, 93, 174, 231},
              children = {
                itemList = {
                  ["type"] = "list",
                  schema = {
                    selectedBG = "/interface/crafting/craftableselected.png",
                    unselectedBG = "/interface/crafting/craftablebackground.png",
                    spacing = {0, 1},
                    memberSize = {156, 20},
                    listTemplate = {
                      background = {
                        ["type"] = "image",
                        file = "/interface/crafting/craftablebackground.png",
                        position = {0, 0},
                        zlevel = -1
                      },
                      itemName = {
                        ["type"] = "wraplabel",
                        position = {21, 11},
                        hAnchor = "left",
                        width = 116,
                        value = "Replace Me"
                      },
                      itemIcon = {
                        ["type"] = "itemslot",
                        position = {1, 1},
                        callback = "null"
                      },
                      level = {
                        ["type"] = "label",
                        position = {138, 9},
                        hAnchor = "mid",
                        value = "Lvl. 100"
                      },
                      moneyIcon = {
                        ["type"] = "image",
                        position = {126, 1},
                        file = "/interface/money.png"
                      },
                      priceLabel = {
                        ["type"] = "label",
                        position = {138, 1},
                        hAnchor = "left",
                        value = "0"
                      },
                      notcraftableoverlay = {
                        ["type"] = "image",
                        file = "/interface/crafting/notcraftableoverlay.png",
                        position = {0, 0},
                        zlevel = 1
                      }
                    }
                  }
                }
              }
            },
            description = {
              ["type"] = "widget",
              position = {190, 50},
              size = {140, 220}
            },
            filter = {
              ["type"] = "textbox",
              position = {56, 68},
              hint = "Search",
              maxWidth = 70,
              escapeKey = "close",
              enterKey = "filter",
              focus = true
            },
            categories = {
              ["type"] = "radioGroup",
              toggleMode = true,
              buttons = {
                {
                  position = {19, 45},
                  baseImage = "/interface/crafting/blocks.png",
                  baseImageChecked = "/interface/crafting/blocksSelected.png",
                  data = {
                    filter = { "materials" }
                  }
                },
                {
                  position = {39, 45},
                  baseImage = "/interface/crafting/armor.png",
                  baseImageChecked = "/interface/crafting/armorSelected.png",
                  data = {
                    filter = { "armors" }
                  }
                },
                {
                  position = {59, 45},
                  baseImage = "/interface/crafting/weapons.png",
                  baseImageChecked = "/interface/crafting/weaponsSelected.png",
                  data = {
                    filter = { "weapons" }
                  }
                },
                {
                  position = {79, 45},
                  baseImage = "/interface/crafting/items.png",
                  baseImageChecked = "/interface/crafting/itemsSelected.png",
                  data = {
                    filter = { "consumables" }
                  }
                },
                {
                  position = {99, 45},
                  baseImage = "/interface/crafting/smith.png",
                  baseImageChecked = "/interface/crafting/smithSelected.png",
                  data = {
                    filter = { "tools" }
                  }
                },
                {
                  position = {119, 45},
                  baseImage = "/interface/crafting/objects.png",
                  baseImageChecked = "/interface/crafting/objectsSelected.png",
                  data = {
                    filter = { "objects" }
                  }
                },
                {
                  position = {139, 45},
                  baseImage = "/interface/crafting/other.png",
                  baseImageChecked = "/interface/crafting/otherSelected.png",
                  data = {
                    filter = { "other" }
                  }
                }]]

local extrabuttons = ''

for num,bt in ipairs(buttons) do
    world.logInfo("iteration %d, bt is %s",num,bt)
    for k,v in pairs(bt) do world.logInfo("key %s is val %s",k,v) end
    if num > buttonArrayMaxWidth*buttonArrayMaxHeight then break end
    local x = buttonArrayX + buttonArrayHSpacing*( (num-1) % buttonArrayMaxWidth )
    local y = buttonArrayY - buttonArrayVSpacing*math.floor((num-1)/buttonArrayMaxWidth)
    --[[
    ---------------------------------------
    todo: 
        set proper layout parameters
        test the output config and filter functionality
    ---------------------------------------
    ]]--
    extrabuttons = extrabuttons .. [[,
                {
                  position = {]] .. tostring(x) .. "," .. tostring(y) .. [[},
                  baseImage = "]] .. bt["baseImage"] .. [[",
                  baseImageChecked = "]] .. bt["baseImageChecked"] .. [[",
                  data = {
                    filter = { "]] .. bt["filter"] .. [[" }
                  }
                }]]
end
local footer =  [[ 
              }
            },
            rarities = {
              ["type"] = "radioGroup",
              toggleMode = true,
              buttons = {
                {
                  position = {8, 232},
                  baseImage = "/interface/crafting/sortcommon.png",
                  baseImageChecked = "/interface/crafting/sortcommonselected.png",
                  data = {
                    rarity = { "common" }
                  }
                },
                {
                  position = {14, 232},
                  baseImage = "/interface/crafting/sortuncommon.png",
                  baseImageChecked = "/interface/crafting/sortuncommonselected.png",
                  data = {
                    rarity = { "uncommon" }
                  }
                },
                {
                  position = {20, 232},
                  baseImage = "/interface/crafting/sortrare.png",
                  baseImageChecked = "/interface/crafting/sortrareselected.png",
                  data = {
                    rarity = { "rare" }
                  }
                },
                {
                  position = {26, 232},
                  baseImage = "/interface/crafting/sortlegendary.png",
                  baseImageChecked = "/interface/crafting/sortlegendaryselected.png",
                  data = {
                    rarity = { "legendary" }
                  }
                }
              }
            }
          },
  tooltip = {
    panefeature = {
      ["type"] = "panefeature",
      keyDismissable = true,
      persistent = true
    },
    itemList = {
      position = {2, 3},
      ["type"] = "list",
      schema = {
        spacing = {0, 0},
        memberSize = {125, 25},
        listTemplate = {
          itemName = {
            ["type"] = "wraplabel",
            position = {22, 10},
            hAnchor = "left",
            width = 116,
            value = "Golden Moustache"
          },
          itemIcon = {
            ["type"] = "itemslot",
            position = {1, 1},
            callback = "null"
          },
          count = {
            ["type"] = "label",
            position = {118, 0},
            hAnchor = "right",
            value = "19/99"
          }
        }
      }
    }
  }
}
]]

local config = header .. extrabuttons .. footer


return config
end

