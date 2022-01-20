local wezterm = require("wezterm")

-- tmux keybings
local tmux_keys = {
  -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  { key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
  { key = "|", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  -- panes
  { key = "%", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = '"', mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
  { key = "<", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
  { key = ">", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
  { key = "+", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
  { key = "-", mods = "LEADER", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
  { key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
  { key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
  { key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
  { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
  -- tabs (like tmux "windows")
  { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
  { key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
  { key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
  { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
  { key = "w", mods = "LEADER", action = "ShowTabNavigator" },
  -- font sizing
  { key = "-", mods = "SUPER", action = "DecreaseFontSize" },
  { key = "=", mods = "SUPER", action = "IncreaseFontSize" },
  { key = "0", mods = "SUPER", action = "ResetFontSize" },
  -- copy & paste
  { key = "c", mods = "SUPER", action = wezterm.action({ CopyTo = "Clipboard" }) },
  { key = "v", mods = "SUPER", action = wezterm.action({ PasteFrom = "Clipboard" }) },
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

  -- logging
  { key = "l", mods = "LEADER|CTRL", action = "ShowDebugOverlay" },
  -- copy-mode
  { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
}
for i = 1, 9 do
  -- CTRL+A + number to activate that tab
  table.insert(tmux_keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action({ ActivateTab = i - 1 }),
  })
end
local pane_movements_keys = {
  { direction = "Left", key = "h" },
  { direction = "Right", key = "l" },
  { direction = "Up", key = "k" },
  { direction = "Down", key = "j" },
}

-- move with ALT+[hjkl] between panes and vim splits
for _, movement in pairs(pane_movements_keys) do
  table.insert(tmux_keys, {
    key = movement.key,
    mods = "ALT",
    action = wezterm.action_callback(function(window, pane)
      local pane_title = pane:get_title()
      -- mux compatible
      if pane_title == "nvim" then
        window:perform_action(wezterm.action({ SendKey = { key = movement.key, mods = "ALT" } }), pane)
      else
        window:perform_action(wezterm.action({ ActivatePaneDirection = movement.direction }), pane)
      end
    end),
  })
end

-- prefix|leader status
wezterm.on("update-right-status", function(window, _)
  local leader = ""
  if window:leader_is_active() then
    leader = "LEADER"
  end
  window:set_right_status(leader)
end)

-- TokyoNight color_scheme
local my_colorschemes = {
  ["TokyoNight-Night"] = {
    foreground = "#c0caf5",
    background = "#1a1b26",

    -- Normal colors
    ansi = { "#15161E", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
    -- Bright colors
    brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
    indexed = {
      [16] = "#ff9e64",
      [17] = "#db4b4b",
    },
  },
}

return {
  -- font settings
  font = wezterm.font("SauceCodePro Nerd Font"),
  font_size = 14.0,
  adjust_window_size_when_changing_font_size = false,

  -- color settings
  color_scheme = "TokyoNight-Night",
  color_schemes = my_colorschemes,

  -- cursor config, invert color
  force_reverse_video_cursor = true,
  default_cursor_style = "SteadyBlock",

  -- tmux mimic
  -- keep SSH_AUTH_SOCK
  mux_env_remove = {
    "SSH_CLIENT",
    "SSH_CONNECTION",
  },
  -- tab bar at the bottom
  tab_bar_at_bottom = true,
  window_frame = {
    font = wezterm.font({ family = "Roboto", weight = "Bold" }),
    font_size = 13.0,
  },
  -- keybinds
  use_dead_keys = false,
  disable_default_key_bindings = true,
  leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3000 },
  keys = tmux_keys,
  -- other
  exit_behavior = "Close",
}
