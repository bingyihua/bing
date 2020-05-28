#termux 设置密码远程登录
# vim $PREFIX/etc/my.cnf 消除mysql乱码
#[mysqld]
#default_storage_engine = INNODB
#character_set_server = utf8
#collation_server=utf8_general_ci
# mysqld 启动，mysql-user mysql;执行ALTER USER 'root'@'localhost'IDENTIFIED BY 'test123';即可
#mysql>update user set host = '%' where user = 'root';#执行更新下面2句可以远程连接mysql
#mysql>flush privileges;
#创建数据库
create database lsydb1 default character set utf8;
 
select * from  (select *from `order` limit 5 )as bb  
	where product  
	in (select aa.product from  (select *from `order` limit 5 )as aa  GROUP BY aa.product having  avg(aa.number) >3)   	
	and  substr(bb.product,1,1)= 'p';
	--mysql limit在子句报错需要as ,substr的下标是从1开始，oracle是0
--oracle  select * from OB_CALL_DATA_LOG where rownum<=10;

SELECT * FROM basic_zdjbxx WHERE suiji IN ( SELECT zdcode FROM basic_h WHERE zdcode != "" )
SELECT * FROM basic_zdjbxx WHERE suiji IN ( SELECT zdcode FROM ( SELECT zdcode FROM basic_h WHERE zdcode != "" ) AS h )
--前面是mysql优化前速度奇慢，后面是优化后

CREATE TABLE `order` (
	  `id` int(4) NOT NULL,
	  `name` varchar(10) DEFAULT NULL,
	  `product` varchar(9) DEFAULT NULL,
	  `number` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `order` VALUES (1, 'A', 'pen', '2');
INSERT INTO `order` VALUES (2, 'B', 'hat', '4');
INSERT INTO `order` VALUES (3, 'C', 'cat', '1');
INSERT INTO `order` VALUES (4, 'D', 'book', '2');
INSERT INTO `order` VALUES (5, 'E', 'pen', '5');

# a)    查询20号部门的所有员工信息：
SELECT * FROM emp WHERE deptno = 20;
# b)    查询奖金（COMM）高于工资（SAL）的员工信息：
SELECT * FROM emp WHERE comm > sal;
# c)    查询奖金高于工资的20%的员工信息:
SELECT * FROM emp WHERE comm > sal*0.2;
# d)    查询10号部门中工种为MANAGER和20号部门中工种为CLERK的员工的信息:
SELECT * FROM emp WHERE (job = 'manager' AND deptno = 10) OR (job = 'clerk' AND deptno = 20);
# e)    查询所有工种不是MANAGER和CLERK，且工资大于或等于2000员工的详细信息：
SELECT * FROM emp WHERE (sal >= 2000) AND (job NOT IN('manager','clerk'));
# f)    查询没有奖金或奖金低于100的员工信息:
SELECT * FROM emp WHERE (comm < 100 ) OR comm IS NULL;
# g)    查询员工工龄大于或等于10年的员工信息:
SELECT * FROM emp WHERE (NOW() - hiredate) >= 10;
/* h)    查询员工信息，要求以首字母大写的方式显示所有员工的姓名: */
SELECT CONCAT(UPPER(SUBSTRING(ename,1,1)),LOWER(SUBSTRING(ename,2,(CHAR_LENGTH(ename)-1))))FROM emp;
#CONCAT（）函数用于将多个字符串连接成一个字符串 相当于oracle的||
#mysql的lower和uppper函数可以将指定字符串转换为小写和大写
SELECT substring('chinese', 3); #mysql注释是# 输出inese 
SELECT substring('chinese', -3); #输出ese
SELECT substring('chinese', 3, 2); #输出in
SELECT substring('chinese', -3, 2); #输出es
SELECT SUBSTR('chinese', 1, LENGTH('chinese')-3) #消除末尾3位数 
SELECT left("chinese",5) 
SELECT RIGHT("chinese",5) 
#时间转换
SELECT DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s');# oracle select to_char(sysdate,'yyyy-MM-dd HH24:mi:ss') from dual;
SELECT STR_TO_DATE('2019-01-20 16:01:45', '%Y-%m-%d %H:%i:%s'); #select to_date('2005-01-01 13:14:20','yyyy-MM-dd HH24:mi:ss') from dual;

--distinct多个字段，当然相同的功能也可用group by 完成
select a,b,c,min(d) d 
from A
group by a,b,c 

/*雇员表EMP 结构如下 雇员编号 EMPNO ,   姓名 ENAME ,工作岗位 JOB ,  管理员编号 MGR ,受雇时间 HIREDATE ,
工资 SAL ,奖金 COMM ,  部门编号 DEPTNO */

