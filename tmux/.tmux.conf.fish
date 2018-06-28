
# Default termtype. If the rcfile sets $TERM, that overrides this value.
set -g default-terminal screen-256color

# support logging out and back in
set -g update-environment "SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION"

# Mouse support ------------------------------------------------
set -g mouse on

# # Vi copypaste
setw -g mode-keys vi

# Bind `v` to trigger selection    
bind-key -T copy-mode-vi v send-keys -X begin-selection

# Bind `y` to yank current selection
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'

# Rebind `mouse click + drag button release` to not jump away from context
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'pbcopy'
# End Mouse support --------------------------------------------

# Open new stuff with correct CWD

#hsplit
unbind '"'
bind | split-window -h -c "#{pane_current_path}"

#vsplit
unbind %
bind - split-window -v -c "#{pane_current_path}"

# bind c new-window -c "#{pane_current_path}" \; split-window -h -c "#{pane_current_path}" \; select-pane -L

# set pane colors - hilight the active pane
set-option -g pane-border-fg colour60 #base02
set-option -g pane-active-border-fg colour62 #base01

# colorize messages in the command line
set-option -g message-bg black #base02
set-option -g message-fg brightred #orange

# smart pane switching with awareness of vim splits
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys C-l) || tmux select-pane -R"
bind -n C-\ run "(tmux display-message -p '#{pane_current_command}' | grep -iq vim && tmux send-keys 'C-\\') || tmux select-pane -l"

# Directly use C-l for clearing screen.
bind -n C-l send-keys 'C-l'

# ----------------------
# Status Bar
# -----------------------
set-option -g status on                # turn the status bar on
set -g status-interval 2               # set update frequencey (default 15 seconds)
set -g status-justify centre           # center window list for clarity
# set-option -g status-position top    # position the status bar at top of screen

# visual notification of activity in other windows
setw -g monitor-activity on
set -g visual-activity on

# show session name, window & pane number, date and time on right side of
# status bar
# set -g status-right-length 60
set -g status-right "%b %d %Y @ %l:%M %p"

# control automatic window renaming
set-window-option -g automatic-rename on # auto name
setw -g automatic-rename

# list all paste buffers (default key is '#')
bind-key b list-buffers

# choose buffer to paste interactively (default key was '=')
bind-key p choose-buffer

# delete the most recently copied buffer of text (default key was '-')
bind-key x delete-buffer

# scrolling with terminal scroll bar
set -g terminal-overrides 'xterm*:smcup@:rmcup@'

# Panes
# bind up resize-pane -U 5
# bind down resize-pane -D 5
# bind left resize-pane -L 5
# bind right resize-pane -R 5
bind tab next-layout
unbind C-o
bind r rotate-window
bind space select-pane -t:.+

# kill current pane/window
bind-key q confirm-before kill-pane
bind-key Q confirm-before kill-window

# Monitor Activity
bind m set-window-option monitor-activity

# window title
# enable wm window titles
set-option -g set-titles on

# wm window title string (uses statusbar variables)
set-option -g set-titles-string '#S:#I.#P #W' # window number,program name,active (or not)

# color scheme (styled as vim-powerline)
set -g status-left-length 52
set -g status-right-length 451
set -g status-fg white
set -g status-bg colour234
set -g pane-border-fg colour245
set -g pane-active-border-fg colour39
set -g message-fg colour16
set -g message-bg colour221
set -g message-attr bold
# set -g status-left '#[fg=colour235,bg=colour252,bold] â #S #[fg=colour252,bg=colour238,nobold]â®€#[fg=colour245,bg=colour238,bold] #(whoami) #[fg=colour238,bg=colour234,nobold]â®€'
# set -g window-status-format "#[fg=colour235,bg=colour252,bold] #I #W "
# set -g window-status-current-format "#[fg=colour234,bg=colour39]â®€#[fg=black,bg=colour39,noreverse,bold] #I: #W #[fg=colour39,bg=colour234,nobold]â®€"

# Pane resize in all four directions using vi bindings.
# Can use these raw but I map them to shift-ctrl-<h,j,k,l> in iTerm.
bind-key J resize-pane -D
bind-key K resize-pane -U
bind-key H resize-pane -L
bind-key L resize-pane -R

# easily toggle synchronization (mnemonic: e is for echo)
# sends input to all panes in a given window.
bind e setw synchronize-panes on
bind E setw synchronize-panes off

# No escape time for vi mode
set -sg escape-time 0

# Screen like binding for last window
unbind l
bind C-a last-window

# Bigger history
set -g history-limit 10000
# Reload key
unbind R
bind R source-file ~/.tmux.conf

set -g default-command /usr/local/bin/fish
set -g default-shell /usr/local/bin/fish
