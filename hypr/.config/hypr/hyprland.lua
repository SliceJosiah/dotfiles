-- This is Brinton's Hyprland config file :3
-- Based off my old Hyprlang config.

-- |||||||||||||||||||
-- || Colour themes ||
-- |||||||||||||||||||

-- ||     Ninex     ||
-- || By BrintonTua ||
-- || for Hyprland  ||

local ninex = {
	-- || Base ||
	Base = "#070D16",
	Over1 = "#191C22",
	Over2 = "#25262B",
	Over3 = "#2C2E31",
	Over4 = "#AEB1B5",
	Over5 = "#CCCCCF",
	-- || Text ||
	MainText = "#9A9CA4",
	DarkText = "#6B707E",
	-- || Main colours ||
	DarkBlue = "#1613AB",
	MidBlue = "#0000FF",
	LightBlue = "#5665FF",
	DarkPurple = "#7B01A2",
	MidPurple = "#9200CE",
	LightPurple = "#C344FF",
	DarkCyan = "#007C64",
	MidCyan = "#00AF95",
	LightCyan = "#48E6AF",
	-- || Secondary colours ||
	DarkOrange = "#CF7D00",
	LightOrange = "#FF9E4E",
	DarkGreen = "#5CCE21",
	LightGreen = "#97F631",
	DarkPink = "#B912AF",
	LightPink = "#E600FE",
	DarkRed = "#BD1B26",
	LightRed = "#F7144C",
}

-- ||||||||||||||||||||
-- || Monitor config ||
-- ||||||||||||||||||||

require(local/hyprland-monitor)

-- |||||||||||||||||
-- || My programs ||
-- |||||||||||||||||

local terminal		= "kitty"
local fileManager	= "dolphin"
local menu		= "fuzzel"
--local screenshot	= "hyprshot"

local bar		= "waybar"
local background	= "hyprpaper"

-- |||||||||||||||
-- || Autostart ||
-- |||||||||||||||


hl.on("hyprland.start", function ()
	hl.exec_cmd(bar & background)
	hl.exec_cmd("openrgb --startminimized")
)

-- |||||||||||||||||||||||||||
-- || Environment variables ||
-- |||||||||||||||||||||||||||

-- || Cursor size ||
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- || Qt variables ||
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- || XDG variables ||
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- || Fix Dolphin / KDE file associations ||
hl.env("XDG_MENU_PREFIX", "arch-")
hl.exec_cmd("dbus-update-activation-environment --systemd XDG_MENU_PREFIX")

-- || Machine specific ||
require(local/hyprland-environments)

hl.config({
	general {
		gaps_in = 5,
		gaps_out = 20,
		border_size = 3,

		col = {
			active_border = { colors = {LightBlue, LightCyan}, angle = 135 },
			inactive_border = { colors = {DarkBlue, DarkCyan}, angle = 45 },
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = dwindle,
	},

	decoration {
		rounding = 12,
		rounding_power = 4,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow {
			enabled = true,
			range = 3,
			render_power = 2,
			color = rgba(00000080),
			offset = 3, 3,
		},

		blur {
			enabled = true,
			size = 5,
			passes = 1,
			vibrancy = 0.1696,
		},

		animations = {
			enabled = true,
		}
	},
})

-- ||||||||||||||||
-- || Animations ||
-- ||||||||||||||||

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- ||||||||||||
-- || Layout ||
-- ||||||||||||

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- ||||||||||
-- || Misc ||
-- ||||||||||

hl.config({
	misc = {
		force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

-- |||||||||||
-- || Input ||
-- |||||||||||

hl.config({
	input = {
		kb_layout  = "mao",
		kb_variant = "",
		kb_model   = "",
		kb_options = "",
		kb_rules   = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

-- ||||||||||||||
-- || Keybinds ||
-- ||||||||||||||

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.pin())

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "", action = "toggle" }))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(kaomoji))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot .. " --mode output"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --mode window"))
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd(screenshot .. " --mode region"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Custom: Resize windows with arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -25, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 25, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -25, relative = true }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 25, relative = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- || PC keyboard volume keys ||

--hl.bind()

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- ||||||||||||||||||||||||||||
-- || Windows and Workspaces ||
-- ||||||||||||||||||||||||||||

-- // Ignore maximise requests from apps //

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- #######################################################################################
-- AUTOGENERATED HYPRLAND CONFIG.
-- PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hyprland.conf AND EDIT IT,
-- OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
-- #######################################################################################

-- This is an example Hyprland config file.
-- Refer to the wiki for more information.
-- https://wiki.hyprland.org/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- Create your files separately and then link them to this file like this:
-- source = ~/.config/hypr/myColors.conf

--####################
--## COLOUR THEMES ###
--####################

--#   Arutoria   ##
--#  By Yosaia   ##
--# for Hyprland ##
--##################################
-- Generated by hyprlang2lua. Review TODOs before reloading Hyprland.

local base = "rgb(060d16)"
local over1 = "rgb(191c22)"
local over2 = "rgb(24262b)"
local over3 = "rgb(2c2e32)"
--#######
local light1 = "rgb(afb1b6)"
local light2 = "rgb(cbcccf)"
--#######
local textdark = "rgb(9a9ca4)"
local textlight = "rgb(6b6f7e)"
--#######
local prilight = "rgb(0000ff)"
local terlight = "rgb(9a00ff)"
local seclight = "rgb(49e6ae)"
local errlight = "rgb(f7174b)"
local afflight = "rgb(97f731)"
local wrnlight = "rgb(ff8c3c)"
local mgalight = "rgb(e500ff)"
--#######
local pridark = "rgb(1313aa)"
local terdark = "rgb(9214b8)"
local secdark = "rgb(30c3a7)"
local errdark = "rgb(bd1b26)"
local affdark = "rgb(5cce1f)"
local wrndark = "rgb(e38e19)"
local mgadark = "rgb(b814ae)"

--###################
--## CUSTOM FIXES ###
--###################

hl.config({
    debug = {
        full_cm_proto = true,
    },
})

hl.config({
    render = {
        cm_enabled = true,
        send_content_type = true,
        cm_auto_hdr = 2,
    },
})

--###############
--## MONITORS ###
--###############

-- See https://wiki.hyprland.org/Configuring/Monitors/

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@180",
    scale = "1",
    bitdepth = "10",
    cm = "srgb",
    --sdrbrightness = 1
    --sdr_eotf = 2
    --sdr_min_luminance = 0.3
    --sdr_max_luminance = 300
    --min_luminance = 0.3
    --max_luminance = 300
    --supports_wide_color = 1
    --supports_hdr = 1
})

