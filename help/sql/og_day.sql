select * from OG_FILE_AUDIT_MONTH t;
select*from og_file_audit where sttl_dt like '20180612%';
-----------------------------------------------------------------
declare
    TYPE arry_num IS VARRAY(10) OF NUMBER; 
    TYPE arry_var IS VARRAY(4) OF VARCHAR2(10);   
     arry_vlt arry_var;
     arry_type arry_num; 
     m number:=1;     
     i varchar2(10);
     num   number;   
begin 
  select to_char(sysdate-1,'yyyymmdd')into i from dual;
   select count(1) into num from og_file_audit where sttl_dt=i  ;
    if  num > 1     then 
    delete from   og_file_audit where sttl_dt=i ;
    execute immediate 'commit';
     end if;
      arry_vlt := arry_var('VLT_HM', 'VLT_VS','VLT_BR'); 
      arry_type := arry_num(1,2,3);       
  for m in 1 .. 3 loop
    insert into og_file_audit  (
    select regexp_replace(og_file_nm ,'VLT_HM_20180611',arry_vlt(m)||'_'||i,1,0,'i'),    
    regexp_replace(sttl_dt ,'20180611',i,1,0,'i'),
    hm_prov_cd£¬
    db_insr_tm£¬
    ttl_rec_count£¬
    ttl_rm_chg£¬
    ttl_vstd_rm_chg£¬
    earlst_call_start_tm£¬
    latst_call_start_tm£¬
    sttl_flag£¬
    business_type£¬
    regexp_replace(og_file_type ,1,arry_type(m),1,0,'i'),
    calling_count£¬
    called_count£¬
    call_transfer_count£¬
    vpmn_calling_count£¬
    vpmn_called_count£¬
    vpmn_call_transfer_count£¬
    vpmn_vstd_rm_chg£¬
    vpmn_hm_rm_chg£¬
    og_file_size£¬
    og_file_trans_start_tm£¬
    og_file_trans_end_tm£¬
    og_trans_start_tm£¬
    og_trans_end_tm
     from  og_file_audit_bak where og_file_nm like '%VLT_HM%' and sttl_dt like '20180611%');
     --dbms_output.put_line(j);
  end loop;
   execute immediate 'commit';
end;
