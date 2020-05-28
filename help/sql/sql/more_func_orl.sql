--通用函数
--nvl(exp1,exp2):当exp1为空时，返回exp2
--nvl2(exp1,exp2,exp3):当exp1为空时，返回exp3；否则返回exp2
select ename,sal*12+nvl2(comm,comm,0) 年收入 from emp;
--NULLIF (expr1, expr2),如果expr1=expr2,返回null;否则,返回expr1
select nullif('abc','abc') from dual;
select nullif('abc','abcaa') from dual;
--COALESCE :找到参数列表中，第一个不为空的值
select ename,comm,sal,COALESCE(comm,sal) from emp;
--给员工涨工资,根据职位涨，总裁涨1000，经理涨600 其他人员涨400
select ename,job,sal 涨前工资, case job when 'PRESIDENT' then sal+1000
                                         when 'MANAGER'   then sal+600
                                         else sal+400
                                 end 涨后工资
from emp;
 
select ename,job,sal 涨前工资, decode(job,'PRESIDENT',sal+1000,
                                            'MANAGER',sal+600,
                                             sal+400) 涨后工资
from emp;

--多行函数
--求员工的工资总和
select sum(sal) from emp;
--求个数
select count(*) from emp;
--求平均工资
select sum(sal)/count(*) 方式一, avg(sal) 方式二 from emp;
--关于空值：组函数会自动滤空
select count(*), count(comm) from emp;
--max和min：求最高工资和最低工资
select max(sal) 最高工资,min(sal) 最低工资 from emp;
--分组数据：求各个部门的平均工资
select deptno,avg(sal) from emp group by deptno;
--group by作用于多列： 按部门，不同的工种，统计平均工资
--group by作用于多列：先按照第一列分组；如果相同，再按照第二列分组
select deptno,job,avg(sal) from emp group by deptno,job;
--：求部门的平均工资大于2000的部门
select deptno,avg(sal) from emp group by deptno having avg(sal)>2000;
--group by的增强
select deptno,job,sum(sal) from emp group by rollup(deptno,job);
--不同的deptno空两行/取消设置
break on deptno skip 2/break on null
