#!/usr/bin/env  sh
info(){
	#if [[ "$1#" == "#" ]]; then
		echo "cui + 关键词 "
		echo "cui + [sh|cmd|java|go|sql|py] 获取指定列表!"
		echo "例如输入：cui cmd cut 获取cut的相关笔记内容! "
		exit 0
	#fi
}
case $1  in
	h|-h|help|-help|"")
		info
	;;
esac

if [[ "$1" == "cmd" && "$2" == "" ]]; then
	list=`grep   "^\[" <(eval cat  $cuihome/sh/ops_note.sh)  |tr "\n"  ",";echo`
	echo ${list:0:-1}
elif [[ "$1" == "cmd" && "$2" != "" ]]; then
	 result=`awk '/^\['"$2"'\]/{i=1;next}/^\[/{i=0}i' <(eval cat  $cuihome/sh/ops_note.sh)`
	 if [[ $result =~ "cmd:" ]]; then
		 result=`echo $result |head -1`
		 `eval echo  ${result##*:}`
	 else
	 	awk '/^\['"$2"'\]/{i=1;next}/^\[/{i=0}i' <(eval cat  $cuihome/sh/ops_note.sh)
	 fi
fi

first=$1
	#echo $1|wc -L
	#echo $([  ] && echo "" || echo "")
if [[ "$1" =~ ["py"|"java"|"work"|"sql"|"go"|"sh"] && "$2" == "" && $(echo $1|wc -L) != "1"  && ${first:0:1} != "-" ]]; then
	eval ls $cuihome/$1/ 2>/dev/null |grep .$1 |sed 's/.'"$1"'//g' 
elif [[ "$1" =~ ["py"|"java"|"work"|"sql"|"go"|"sh"] && "$2" != "" ]]; then
	eval cat  $cuihome/$1/$2".$1" 2>/dev/null
fi
