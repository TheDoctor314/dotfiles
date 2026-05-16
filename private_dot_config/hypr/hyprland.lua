local terminal = "alacritty"
local browser = "brave"
local fileManager = "thunar"
local menu = "rofi -modi window,run,combi,drun -show combi -combi-modi window,drun"
local clipboard = "rofi -modi clipboard:~/.config/hypr/scripts/cliphist-rofi-img -show clipboard -show-icons"

-- Some default env vars.
hl.env("XCURSOR_SIZE","24")
hl.env("QT_QPA_PLATFORMTHEME","qt5ct") -- change to qt6ct if you have that

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/
hl.config({
    input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "caps:escape, shift:both_capslock",
    kb_rules = "",

    follow_mouse = 1,

    touchpad = {
        natural_scroll = true,
        tap_and_drag = true
    },

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification
    numlock_by_default = true
}})

hl.config({
        general = {
            -- See https://wiki.hyprland.org/Configuring/Variables/ for more
            gaps_in = 3,
            gaps_out = 5,
            border_size = 1,
            col = {
                active_border = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45},
                inactive_border = "rgba(595959aa)",
            },
            layout = "master",

            -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false
        }
    }
)

hl.config({
    decoration = {
    -- See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 5,

    blur = {
        -- TODO
        -- enabled = true
        enabled = false,
        size = 3,
        passes = 1,
        vibrancy = 0.1696,
    },

    shadow = {
        enabled = false
    },
}})

hl.config({
    group = {
        groupbar = {
            col = {
                inactive = "rgba(2d343666)",
                active = "rgba(46515466)",
            }
        }
    }
})

hl.config({
    animations = {
        -- TODO
        -- enabled = true
        enabled = false,

}})

hl.config({
    dwindle = {
        -- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        preserve_split = true -- you probably want this
    }
})

hl.config({
        master = {
            -- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_status = "slave",
        }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 2,
    direction = "pinch",
    mods = "ALT",
    action = "resize"
})

hl.config({
        misc = {
            -- See https://wiki.hyprland.org/Configuring/Variables/ for more
            force_default_wallpaper = 0 -- Set to 0 to disable the anime mascot wallpapers
        }
})

-- Example per-device config
-- See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more

-- Example windowrule v1
-- windowrule = float, ^(kitty)$
-- Example windowrule v2
-- windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

-- mpv rule
hl.window_rule({
    name = "center-mpv",
    match = {
        class = "mpv"
    },

    float = true,
    center = true,
    size = { "(window_w*0.6)", "(window_h*0.6)" },
})

-- scratchpad opacity rule
hl.window_rule({
    match = {
        workspace = "special:magic"
    },
    opacity = 0.9
})


-- See https://wiki.hyprland.org/Configuring/Keywords/ for more
local mainMod = "SUPER"

local media_opts = { locked = true, repeating = true }
-- Screen brightness
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  media_opts)
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  media_opts)

-- Volume and Media Control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), media_opts)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), media_opts)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), media_opts)

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), media_opts)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), media_opts)
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), media_opts)
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   media_opts)

local join_keys = function (keys)
    return table.concat(keys, " + ")
