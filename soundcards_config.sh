#!/bin/bash
vol=80
yast2 sound remove all
for (( i=0; i<=4; i++ ))
  do
    echo $i
    yast2 sound add
    if [[ $? -gt 0 ]];
    then
      echo $i
      break
    else
      yast2 sound volume card=$i ADC=$vol
      yast2 sound volume card=$i DAC=$vol
      amixer -c$i sset 'H/W' 'H/W In 0'
      for (( ch=1; ch<=7; ch++))
        do
          yast2 sound volume card=$i ADC_#$ch#=$vol
          yast2 sound volume card=$i DAC_#$ch#=$vol
          amixer -c$i sset 'H/W',$ch 'H/W In '$ch''
      done
    fi
done
