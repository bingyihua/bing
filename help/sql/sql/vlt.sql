 declare
   num int;
   i   int;
   a   int;
   c   char(10) := 'aaaa';
 begin
   if c = 'aaaa' then
     update mcbdba.dom_num_prefix a
        set a.effc_tm = sysdate + 3/(24*60), a.expired_tm = sysdate + 5
      where a.num_prefix = substr(&num, 0, 3);
     commit;
   end if;
 
   select t.carrier_type
     into num
     from mcbdba.dom_num_prefix t
    where t.num_prefix = substr(&num, 0, 3);
   if num = 0 then
     dbms_output.put_line('无效的号码前缀');
   elsif num = 1 then
     if c = 'aaaa' then
       update mcbdba.imsi_ld_cd a
          set a.effc_tm = sysdate + 3/(24*60), a.expired_tm = sysdate + 5
        where a.msisdn_area_id = &num;
       commit;
       update mcbdba.dom_ld_area_cd_prov b
          set b.effc_tm = sysdate + 3/(24*60), b.expired_tm = sysdate + 5
        where b.LD_AREA_CD =
              (select a.LD_AREA_CD
                 from mcbdba.imsi_ld_cd a
                where a.msisdn_area_id = &num);
        commit;
     end if;
     select count(*)
       into i
       FROM mcbdba.imsi_ld_cd T1, mcbdba.dom_ld_area_cd_prov T3
      WHERE T1.ld_area_cd = T3.ld_area_cd
        and t1.msisdn_area_id = '&num'
        and t1.effc_tm < sysdate
        and t1.expired_tm > (sysdate)
        and t3.effc_tm < sysdate
        and t3.expired_tm > (sysdate);
     if i >= 1 then
       dbms_output.put_line('有效的移动号码');
     else
       dbms_output.put_line('无效的移动号码');
     
     end if;
   
   ELSE
   
     if c = 'aaaa' then
     
       update mcbdba.unicom_msisdn_ld_cd a
          set a.effc_tm = sysdate + 3/(24*60), a.expired_tm = sysdate + 5
        where a.msisdn_area_id = &num;
       commit;
       update mcbdba.dom_ld_area_cd_prov b
          set b.effc_tm = sysdate + 3/(24*60), b.expired_tm = sysdate + 5
        where b.LD_AREA_CD =
              (select a.LD_AREA_CD
                 from mcbdba.unicom_msisdn_ld_cd a
                where a.msisdn_area_id = &num);
       commit;
     end if;
     select count(*)
       into a
       FROM mcbdba.unicom_msisdn_ld_cd T1, mcbdba.dom_ld_area_cd_prov T3
      WHERE T1.ld_area_cd = T3.ld_area_cd
        and t1.msisdn_area_id = '&num'
        and t1.effc_tm < sysdate
        and t1.expired_tm > (sysdate)
        and t3.effc_tm < sysdate
        and t3.expired_tm > (sysdate);
     if a >= 1 then
       dbms_output.put_line(c || '有效的联通号码');
     else
       dbms_output.put_line(a || '无效的联通号码');
     
     end if;
   END if;
 end;
 
 -----------------------------------------------------------------------
 
 update mcbdba.br_msc_cover_area_cd
   set effc_tm   =
       (sysdate + 3/(24*60)),
       expired_tm =
       (sysdate + 5)
 where CELL_ID in
       (select substr(SBC_ANI, 42, 7)
          from vltdba.pre_merge_cdr_vlt_br t
         where t.ic_file_nm =
               'VLTCG01_LNVOLTEAS01_H_110101_20170616114649_00001131.dat');
 
 
 --------查询------------- 
 select *
     from mcbdba.dom_num_prefix t
    where t.num_prefix = substr(&num, 0, 3);

SELECT T1.msisdn_area_id,
       T3.prov_cd,
       T1.ld_area_cd,
       T1.effc_tm,
       T1.expired_tm,
       T3.effc_tm,
       T3.expired_tm
  FROM mcbdba.imsi_ld_cd T1, mcbdba.dom_ld_area_cd_prov T3
 WHERE T1.ld_area_cd = T3.ld_area_cd
   and t1.msisdn_area_id = '&num'
 
 select
 T1.msisdn_area_id,
       T3.prov_cd,
       T1.ld_area_cd,
       T1.effc_tm,
       T1.expired_tm,
       T3.effc_tm,
       T3.expired_tm
       FROM mcbdba.unicom_msisdn_ld_cd T1, mcbdba.dom_ld_area_cd_prov T3
      WHERE T1.ld_area_cd = T3.ld_area_cd
        and t1.msisdn_area_id = '1324454'
        and t1.effc_tm < sysdate
        and t1.expired_tm > (sysdate-6)
        and t3.effc_tm < sysdate
        and t3.expired_tm > (sysdate-6);
        
        select  sysdate-5 from dual;
        select * from FILE_PROCESS_STATE where file_nm='VLTCG01_LNVOLTEAS01_H_110101_20170616114649_00001131.dat';
        select* from pre_merge_cdr_vlt_hm_571 where ic_file_nm='VLTCG01_LNVOLTEAS01_H_110101_20170616114649_00001131.dat';
