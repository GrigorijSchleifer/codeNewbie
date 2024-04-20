TMUX basic commands (MAC)

* `ctrl a` or `ctrl b` prefix (needed for all command to follow)

* `ctrl b` + `shift %` splitting panes left and right
* `ctrl b` + `shift "` splitting panes top and down 
* `ctrl b` + `arrow keys` navigating between panes down
* `ctrl d` close a pane or type `exit`
* `ctrl b` + `c` creating a new window (window contains pains)
* `ctrl b`+ `n` switch to the next window
* `ctrl b`+ `p` switch to the previous window
* `ctrl b`+ `o` switch between panes
* `ctrl b`+ `d` detach from a session (everything will still run in the background)

* `tmux ls` List the currently running sessions
* `tmux attach -t <sessionNumber>` attacht to a specific session number (presented by `tmux ls`¡¡¡)
* `tmux new -s <sessionName>` attacht to a specific session  
* `tmux rename-session -t 0 <sessionName>` rename a session using its number