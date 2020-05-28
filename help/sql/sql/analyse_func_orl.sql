--分析函数 https://www.cnblogs.com/cjm123/p/8033892.html
--普通的聚合函数用group by分组，每个分组返回一个统计值，而分析函数采用partition by分组，并且每组每行都可以返回一个统计值。
--分析函数带有一个开窗函数over()，包含三个分析子句:分组(partition by), 排序(order by), 窗口(rows) ，
--他们的使用形式如下：over(partition by xxx order by yyy rows between zzz)。

--显示各部门员工的工资，并附带显示该部分的最高工资。
SELECT E.DEPTNO,
       E.EMPNO,
       E.ENAME,
       E.SAL,
       LAST_VALUE(E.SAL) 
       OVER(PARTITION BY E.DEPTNO 
            ORDER BY E.SAL ROWS 
            --unbounded preceding and unbouned following针对当前所有记录的前一条、后一条记录，也就是表中的所有记录
            --unbounded：不受控制的，无限的
            --preceding：在...之前
            --following：在...之后
            BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) MAX_SAL
  FROM EMP E;

--按照deptno分组，然后计算每组值的总和
SELECT EMPNO,
       ENAME,
       DEPTNO,
       SAL,
       SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY ENAME) max_sal
  FROM SCOTT.EMP;

--对各部门进行分组，并附带显示第一行至当前行的汇总
SELECT EMPNO,
       ENAME,
       DEPTNO,
       SAL,
       --注意ROWS BETWEEN unbounded preceding AND current row  是指第一行至当前行的汇总
       SUM(SAL) OVER(PARTITION BY DEPTNO 
                     ORDER BY ENAME 
                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max_sal
  FROM SCOTT.EMP;

--当前行至最后一行的汇总
SELECT EMPNO,
       ENAME,
       DEPTNO,
       SAL,
       --注意ROWS BETWEEN current row AND unbounded following 指当前行到最后一行的汇总
       SUM(SAL) OVER(PARTITION BY DEPTNO 
                     ORDER BY ENAME 
                     ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) max_sal
  FROM SCOTT.EMP;
