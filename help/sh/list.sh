A=('B' 'C')

B_1=(1 2)

C_1=('a' 'b')

for index in ${A[@]}; do

	tmp_arr_name=${index}_1[@]

	for  val in ${!tmp_arr_name}; do

		echo $val

	done

done
