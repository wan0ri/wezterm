local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font_size = 14.0
-- フォント（VSCodeの設定に近い順でフォールバック）
-- VSCodeの `monospace` は汎用族のため、WezTermでは実フォントに置換（Menlo）。
config.font = wezterm.font_with_fallback({
	"MesloLGS NF",
	"MesloLGS Nerd Font",
	"MesloLGS Nerd Font Mono",
	"Monaco",
	"Courier New",
	"Menlo",
	-- 日本語・絵文字フォールバック
	"Hiragino Sans",
	"Apple Color Emoji",
})
config.use_ime = true
config.window_background_opacity = 0.65
config.macos_window_background_blur = 10

----------------------------------------------------
-- Tab
----------------------------------------------------
-- タイトルバーを非表示
config.window_decorations = "RESIZE"
-- タブバーの表示
config.show_tabs_in_tab_bar = true
-- タブが一つの時は非表示
config.hide_tab_bar_if_only_one_tab = true
-- falseにするとタブバーの透過が効かなくなる
-- config.use_fancy_tab_bar = false

-- タブバーの透過
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}

-- タブバーを背景色に合わせる
config.window_background_gradient = {
	colors = { "#000000" },
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false
-- nightlyのみ使用可能
-- タブの閉じるボタンを非表示
config.show_close_tab_button_in_tabs = false

-- タブ同士の境界線を非表示
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
		-- 念のためタブの基本配色もシアン寄りに（format-tab-titleでも上書きされます）
		active_tab = {
			bg_color = "#00BCD4",
			fg_color = "#FFFFFF",
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
	},
	-- 通常カーソル（未合成時）
	cursor_bg = "#00BCD4",
	cursor_border = "#00BCD4",
	cursor_fg = "#000000", -- シアン上の文字は黒で視認性確保
	-- IME（かな漢字変換など）の合成中カーソル色
	compose_cursor = "#00BCD4",
}

-- タブの形をカスタマイズ
-- タブの左側の装飾
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
-- タブの右側の装飾
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		-- アクティブタブをシアンに
		background = "#00BCD4" -- cyan
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

----------------------------------------------------
-- keybinds
----------------------------------------------------
config.disable_default_key_bindings = true
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

return config
