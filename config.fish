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
function pbcpy; fish_clipboard_copy $argv; end
function pbpst; fish_clipboard_paste $argv; end
direnv hook fish | source
set -g direnv_fish_mode disable_arrow 
