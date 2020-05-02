	#!/usr/bin/env  sh
	if [[ "$1#" == "#" ]]; then
		echo "cui + 关键词 "
		echo "cui + h//获取已知字段"
		exit 0
	fi
	result=`awk '/^\['"$1"'\]/{i=1;next}/^\[/{i=0}i' <(eval cat $note)`
	if [[ $result =~ "cmd:" ]]; then
		result=`echo $result |head -1`
		eval ${result##*:}
	else
		echo $result
	fi
	first=$1
	#echo $1|wc -L
	#echo $([  ] && echo "" || echo "")
	if [[ "$1" =~ ["py"|"java"|"work"|"sql"|"go"|"sh"] && "$2" == "" && $(echo $1|wc -L) != "1"  && ${first:0:1} != "-" ]]; then
		eval ls $cuihome/$1/ 2>/dev/null |grep .$1 |sed 's/.'"$1"'//g' 
	elif [[ "$1" =~ ["py"|"java"|"work"|"sql"|"go"|"sh"] && "$2" != "" ]]; then
		 eval cat  $cuihome/$1/$2".$1" 2>/dev/null
	fi
	case $1  in
    h|-h|help|-help) 
		word=`grep   "^\[" <(eval cat $note)  |tr "\n"  ",";echo`
		echo ${word:0:-1}
		;;
	esac
