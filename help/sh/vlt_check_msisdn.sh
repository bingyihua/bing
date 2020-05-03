
num=$1
#获取一条号码前缀表的一条有些公参并赋值给变量
aa=$(grep -w "${num:0:3}" dom_num_prefix.csv | awk -F"," '{split($5,a,"[\"/]");split($6,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");d=mktime(""b[2]" "b[3]" "b[4]" 00 00 00")}c<systime()&&d>systime()'|head -1)

#获取有效公参个数判断号码前缀是否存在有些数据
aa_num=$(grep -w "${num:0:3}" dom_num_prefix.csv | awk -F"," '{split($5,a,"[\"/]");split($6,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");d=mktime(""b[2]" "b[3]" "b[4]" 00 00 00")} c<systime() && d>systime()'|wc -l)

if [[ $aa_num > 0 ]]; then
	
	#根据号码前缀判断是为移动号码 
	if [[ $(echo $aa|awk -F"," '{print $2}') != "\"1\"" ]];then

		#由于awk性能太慢抛弃在awk使用条件，改用最快的grep，速度grep > sed > awk
		#awk -F"," '{split($5,a,"[\"/]");split($6,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");\
		#d=mktime(""b[2]" "b[3]" "b[4]" 00 00 00")}   c<systime()&&  d>systime()  &&  $2 == "\"1346639\""' imsi_ld_cd.csv 
		

		#在移动号码表查询有效数据并获取长途区号赋值给数组变量（有可能是多条）
		lt=$(grep ${num:0:7}  unicom_msisdn_ld_cd.csv|awk -F"," '{split($3,a,"[\"/]");split($4,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");d=mktime(""b[2]" "b[3]" "b[4]" 00 00 00")} c<systime() &&  d>systime()'|awk -F"," '{print $1}')
		
		#如果为空就报错，不为空就继续
		if [[ $lt == "" ]];then echo "unicom_msisdn is false";
		else 
			d=($lt)
			jgm=0			                       
			for i in ${d[@]} 
			do
				
				
				#遍历数组元素 传给长途区号表进行有效数据记录数的判断
				jg=$(grep -w $i dom_ld_area_cd_prov.csv |awk -F"," '{split($4,a,"[\"/]");split($5,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");d=mktime(""b[2]" "b[3]" "b[4]" "b[5]" "b[6]" "b[7]"")} c<systime() &&  d>systime()'|wc -l)
				
				#如果存在==1，说明号码有效
	                        if [[  $(echo $jg|grep 1|wc -l) == 1 ]];then jgm=1;fi
			done
			if [[ $jgm == 0 ]]; then echo "wuxiao changtu quhao";else echo "ok  liantong_num";fi
		
		fi
	else
		#联通号码判断和移动号码逻辑一致，不再注释
		yd=$(grep ${num:0:7}  imsi_ld_cd.csv|awk -F"," '{split($5,a,"[\"/]");split($6,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");d=mktime(""b[2]" "b[3]" "b[4]" 00 00 00")} c<systime() &&  d>systime()'|awk -F"," '{print $3}')
		if [[ $yd == "" ]];then echo "yidong_msisdn is false";
		else 
			d=($yd)
			jgm=0
			for i in ${d[@]} ;
			
			do
				echo  $i
				jg=$(grep -w $i dom_ld_area_cd_prov.csv |awk -F"," '{split($4,a,"[\"/]");split($5,b,"[\"/ :]");c=mktime(""a[2]" "a[3]" "a[4]" 00 00 00");d=mktime(""b[2]" "b[3]" "b[4]" 00 00 00")} c<systime() &&  d>systime()'|wc -l)
				if [[  $(echo $jg|grep 1|wc -l) == 1 ]];then jgm=1;fi

			done
			if [[ $jgm == 0 ]]; then echo "wuxiao changtu quhao";else echo "ok  yidong_num";fi
		fi
	fi
	
else
	echo "无效的号码前缀"

	echo $aa
fi

