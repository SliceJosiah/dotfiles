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
