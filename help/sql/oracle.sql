--oracle 取前10条记录
select * from tbname where rownum < 11;
select * from (select * from tbname order by id desc ) where rownum<=10;
--取前的10条纪录
SELECT a.*
  FROM torderdetail a
  WHERE ROWNUM <= 10
ORDER BY order_date DESC

--取近一个月的每天最后10个订单纪录
SELECT *
  FROM (SELECT a.*,
	ROW_NUMBER () OVER (PARTITION BY TRUNC (order_date) ORDER BY order_date DESC)
	  rn
	  FROM torderdetail a)
 WHERE rn <= 10

--输出一个月的所有天数呢
SELECT TRUNC (SYSDATE, 'MM') + ROWNUM - 1
  FROM DUAL
CONNECT BY ROWNUM <= TO_NUMBER (TO_CHAR (LAST_DAY (SYSDATE), 'dd'))
