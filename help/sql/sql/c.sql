declare
type num_list is varray(31) of varchar2(8);
xz num_list := num_list(100,200,210,220,230,240,250,270,280,290,311,351,371,431,451,471,531,551,571,591,731,771,791,851,871,891,898,931,951,971,991);
begin
  --xz.count
for i in 1..2 loop
truncate table vltdba.pre_merge_cdr_vlt_hm_100;
--dbms_output.put_line('EMPLOYEE_INFO:'||xz(i)||i);
end loop;
end;
