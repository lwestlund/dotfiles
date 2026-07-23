-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

local hostname = os.getenv("HOSTNAME")
if hostname then
  require(hostname)
end

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal = "kitty"
local lockscreen = "hyprlock"
local fileManager = "nautilus"
local menu = "noctalia msg panel-toggle launcher"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  animations = {
    enabled = true,
  },
  binds = {
    movefocus_cycles_fullscreen = true,
    workspace_back_and_forth = true,
    scroll_event_delay = 0,
  },
  decoration = {
    rounding = 4,
    rounding_power = 3,
    -- Change transparency of focused and unfocused windows
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = 0xee1a1a1a,
    },
    blur = {
      enabled = false,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
  -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
  dwindle = {
    preserve_split = true, -- You probably want this
    force_split = 2,
    special_scale_factor = 0.9,
  },
  general = {
    gaps_in = 4,
    gaps_out = 4,
    border_size = 1,
    col = {
      active_border = "rgba(ccccccee)",
      inactive_border = "rgba(595959aa)",
    },
    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,
    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = false,
    layout = "dwindle",
  },
  input = {
    kb_layout = "us,se",
    kb_options = "grp:win_space_toggle, ctrl:nocaps",

    repeat_rate = 25,
    repeat_delay = 270,

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    scroll_method = "2fg",

    touchpad = {
      disable_while_typing = true,
      natural_scroll = true,
    },
  },
  -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
  master = {
    new_status = "master",
  },
  misc = {
    disable_hyprland_logo = true, -- If true disables using a random hyprland logo
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,
  },
  -- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 3,
  direction = "vertical",
  action = "cursor_zoom",
  zoom_level = 2.0,
})

-- Per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
  name = "logitech-wireless-mouse-mx-master-2s-1",
  sensitivity = 0.0,
  accel_profile = "flat",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(
  mainMod .. " + SHIFT + E",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd(lockscreen))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + W", hl.dsp.layout("swapsplit")) -- dwindle only
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen()) -- dwindle only

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move active window with mainMod + shift + hjkl
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Window resizing
hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  -- Move active window to workspace i and follow along with it.
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
  -- Move active window to workspace i but don't follow along with it.
  hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("switch:on:Lid", hl.dsp.exec_cmd(lockscreen), { locked = true })

-- Volume keys
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true }
)

-- Media binds, requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Monitor brightness, requires brightnessctl
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("brightnessctl --min-value=2 set 10%+"),
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("brightnessctl --min-value=2 set 10%-"),
  { locked = true, repeating = true }
)

hl.bind("SHIFT + Print", function()
  hl.plugin.hyprcapture.open()
end)

hl.bind("CTRL + SHIFT + Print", function()
  hl.plugin.hyprcapture.open("window")
end)

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("systemctl --user restart waybar.service"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client --toggle-panel"))

local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5
---@param offset number
---@return nil
local function zoom(offset)
  local current = hl.get_config("cursor.zoom_factor")
  if offset ~= nil then
    current = current + offset
  elseif current ~= MIN_ZOOM then
    current = MIN_ZOOM
  else
    current = ZOOM_TOGGLE_FACTOR
  end
  current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
  hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + Z", zoom)
hl.bind("SUPER + mouse_up", function()
  zoom(0.1)
end)
hl.bind("SUPER + mouse_down", function()
  zoom(-0.1)
end)
hl.bind("SUPER + KP_ADD", function()
  zoom(0.5)
end)
hl.bind("SUPER + minus", function()
  zoom(-0.5)
end)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})