--monitor = eDP-1, disable, 1920x1080@144, 0x0, 1.2, cm, srgb
--monitor = HDMI-A-1, 1920x1080@180, auto-up, 1, bitdepth, 10, cm, hdr, sdrbrightness, 2, sdr_eotf, 0
--monitor = HDMI-A-1, 1920x1080@180, auto-up, 1, bitdepth, 10, cm, wide
--monitor = HDMI-A-1, 1920x1080@60, auto-up, 1

--##################
--## MY PROGRAMS ###
--##################

-- See https://wiki.hyprland.org/Configuring/Keywords/

-- Set programs that you use
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local kaomoji = "wl-kaomoji -s"
local screenshot = "hyprshot"

--################
--## AUTOSTART ###
--################

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

-- exec-once = $terminal
-- exec-once = nm-applet &
-- exec-once = waybar & hyprpaper & firefox

--exec-once = openrgb --startminimized
--exec-once = /usr/lib/polkit-kde-authentication-agent-1
--exec-once = pcloud
--exec-once = hyprpaper

--############################
--## ENVIRONMENT VARIABLES ###
--############################

-- See https://wiki.hyprland.org/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

 -- toolkit-specific scale
hl.env("GDK_SCALE", "1.2")

-- Fix Dolphin / KDE file associations
hl.env("XDG_MENU_PREFIX", "arch-")

--##################
--## PERMISSIONS ###
--##################

-- See https://wiki.hyprland.org/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- ecosystem {
--   enforce_permissions = 1
-- }

-- permission = /usr/(bin|local/bin)/grim, screencopy, allow
-- permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
-- permission = /usr/(bin|local/bin)/hyprpm, plugin, allow

--####################
--## LOOK AND FEEL ###
--####################

-- Refer to https://wiki.hyprland.org/Configuring/Variables/

-- https://wiki.hyprland.org/Configuring/Variables/#general

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 3,
        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = prilight .. " " .. seclight .. " 135deg",
            inactive_border = pridark .. " " .. secdark .. " 45deg",
        },
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#decoration

hl.config({
    decoration = {
        rounding = 12,
        rounding_power = 4,
        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 3,
            render_power = 2,
            sharp = false,
            color = "rgba(00000080)",
            offset = "3, 3",
        },
        -- https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true,
            size = 5,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#animations
hl.config({
    animations = {
        enabled = "yes, please :)",
        -- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
    leaf = "global",
    enabled = true,
    speed = 10,
    bezier = "default",
})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 4.79,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    bezier = "easeOutQuint",
    style = "popin 87%",
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%",
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 3.03,
    bezier = "quick",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint",
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade",
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade",
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1.21,
    bezier = "almostLinear",
    style = "fade",
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade",
})

-- Ref https://wiki.hyprland.org/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- workspace = w[tv1], gapsout:0, gapsin:0
-- workspace = f[1], gapsout:0, gapsin:0
-- windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
-- windowrule = rounding 0, floating:0, onworkspace:w[tv1]
-- windowrule = bordersize 0, floating:0, onworkspace:f[1]
-- windowrule = rounding 0, floating:0, onworkspace:f[1]

-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more

hl.config({
    dwindle = {
        --pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more

hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#misc

hl.config({
    misc = {
        force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

 -- unscale XWayland

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

--############
--## INPUT ###
--############

-- https://wiki.hyprland.org/Configuring/Variables/#input

hl.config({
    input = {
        kb_layout = "mao",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- https://wiki.hyprland.org/Configuring/Variables/#gestures

-- Example per-device config
-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

--##################
--## KEYBINDINGS ###
--##################

-- See https://wiki.hyprland.org/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
--bind = $mainMod, X, toggle, # dwindle
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.pin())

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "", action = "toggle" }))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(kaomoji))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot .. " --mode output"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --mode window"))
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd(screenshot .. " --mode region"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Custom: Resize windows with arrow keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -25, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 25, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -25, relative = true }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 25, relative = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--#############################
--## WINDOWS AND WORKSPACES ###
--#############################

-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
-- See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

-- Example windowrule
-- windowrule = float,class:^(kitty)$,title:^(kitty)$

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
    name = "ignoremaximise",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Fix Blender file window being too small
hl.window_rule({
    match = {
        class = "blender",
        initial_title = "File Browser",
    },
    size = "1200 800",
})

