#!/bin/sh

ubicacionFiles="scripts/series_ubicaciones"

cout=15
s_col2=0
s_col3=0
s_col4=0
cant=0

while IFS=' ' read -r in out
do

	rm $out

	while IFS=' ' read -r n col2 col3 col4
	do
		if [ $n -eq $cout ]
		then 
			s_col2=$(echo "scale=20; $s_col2 + $col2" | bc)
			s_col3=$(echo "scale=20; $s_col3 + $col3" | bc)
			s_col4=$(echo "scale=20; $s_col4 + $col4" | bc)
			cant=$(echo $cant + 1 | bc)
		else
		s_col2=$(echo "scale=20; $s_col2 / $cant" | bc)
		s_col3=$(echo "scale=20; $s_col3 / $cant" | bc)
		s_col4=$(echo "scale=20; $s_col4 / $cant" | bc)
		echo "$cout $s_col2 $s_col3 $s_col4" >> $out
		cout=$n
		s_col2=0
		s_col3=0
		s_col4=0
		cant=0
		fi
	done < "$in"
	
	s_col2=$(echo "scale=20; $s_col2 / $cant" | bc)
	s_col3=$(echo "scale=20; $s_col3 / $cant" | bc)
	s_col4=$(echo "scale=20; $s_col4 / $cant" | bc)
	echo "$cout $s_col2 $s_col3 $s_col4" >> $out

	cout=15
	s_col2=0
	s_col3=0
	s_col4=0
	cant=0
	echo $out "generated"

done < "$ubicacionFiles"	





