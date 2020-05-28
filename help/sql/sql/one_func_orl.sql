--常见函数
substr(字段,起点,步长)
distinct去重
order by asc(desc)排序
> < (!= or <>) between and
in  操作 not in
like 模糊查询
% 表示零或多个字符
_ 表示一个字符
select * from emp where ename like '%*_%' escape '*'
escape 表示*后面的那个符号不当成特殊字符处理,相当于转义
--大小写控制函数
select lower('Hello World') 转小写, upper('Hello World') 转大写 from dual;
--initcap: 首字母大写
select initcap('hello world') 首字符大写 from dual;
 
--字符控制函数
-- concat: 字符连接函数, 等同于  ||
select concat('Hello',' World') from dual;
--substr:求母串中的某个子串
select substr('Hello World',3) from dual;
select substr('Hello World',3,4) from dual;
--length和lengthb: 字符数和字节数
select length('China') 字符数, lengthb('China') 字节数  from dual;
--instr:在母串中，查找子串的位置
select instr('Hello World','ll') from dual;
--lpad,rpad: 左右填充,将abcd用*填充到10位
select lpad('abcd',10,'*') 左填充, rpad('abcd',10,'*') 右填充 from dual;
--trim: 去掉字符串前后指定的字符
select trim('H' from 'Hello WorldH') from dual;
--replace:字符串替换函数
select replace('Hello Wordl','l','*') from dual;
 
--数字函数
select round(45.926,2) 四舍五入, trunc(45.926,2)  截断 ,mod(1600,300) 求于 from dual;
--ROUND函数
select round(45.923,0) 整数位, round(45.923,-1) 十位,round(45.923,-2) 百位 from dual;
 
--日期函数
--显示当前日期
select sysdate from dual;
--显示时间部分
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;
--显示昨天，今天和明天，加减数字仍未日期
select sysdate-1 昨天, sysdate 今天, sysdate+1 明天 from dual;
--两个日期相减，结果为相差的天数，查询员工信息，显示员工工龄。两个日期不能相加
select empno,ename, sysdate-hiredate 天 from emp;
--查询员工信息，显示员工工龄,分别按照天，星期，月显示
select empno,ename,sysdate-hiredate 天,(sysdate-hiredate)/7 星期, (sysdate-hiredate)/30 月 from emp;
--months_between:两个日期相差的月数
select (sysdate-hiredate)/30 方式一, months_between(sysdate,hiredate) 方式二 from emp;
--add_months:在指定日期上加上若干个月
select add_months(sysdate,1)  下个月, add_months(sysdate,123) "123个月后" from dual
--last_day: 某个日期当月的最后一天
select last_day(sysdate) from dual;
--next_day:下周六
select next_day(sysdate,'星期五') from dual;
--对日期进行四舍五入
select round(sysdate,'MONTH')  月,round(sysdate,'YEAR') from dual;	
--对日期进行截断
select trunc(sysdate,'MONTH')  月,trunc(sysdate,'YEAR') from dual;
--日期格式
select * from emp where hiredate=to_date('1982-01-23','yyyy-mm-dd');
-- 查询当前日期：显示:  2011-09-17 15:12:15今天是星期六
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss"今天是"day') from dual;
--查询员工信息，显示员工的编号，姓名，月薪,要求有货币代码(L)，千位符(,)，小数点(.),
select empno,ename,to_char(sal,'L9,999.99') from emp;