end

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(join_keys({ mainMod, "Return" }), hl.dsp.exec_cmd(terminal))
hl.bind(join_keys({ mainMod, "Q" }), hl.dsp.window.kill())
hl.bind(join_keys({ mainMod, "CTRL", "Q" }), hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(join_keys({ mainMod, "E" }), hl.dsp.exec_cmd(fileManager))
hl.bind(join_keys({ mainMod, "space" }), hl.dsp.window.float({ action = "toggle" }))
hl.bind(join_keys({ mainMod, "R" }), hl.dsp.exec_cmd(menu))
hl.bind(join_keys({ mainMod, "P" }), hl.dsp.exec_cmd(browser))

local default_apps = {"firefox", "alacritty", "code", "thunar" }
hl.bind(join_keys({ mainMod, "T" }), function ()
    local w = hl.get_active_workspace()

    if w ~= nil and default_apps[w.id] ~= nil then
        return hl.dispatch(hl.dsp.exec_cmd(default_apps[w.id]))
    end
end)

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(join_keys({ mainMod, "F" }), hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(join_keys({ mainMod, "V" }), hl.dsp.exec_cmd(clipboard))

-- tabbed windows
-- TODO
-- bind = $mainMod, w, togglegroup
-- bind = ALT, h, changegroupactive, b
-- bind = ALT, l, changegroupactive, f

-- TODO
-- bind = $mainMod SHIFT, left, movewindoworgroup, l
-- bind = $mainMod SHIFT, right, movewindoworgroup, r
-- bind = $mainMod SHIFT, up, movewindoworgroup, u
-- bind = $mainMod SHIFT, down, movewindoworgroup, d

-- Move focus with mainMod + arrow keys
-- hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
-- hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
-- hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
-- hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Cycle focus
hl.bind(join_keys({ mainMod, "h" }), hl.dsp.window.cycle_next({ next = false }))
hl.bind(join_keys({ mainMod, "l" }), hl.dsp.window.cycle_next())

-- Move through workspaces
hl.bind(join_keys({ mainMod, "k" }), hl.dsp.focus({workspace = "e-1"}))
hl.bind(join_keys({ mainMod, "j" }), hl.dsp.focus({workspace = "e+1"}))

-- Switch between current and previous workspace
hl.bind(join_keys({ mainMod, "Escape" }), hl.dsp.focus({workspace = "previous"}))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(join_keys({ mainMod, key }),             hl.dsp.focus({ workspace = i}))
    hl.bind(join_keys({ mainMod, "SHIFT", key }),     hl.dsp.window.move({ workspace = i }))
end

-- move current workspace to next monitor
hl.bind(join_keys({ mainMod, "CTRL", "m" }), hl.dsp.workspace.move({ monitor = "+1" }))

-- Switch to a submap called `resize`.
hl.bind(join_keys({ mainMod, "SHIFT", "R" }), hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()

    -- Set repeating binds for resizing the active window.
    hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })

    hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })

    hl.bind("k", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })

    hl.bind("j", hl.dsp.window.resize({ x = 10, y = -10, relative = true}), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 10, y = -10, relative = true}), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))

end)

-- Example special workspace (scratchpad)
hl.bind(join_keys({ mainMod, "S" }),         hl.dsp.workspace.toggle_special("magic"))
hl.bind(join_keys({ mainMod, "SHIFT", "S" }), hl.dsp.window.move({ workspace = "special:magic" }))

-- launch terminal on moving to empty scratchpad
hl.workspace_rule({ workspace = "special:magic", on_created_empty = "[float] " .. terminal })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(join_keys({ mainMod, "mouse_down" }), hl.dsp.focus({ workspace = "e-1" }))
hl.bind(join_keys({ mainMod, "mouse_up" }),   hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(join_keys({ mainMod, "mouse:272" }), hl.dsp.window.drag(),   { mouse = true })
hl.bind(join_keys({ mainMod, "mouse:273" }), hl.dsp.window.resize(), { mouse = true })

-- Close the last notification by dunst
hl.bind(join_keys({ mainMod, "n" }), hl.dsp.exec_cmd("dunstctl close"))

-- Run on startup
hl.on("hyprland.start", function ()
    hl.exec_cmd("~/.config/dunst/launch.sh")
    hl.exec_cmd("swaybg-wrapper.sh")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("waybar & hypridle") -- Execute waybar, hypridle

    -- manage media players
    hl.exec_cmd("playerctld daemon")

    -- inhibit sleep when playing audio
    hl.exec_cmd("sway-audio-idle-inhibit")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("hyprctl setcursor volantes_cursors 24")

    -- clipboard manager
    -- Stores only text data
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    -- Stores only image data
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-- managed by nwg-displays
-- source = ~/.config/hypr/monitors.conf
-- source = ~/.config/hypr/workspaces.conf
-- TODO: manage this by nwg-displays when updated in repos
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x2160",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1",
})
hl.workspace_rule({
    workspace = "6",
    monitor = "HDMI-A-1",
})
