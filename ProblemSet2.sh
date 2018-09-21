#!/bin/bash
#Copy the dataset to the current working directory and make a diretory for buffer files
cp /ufrc/zoo6927/share/Class_Files/data/flights.May2017-Apr2018.csv ./
mkdir ./buffer

#This part is for Q1
grep "Gainesville" flights.May2017-Apr2018.csv | cut -d "," -f 13,16 | grep -c 1.00 > Q1-answer.txt
cat Q1-answer.txt
echo -e "\n"


#This part is for Q2
##1.Generate the 1st row of the table
echo "GNV to:,Total flights,Total flights delayed(>15min),Total flights delayed due to Weather" | column -s ',' -t > Q2-table.txt

##2.Generate the 2nd row of the table
echo "   ATL" > ./buffer/Q2-ATL.txt    ###1st column, 2nd row, white spaces are used to place the text appropriately in the table
grep Gainesville flights.May2017-Apr2018.csv | grep -c '"FL","ATL"' >> ./buffer/Q2-ATL.txt    ###count GNV-ATL flights
grep Gainesville flights.May2017-Apr2018.csv | grep '"FL","ATL"' | cut -d "," -f 13,16 | grep -c 1.00 >> ./buffer/Q2-ATL.txt    ###count >15min delayed flights
grep Gainesville flights.May2017-Apr2018.csv | grep '"FL","ATL"' | cut -d "," -f 24 | grep -v ^$ | grep -vc 0.00 >> ./buffer/Q2-ATL.txt    ###count weather delayed flights
cat ./buffer/Q2-ATL.txt | paste -sd "," | column -s ',' -t -o $'\t\t' >> Q2-table.txt    ###change the multi-line output into the table format

##3.Generate the 3rd row of the table
echo "   CLT" > ./buffer/Q2-CLT.txt    ###1st column, 3rd row
grep Gainesville flights.May2017-Apr2018.csv | grep -c '"FL","CLT"' >> ./buffer/Q2-CLT.txt    ###count GNV-CLT flights
grep Gainesville flights.May2017-Apr2018.csv | grep '"FL","CLT"' | cut -d "," -f 13,16 | grep -c 1.00 >> ./buffer/Q2-CLT.txt    ###count >15min delayed flights
grep Gainesville flights.May2017-Apr2018.csv | grep '"FL","CLT"' | cut -d "," -f 24 | grep -v ^$ | grep -vc 0.00 >> ./buffer/Q2-CLT.txt    ###count weather delayed flights
cat ./buffer/Q2-CLT.txt | paste -sd "," | column -s ',' -t -o $'\t\t' >> Q2-table.txt    ###change the multi-line output into the table format

##4.Generate the 4th row of the table
echo "   MIA" > ./buffer/Q2-MIA.txt    ###1st column, 4th row
grep Gainesville flights.May2017-Apr2018.csv | grep -c '"FL","MIA"' >> ./buffer/Q2-MIA.txt    ###count GNV-MIA flights
grep Gainesville flights.May2017-Apr2018.csv | grep '"FL","MIA"' | cut -d "," -f 13,16 | grep -c 1.00 >> ./buffer/Q2-MIA.txt    ###count >15min delayed flights
grep Gainesville flights.May2017-Apr2018.csv | grep '"FL","MIA"' | cut -d "," -f 24 | grep -v ^$ | grep -vc 0.00 >> ./buffer/Q2-MIA.txt    ###count weather delayed flights
cat ./buffer/Q2-MIA.txt | paste -sd "," | column -s ',' -t -o $'\t\t' >> Q2-table.txt    ###change the multi-line output into table format

cat Q2-table.txt
echo -e "\n"


#This part is for Q3
Airport-code () {
  cut -d "," -f 3 flights.May2017-Apr2018.csv | cut -d '"' -f 2 > ./buffer/buffer_Q3.txt
  cut -d "," -f 7 flights.May2017-Apr2018.csv | cut -d '"' -f 2 >> ./buffer/buffer_Q3.txt
  sort -u ./buffer/buffer_Q3.txt | grep -v "ORIG\|DEST" > Q3-answer.txt
  cat Q3-answer.txt
}
Airport-code
echo -e "\n"


#This part is for Q4
FL-airport () {
  grep ", FL" flights.May2017-Apr2018.csv > ./buffer/buffer_Q4-1.txt
  cut -d '"' -f 4 ./buffer/buffer_Q4-1.txt > ./buffer/buffer_Q4-2.txt
  cut -d '"' -f 10 ./buffer/buffer_Q4-1.txt >> ./buffer/buffer_Q4-2.txt
  grep "FL" ./buffer/buffer_Q4-2.txt | cut -d "," -f 1 | sort -u > Q4-answer.txt
  cat Q4-answer.txt
}
FL-airport

#Clean the dataset and buffer files
rm -r flights.May2017-Apr2018.csv ./buffer

##Cheers~
echo -e "\n\n"Done..."\n\n"We are The Bash Masters!
