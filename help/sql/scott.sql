/*
Navicat MySQL Data Transfer
Source Server         : lbr_mysql5.6_dbcon
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : company
Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001
Date: 2016-04-06 09:29:32
*/
 
SET FOREIGN_KEY_CHECKS=0;
 
-- ----------------------------
-- Table structure for `bonus`
-- ----------------------------
DROP TABLE IF EXISTS `bonus`;
CREATE TABLE `bonus` (
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `SAL` int(11) DEFAULT NULL,
  `COMM` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
-- ----------------------------
-- Records of bonus
-- ----------------------------
 
-- ----------------------------
-- Table structure for `dept`
-- ----------------------------
DROP TABLE IF EXISTS `dept`;
CREATE TABLE `dept` (
  `DEPTNO` int(2) NOT NULL,
  `DNAME` varchar(14) DEFAULT NULL,
  `LOC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
-- ----------------------------
-- Records of dept
-- ----------------------------
INSERT INTO `dept` VALUES ('10', 'ACCOUNTING', 'NEW YORK');
INSERT INTO `dept` VALUES ('20', 'RESEARCH', 'DALLAS');
INSERT INTO `dept` VALUES ('30', 'SALES', 'CHICAGO');
INSERT INTO `dept` VALUES ('40', 'OPERATIONS', 'BOSTON');
 
-- ----------------------------
-- Table structure for `emp`
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp` (
  `EMPNO` int(4) NOT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `JOB` varchar(9) DEFAULT NULL,
  `MGR` int(4) DEFAULT NULL,
  `HIREDATE` date DEFAULT NULL,
  `SAL` int(7) DEFAULT NULL,
  `COMM` int(7) DEFAULT NULL,
  `DEPTNO` int(2) DEFAULT NULL,
  PRIMARY KEY (`EMPNO`),
  KEY `FK_DEPTNO` (`DEPTNO`),
  CONSTRAINT `FK_DEPTNO` FOREIGN KEY (`DEPTNO`) REFERENCES `dept` (`DEPTNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES ('7369', 'SMITH', 'CLERK', '7902', '1980-12-17', '800', null, '20');
INSERT INTO `emp` VALUES ('7499', 'ALLEN', 'SALESMAN', '7698', '1981-02-20', '1600', '300', '30');
INSERT INTO `emp` VALUES ('7521', 'WARD', 'SALESMAN', '7698', '1981-02-22', '1250', '500', '30');
INSERT INTO `emp` VALUES ('7566', 'JONES', 'MANAGER', '7839', '1981-04-02', '2975', null, '20');
INSERT INTO `emp` VALUES ('7654', 'MARTIN', 'SALESMAN', '7698', '1981-09-28', '1250', '1400', '30');
INSERT INTO `emp` VALUES ('7698', 'BLAKE', 'MANAGER', '7839', '1981-05-01', '2850', null, '30');
INSERT INTO `emp` VALUES ('7782', 'CLARK', 'MANAGER', '7839', '1981-06-09', '2450', null, '10');
INSERT INTO `emp` VALUES ('7788', 'SCOTT', 'ANALYST', '7566', '1987-04-19', '3000', null, '20');
INSERT INTO `emp` VALUES ('7839', 'KING', 'PRESIDENT', null, '1981-11-17', '5000', null, '10');
INSERT INTO `emp` VALUES ('7844', 'TURNER', 'SALESMAN', '7698', '1981-09-08', '1500', '0', '30');
INSERT INTO `emp` VALUES ('7876', 'ADAMS', 'CLERK', '7788', '1987-05-23', '1100', null, '20');
INSERT INTO `emp` VALUES ('7900', 'JAMES', 'CLERK', '7698', '1981-12-03', '950', null, '30');
INSERT INTO `emp` VALUES ('7902', 'FORD', 'ANALYST', '7566', '1981-12-03', '3000', null, '20');
INSERT INTO `emp` VALUES ('7934', 'MILLER', 'CLERK', '7782', '1982-01-23', '1300', null, '10');
 
-- ----------------------------
-- Table structure for `salgrade`
-- ----------------------------
DROP TABLE IF EXISTS `salgrade`;
CREATE TABLE `salgrade` (
  `GRADE` int(11) DEFAULT NULL,
  `LOSAL` int(11) DEFAULT NULL,
  `HISAL` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
-- ----------------------------
-- Records of salgrade
-- ----------------------------
INSERT INTO `salgrade` VALUES ('1', '700', '1200');
INSERT INTO `salgrade` VALUES ('2', '1201', '1400');
INSERT INTO `salgrade` VALUES ('3', '1401', '2000');
INSERT INTO `salgrade` VALUES ('4', '2001', '3000');
INSERT INTO `salgrade` VALUES ('5', '3001', '9999');
 
 
-----------------------题目-----------------
 
 
--92 连表查询
--等值查询
--查询员工信息和部门信息
select * from emp e, dept d where e.deptno = d.deptno;
--查询员工名称和部门名称
select e.ename,d.dname from emp e,dept d where e.deptno=d.deptno;
--查询员工所有信息和部门名称
select e.*,d.dname from emp e,dept d where e.deptno=d.deptno;
--查询工资大于3000的员工的姓名，工资和部门名称
select e.ename, e.sal, d.dname
  from emp e, dept d
 where e.deptno = d.deptno
   and e.sal > 3000;
--非等值查询
--查询员工的工资等级
select *
  from emp e, salgrade s
 where e.sal <= s.hisal
   and e.sal >= s.losal;
--查询SCOTT的工资等级
select e.ename, s.grade
  from emp e, salgrade s
 where e.sal <= s.hisal
   and e.sal >= s.losal
   and e.ename = 'SCOTT';
--外连接
--左外连接
select * from emp e,dept d where e.deptno=d.deptno(+);
--右外连接
select * from emp e,dept d where e.deptno(+)=d.deptno;
--自连接，自己连接自己
--查询员工姓名和员工的经理的姓名
select e1.ename,e2.ename from emp e1,emp e2 where e1.mgr=e2.empno;
--查询员工姓名和员工经理姓名和其经理姓名
select e1.ename, e2.ename, e3.ename
  from emp e1, emp e2, emp e3
 where e1.mgr = e2.empno
   and e2.mgr = e3.empno;
--99 连表查询
--cross join 交叉连接(笛卡尔积)
--查询员工表和部门表信息
select * from emp e cross join dept d;
--natural join 自然连接
--查询员工表和部门表信息
select * from emp natural join dept;
--using
--查询员工姓名和部门编号
select e.ename,deptno from emp e join dept d using(deptno);
--on 自定义连接条件
--查询员工表和部门表的信息
select * from emp e join dept d on e.deptno = d.deptno;
--查询员工姓名和经理姓名
select e1.ename, e2.ename from emp e1 join emp e2 on e1.mgr = e2.empno;
--查询员工姓名和经理姓名和其经理姓名
select e1.ename, e2.ename, e3.ename
  from emp e1
  join emp e2
    on e1.mgr = e2.empno
  join emp e3
    on e2.mgr = e3.empno;
--inner join 内连接
select * from emp e inner join dept d on e.deptno=d.deptno;
--left join 左外连接，以左表为主
select * from emp e left join dept d on e.deptno=d.deptno;
--right join 右外连接，以右表为主
select * from emp e right join dept d on e.deptno=d.deptno;
--full join 全连接，取两个表的所有数据
select *from emp e full join dept d on e.deptno=d.deptno;
--查询员工姓名和部门姓名和其经理姓名和经理的部门名称
select e1.ename, d1.dname, e2.ename, d2.dname
  from emp e1
  left join dept d1
    on e1.deptno = d1.deptno
  left join emp e2
    on e1.mgr = e2.empno
  left join dept d2
    on e2.deptno = d2.deptno;
--单行子查询
--查询工资高于CLARK的员工的信息
select * from emp where sal>(select sal from emp where ename='CLARK');
--查询工资高于平均工资的员工的名字和工资
select ename,sal from emp where sal >(select avg(sal) from emp );
--查询和SCOTT同一部门且比他工资低的员工名字和工资
select ename, sal
  from emp
 where sal < (select sal from emp where ename = 'SCOTT')
   and deptno = (select deptno from emp where ename = 'SCOTT');
--查询工资最高的员工名字和工资。
select ename,sal from emp where sal =(select max(sal) from emp );
--查询职务和SCOTT相同，比SCOTT雇佣时间早的员工信息
select *
  from emp
 where job = (select job from emp where ename = 'SCOTT')
   and hiredate < (select hiredate from emp where ename = 'SCOTT');
--查询工资比SCOTT高或者雇佣时间比SCOTT早的员工的编号和名字
select empno, ename
  from emp
 where sal > (select sal from emp where ename = 'SCOTT')
    or hiredate < (select hiredate from emp where ename = 'SCOTT');
-- 多行子查询 
--查询和SCOTT,SWITH,CLARK在同一个部门的员工信息并不包含SCOTT,SWITH,CLARK;
select *
  from emp
 where deptno in
       (select distinct deptno from emp where ename in ('SCOTT', 'SWITH', 'CLARK'))
   and ename not in ('SCOTT', 'SWITH', 'CLARK');
--查询工资低于任何一个“CLERK”的工资的员工信息。
select * from emp where sal <any(select sal from emp where job='CLERK');
--查询工资比所有的“SALESMAN”都高的员工的编号、名字和工资。
select empno, ename, sal
  from emp
 where sal < all (select sal from emp where job = 'SALESMAN');
--查询部门20中职务同部门10的雇员一样的员工信息。
select * from emp where job in(select job from emp where deptno=10) and deptno=20;
--查询在员工中有哪些人是经理人
select *
  from emp
 where empno in (select distinct mgr
                   from emp
                  where mgr is not null
                     or mgr != '');
--找出部门编号为20的所有员工中收入最高的职员
select * from emp where sal =(select max(sal) from emp where deptno=20) and deptno =20;
--查询每个部门平均薪水的等级
select b.deptno, grade
  from salgrade s, (select deptno, avg(sal) a from emp group by deptno) b
 where s.losal <= b.a
   and s.hisal >= b.a
