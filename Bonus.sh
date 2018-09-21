#!/bin/bash
cp /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv ./

echo -n "Please enter either airport-code or city-name or state-name (case-sensitive) -> "
read name
len="$(echo "$name" | wc -c)"
if [[ "$name" =~ [[0-9] ]];then
  echo "Invalid Input"
else
if ((len>2));then
    grep -w "$name" flights.May2017-Apr2018.csv | cut -d "," -f 13,16 | grep -c 1.00
else
  echo "Invalid Input"
  fi
fi

rm flights.May2017-Apr2018.csv
