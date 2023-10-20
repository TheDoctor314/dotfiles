local wezterm = require 'wezterm'

return {
    font = wezterm.font("Hack"),
    font_size = 15,
    -- Don't prefer the ligatures.
    harfbuzz_features = {"calt=0", "clig=0", "liga=0"},

    color_scheme = "Andromeda",

    -- We override the default program because wezterm spawns a login
    -- shell by default, which we don't want.
    default_prog = {"/usr/bin/zsh"},

    hide_tab_bar_if_only_one_tab = true,
}
