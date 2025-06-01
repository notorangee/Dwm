#! /bin/zsh

echo -e "\e[?25l"
playing=$(mpc current)
next=${playing}
change=false
while true; do
  clear
  printf " ${playing}"
  sleep 2
  for (( i=0; i<${#playing}; i++ )); do
    next=$(mpc current)
    if [[ "${playing}" != "${next}" ]]; then
      playing=${next}
      change=true
      break 
    fi
    clear
    printf "\r ${playing:$i}  ${playing:0:$i}"
    sleep 0.5
  done
  if [[ "$change" = "true" ]]; then
    change=false
    continue
  fi
  clear
  printf " ${playing}"
  next=$(mpc current --wait)
  playing=${next}
done
