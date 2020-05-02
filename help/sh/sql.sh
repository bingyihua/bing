#!/bin/bash
info(){
	if [[ "$1#" == "#" ]]; then
		echo "cui + 关键词 "
    	echo "cui + h//获取已知字段"
    	exit 0
	fi
}
info $1
case $1 in
	create* )
	sql_m=""
	ddl=${@:1:1}
	create=${ddl%%_*}
	table=${ddl##*_}
	for i in  ${@:2}
	do
		field_name=${i%%_*}
		field_type=${i##*_}
		insert="$field_type "
		sql_insert="$sql_insert, $insert"
		echo $field_type | grep [^0-9] >/dev/null &&  field_type="char (20)" || field_type="int (20)"
		sql=" ${field_name} ${field_type}"
		sql_m="$sql_m, $sql"
	
	done
	echo $create" table "$table" ("${sql_m:2}");"
	#   echo    "insert into " "$table(" ${sql_insert:2}");"
	 ;;
	insert*)
		echo "haha"
		;;
	sql|select)
	    echo "xixi"
		read -p "put sql:" sql;
		echo $sql
		;;
esac  

