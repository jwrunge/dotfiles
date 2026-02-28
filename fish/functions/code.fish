<<<<<<< HEAD
function code --description 'ide-like environment with AI worktree'
    # 1. Handle navigation first
    if test -n "$argv"
        z $argv; or echo "Zoxide match not found, using current directory..."
    end

    # 2. Define our paths
    set -l main_pane $WEZTERM_PANE
    set -l dirname (basename $PWD)
    set -l altname "../wt.$dirname"
    set -l branch_name "ai-session-$dirname"

    # 3. Ensure the Worktree exists
    if not test -d "$altname"
        echo "Creating new git worktree at $altname..."
        # Create a new branch for the worktree to avoid 'already checked out' errors
        git worktree add "$altname" -b "$branch_name" 2>/dev/null
        or git worktree add "$altname" "$branch_name" 2>/dev/null # Try existing branch if -b fails
    else
        echo "Using existing worktree at $altname"
    end

    # 4. Create the Layout in WezTerm
    # Note: we pass --cwd to the split command so the pane starts in the worktree
    set -l top_right (wezterm cli split-pane --right --percent 30)
    set -l bottom_right (wezterm cli split-pane --pane-id $top_right --bottom --cwd "$altname")

    # 5. Kick off the tools
    sleep 0.5 # Give the panes a moment to initialize
    echo lazygit | wezterm cli send-text --pane-id $top_right --no-paste
    wezterm cli send-text --pane-id $top_right --no-paste --enter ""

    echo copilot | wezterm cli send-text --pane-id $bottom_right --no-paste
    wezterm cli send-text --pane-id $bottom_right --no-paste --enter ""

    # 6. Open Helix in the current directory
=======
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

>>>>>>> d47ac53b4c8af52257bb3a455174b11a0e2e9ee2
    wezterm cli activate-pane --pane-id $main_pane
    hx .
end
