create table og_file_audit_bak as select * from og_file_audit where 1=2;
--建表语句不能使用在语句块，修改删除数据可以
declare

    TYPE arry_num IS VARRAY(10) OF NUMBER; 
    TYPE arry_var IS VARRAY(4) OF VARCHAR2(10);   
     arry_vlt arry_var;
     arry_type arry_num; 
     --m number:=1;     
     i varchar2(10);
     num   number;    
     times varchar2(10):=201804; 
   begin   
    --select count(1) into num1 from user_tables where lower(table_name) ='_bak'; 
   execute immediate 'truncate  table  og_file_audit_bak';
   for n in 0 .. 95 loop              
       insert into og_file_audit_bak (OG_FILE_NM, STTL_DT, HM_PROV_CD, DB_INSR_TM, TTL_REC_COUNT, TTL_RM_CHG, TTL_VSTD_RM_CHG, EARLST_CALL_START_TM, LATST_CALL_START_TM, STTL_FLAG, BUSINESS_TYPE, OG_FILE_TYPE, CALLING_COUNT, CALLED_COUNT, CALL_TRANSFER_COUNT, VPMN_CALLING_COUNT, VPMN_CALLED_COUNT, VPMN_CALL_TRANSFER_COUNT, VPMN_VSTD_RM_CHG, VPMN_HM_RM_CHG, OG_FILE_SIZE, OG_FILE_TRANS_START_TM, OG_FILE_TRANS_END_TM, OG_TRANS_START_TM, OG_TRANS_END_TM)
        values ('VLT_HM_20180611731.'||replace(lpad(n,3),' ','0'), 20180611, 731, to_date('13-03-2018 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, 0, 0, to_date('13-03-2018 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-03-2018 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), '0', 0, '1', 0, 0, 0, 0, 0, 0, 0, 0, 51, null, null, to_date('13-03-2018 18:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('13-03-2018 18:00:00', 'dd-mm-yyyy hh24:mi:ss'));
   end loop;
   execute immediate 'commit';
   update og_file_audit_bak set TTL_REC_COUNT=4,TTL_RM_CHG=300,CALLING_COUNT=3,VPMN_CALLING_COUNT=1,VPMN_HM_RM_CHG=100,OG_FILE_SIZE=1964 where OG_FILE_NM like '%.095';
   execute immediate 'commit';

   select count(1) into num from og_file_audit where substr(sttl_dt,0,6) =times  ;
    if  num > 1     then 
    delete from   og_file_audit where substr(sttl_dt,0,6) =times  ;
    execute immediate 'commit';
     end if;
      arry_vlt := arry_var('VLT_HM', 'VLT_VS','VLT_BR'); 
      arry_type := arry_num(1,2,3); 
      select to_char(last_day(to_date(times,'yyyymm')),'dd')into i  from dual;
      for m in 1 .. 3 loop
     for j in 1 .. i loop     
    insert into og_file_audit  (
    select regexp_replace(og_file_nm ,'VLT_HM_20180611',arry_vlt(m)||'_'||times||replace(lpad(j,2),' ','0'),1,0,'i'),
    --decode(sttl_dt,20180611,times||replace(lpad(j,2),' ','0')),
    regexp_replace(sttl_dt ,'20180611',times||replace(lpad(j,2),' ','0'),1,0,'i'),
    hm_prov_cd，
    db_insr_tm，
    ttl_rec_count，
    ttl_rm_chg，
    ttl_vstd_rm_chg，
    earlst_call_start_tm，
    latst_call_start_tm，
    sttl_flag，
    business_type，
    regexp_replace(og_file_type ,1,arry_type(m),1,0,'i'),
    calling_count，
    called_count，
    call_transfer_count，
    vpmn_calling_count，
    vpmn_called_count，
    vpmn_call_transfer_count，
    vpmn_vstd_rm_chg，
    vpmn_hm_rm_chg，
    og_file_size，
    og_file_trans_start_tm，
    og_file_trans_end_tm，
    og_trans_start_tm，
    og_trans_end_tm
     from  og_file_audit_bak where og_file_nm like '%VLT_HM%' and sttl_dt like '20180611%');
     --dbms_output.put_line(j);
  end loop;
   
  end loop;
   execute immediate 'commit';

end;
select*from og_file_audit_bak;
select*from og_file_audit where sttl_dt like '201402%';
