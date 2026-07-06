#  Entry point that includes all other configs
#  
#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/fish)

set -q XDG_CONFIG_HOME || set XDG_CONFIG_HOME "$HOME/.config"

set -Ux fish_user_paths $HOME/.npm-global/bin $fish_user_paths

source $XDG_CONFIG_HOME/fish/main.fish
source $XDG_CONFIG_HOME/fish/colors.fish
source $XDG_CONFIG_HOME/fish/aliases.fish
source $XDG_CONFIG_HOME/fish/developer.fish
source $XDG_CONFIG_HOME/fish/prompt.fish
source $XDG_CONFIG_HOME/fish/web.fish
# opencode
fish_add_path /home/_hippo/.opencode/bin
set -gx PATH ~/.npm-global/bin $PATH
function pbcpy
    fish_clipboard_copy $argv
end
function pbpst
    fish_clipboard_paste $argv
end
direnv hook fish | source
set -g direnv_fish_mode disable_arrow
fish_add_path /home/_hippo/.local/bin

# ── Kitty Terminal Notification ───────────────────────────────
# Sends a desktop notification when a long command finishes (>15s)
function __notify_on_long_cmd --on-event fish_postexec
    set -l duration $CMD_DURATION
    if test "$duration" -gt 15000
        set -l seconds (math "$duration / 1000")
        set -l cmd (string join ' ' $argv)
        notify-send -t 5000 \
            -a "Kitty" \
            -i terminal \
            -h "string:sound-name:message-new-instant" \
            "✅ Command finished" \
            "$cmd — took {$seconds}s"
    end
end

# PAI shell setup — added by PAI installer
set -gx PATH $HOME/.bun/bin $HOME/.local/bin $PATH

function opencode
    if test -x "$HOME/.local/bin/opencode"
        $HOME/.local/bin/opencode $argv
    else if test -x "$HOME/.opencode/tools/opencode"
        $HOME/.opencode/tools/opencode $argv
    else
        command opencode $argv
    end
end

function pai
    set -l __pai_oldpwd (pwd)
    set -l __pai_bun "$HOME/.bun/bin/bun"
    cd /home/_hippo/pai-opencode
    if test -x $__pai_bun
        $__pai_bun run .opencode/PAI/Tools/pai.ts $argv
    else
        bun run .opencode/PAI/Tools/pai.ts $argv
    end
    set -l __pai_status $status
    cd $__pai_oldpwd
    return $__pai_status
end
# end PAI shell setup
direnv hook fish | source
