local wezterm = require("wezterm")
local config = wezterm.config_builder()
function split(str, ts)
	-- 引数がないときは空tableを返す
	if ts == nil then
		return {}
	end

	local t = {}
	i = 1
	for s in string.gmatch(str, "([^" .. ts .. "]+)") do
		t[i] = s
		i = i + 1
	end

	return t
end

-- 各タブの「ディレクトリ名」を記憶しておくテーブル
local title_cache = {}

wezterm.on("update-status", function(window, pane)
	local pane_id = pane:pane_id()
	title_cache[pane_id] = "-"
	local process_info = pane:get_foreground_process_info()
	if process_info then
		local cwd = process_info.cwd
		-- 文字列を削除している
		-- 環境に応じて変えること
		local rm_home = string.gsub(cwd, os.getenv("HOME"), "")
		local prj = string.gsub(rm_home, "/Development/Projects", "")
		local dirs = split(prj, "/")
		local root_dir = dirs[1]
		title_cache[pane_id] = root_dir
	end
end)

config.automatically_reload_config = true
config.font_size = 12.0
config.use_ime = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

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

-- タブ同士の境界線を非表示
config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}
config.initial_rows = 80
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
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local pane = tab.active_pane
	local pane_id = pane.pane_id

	local cwd = "none"
	if title_cache[pane_id] then
		cwd = title_cache[pane_id]
	else
		cwd = "-"
	end

	local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " [ " .. cwd .. " ] "
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
config.font_size = 16.0
-- ここにフォントの設定を追加
config.font = wezterm.font("HackGen35 Console")
config.use_ime = true

return config
