#/usr/bin/bash

## main-vertical to right
function main_vertical_right() {
  # target is focused pane
  target_pane_index=`tmux display-message -p "#P"`
  num_of_pane=`tmux list-pane | wc -l`
  last_pane_index=`echo $num_of_pane-1 | bc -l`

  # swap current_pane to last_pane_index
  `tmux select-layout main-vertical`
  `tmux swap-pane -s$target_pane_index -t$last_pane_index`

  # set even height
  current_height=`tmux display-message -p "#{window_height}"`
  new_pane_height=`echo $current_height/$last_pane_index | bc`

  move_num_of_pane=`echo $last_pane_index-1 | bc`
  # move pane exclude 0 and last_pane to 0
  for i in `seq 1 $move_num_of_pane`
  do
    `tmux move-pane -l$new_pane_height -s$i -t0`
  done

  # resize main-pane size
  current_width=`tmux display-message -p "#{window_width}"`
  new_pane_width=`echo $current_width/$last_pane_index/10*6 | bc`

  `tmux resize-pane -x$new_pane_width`
  `tmux select-pane -t$last_pane_index`
}

function main_vertical_left() {
  target_pane_index=`tmux display-message -p "#P"`
  num_of_pane=`tmux list-pane | wc -l`
  last_pane_index=`echo $num_of_pane-1 | bc -l`

  `tmux select-layout main-vertical`
  `tmux swap-pane -s: -t 0`
  `tmux select-pane -s: -t 0`

  current_width=`tmux display-message -p "#{window_width}"`
  new_pane_width=`echo $current_width/$last_pane_index/10*6 | bc`
  tmux resize-pane -x$new_pane_width
}

if [[ ! -z "$1" ]]; then
  $1
else
  main_vertical_left
fi
