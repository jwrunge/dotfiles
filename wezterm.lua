local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local is_darwin = wezterm.target_triple:find("darwin") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local act = wezterm.action

-- Use fish (location differs by OS)
local fish_paths = { '/opt/homebrew/bin/fish', '/usr/bin/fish' }
for _, path in ipairs(fish_paths) do
  local f = io.open(path); if f then f:close()
    config.default_prog = { path }
    break
  end
end

-- Background settings
config.window_background_opacity = 0.9
if is_linux then config.kde_window_background_blur = true end
if is_darwin then config.macos_window_background_blur = 10 end

-- Keyboard shortcuts
config.keys = {
  -- Split horizontally (right)
  {
    key = 'l',
    mods = 'SHIFT|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split horizontally (left)
  {
    key = 'h',
    mods = 'SHIFT|ALT',
    action = act.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    }
  },
  -- Split vertically (bottom)
  {
    key = 'j',
    mods = 'SHIFT|ALT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    }
  },
  -- Split vertically (top)
  {
    key = 'k',
    mods = 'SHIFT|ALT',
    action = act.SplitPane {
      direction = 'Up',
      size = { Percent = 50 },
    }
  },
  -- Close current pane
  {
    key = ';',
    mods = "SHIFT|ALT",
    action = act.CloseCurrentPane { confirm = true }
  },
  -- Nav UDLR
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
}

return config
