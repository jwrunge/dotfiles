if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""
    zoxide init fish | source
end
