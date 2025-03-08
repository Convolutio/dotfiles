-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.default_prog = { "/usr/bin/bash" }

-- Color scheme:

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "catppuccin-mocha"
	else
		return "catppuccin-latte"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.window_background_opacity = 0.9

config.font = wezterm.font("Cousine Nerd Font")

config.audible_bell = "Disabled"

-- and finally, return the configuration to wezterm
return config
