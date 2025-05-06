if status is-interactive
    # Commands to run in interactive sessions can go here
end
set SHELL /usr/bin/fish
set fish_greeting
set -g fish_key_bindings fish_vi_key_bindings
set -Ux fish_user_paths /usr/lib/postgresql/16/bin $fish_user_paths
alias ga='git add'
alias gc='git commit -v'
alias gd='git diff'
alias gst='git status'

alias gco='git checkout'
alias gcm='git checkout master'
alias grbm='git pull origin master --rebase'

alias gb='git branch'
# view remote branches
alias gbr='git branch --remote'

alias gup='git pull --rebase'
alias gp='git push'
# push a newly created local branch to origin
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias cls=clear

function f --wraps nnn --description 'support nnn quit and change directory'
    if test -n "$NNNLVL" -a "$NNNLVL" -ge 1
        echo "nnn is already running"
        return
    end

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "-x" from both lines below,
    # without changing the paths.
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command function allows one to alias this function to `nnn` without
    # making an infinitely recursive alias
    command nnn $argv

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm -- $NNN_TMPFILE
    end
end
set -l IMAGE_DIR $HOME/Pictures/kittyWallpapers

set -l IMAGE (find $IMAGE_DIR -type f '(' -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' ')' | shuf -n 1)

kitten @ set-window-logo $IMAGE
