#! /bin/zsh

current_song=$(mpc current)
while true; do
  clear
  printf " ${current_song}"
  sleep 2
  for (( i=0; i<${#current_song}; i++ )); do
    clear
    printf "\r ${current_song:$i}  ${current_song:0:$i}"
    sleep 0.5
  done
  clear
  printf " ${current_song}"
  current_song=$(mpc current --wait)
done
