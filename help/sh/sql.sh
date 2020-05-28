#!/bin/bash
start_db(){
        PIDS=`ps -ef |grep mysql |grep -v grep | awk '{print $2}'`
        if [ "$PIDS" != "" ]; then
                echo -n ""
				rm nohup.out
        else
                nohup mysqld &
                echo  "mysql is start"
                sleep 1s
				rm nohup.out
        fi
}
info(){
	if [[ "$1#" == "#" ]]; then
		echo “#########################################################”
		echo "#输入sqls  creat_mytabel  id_2 name_cui"
		echo "#即可创建一个表名为mytable，有2列(id(int)和name(varchar))"
		echo "#sqls  insert_mytabel 1  cui #插数据"
		echo "#sqls  delete_mytabel  #删表数据"
		echo "#sqls  sql   #输入原生sql执行"
		echo “#########################################################”
		start_db
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
		echo $field_type | grep [^0-9] >/dev/null &&  field_type="varchar (20)" || field_type="int (20)"
		sql=" ${field_name} ${field_type}"
		sql_m="$sql_m, $sql"
	
	done
	sql=$create" table "$table" ("${sql_m:2}");" 
	echo $sql" 开始建表"
	tab=`echo  "select TABLE_NAME from information_schema.TABLES where TABLE_NAME = '$table';" |mysql -uroot -ptest123 test`
	if [[ tab != ""  ]]; then
		echo "$table 已存在"
	else
		echo $sql|mysql -uroot -ptest123 test
		echo "$table 已创建成功"
	fi
	 ;;
	insert*)
		ddl=${@:1:1}
		inst=${ddl%%_*}
		table=${ddl##*_}
		for i in  ${@:2}
		do
			echo $i | grep [^0-9] >/dev/null &&  i="'"$i"'" || i=$i 
			sql_insert="$sql_insert, $i"
		done
		echo    "insert into " "$table values(" ${sql_insert:2}");"|mysql -uroot -ptest123 test
		;;
	delete*)
		ddl=${@:1:1}
		table=${ddl##*_}
		echo "truncate table ${table};"|mysql -uroot -ptest123 test
		echo "delete table $table Success!"
		;;
	drop*)
		ddl=${@:1:1}
		table=${ddl##*_}
		echo "drop table ${table};"|mysql -uroot -ptest123 test
		echo "drop table $table Success!"
		;;
	sql|select)
		read -p "put sql:" sql;
		echo $sql |mysql -uroot -ptest123 test
		;;
esac  
