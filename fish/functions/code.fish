function code --description 'ide-like environment'
    if test -n "$argv"
        # Try to jump with z. If it fails, stay put (using '.')
        z $argv; or echo "Zoxide match not found, using current directory..."
    end

    set -l main_pane $WEZTERM_PANE
    set -l top_right (wezterm cli split-pane --right --percent 30)
    set -l bottom_right (wezterm cli split-pane --pane-id $top_right --bottom)
    set -l abs_path (realpath $target_path)

    sleep 0.2
    echo lazygit | wezterm cli send-text --pane-id $top_right --no-paste
    echo copilot | wezterm cli send-text --pane-id $bottom_right --no-paste

    wezterm cli activate-pane --pane-id $main_pane
    hx .
end
