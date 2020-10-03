select 
sysdate,
p.spid,
cr.request_id,
decode(cr.phase_code,'R','Running','C','Completed','P','Pending','I','Inactive',cr.phase_code) Phase,
decode(cr.status_code,'R','Normal','C','Normal','X','Terminated','E','ERROR','G','Warning','W','Paused','Q','Standby','D', 'Cancelled', cr.status_code) status_code,
s.sid,
s.serial#,
s.status,
s.sql_id,
s.sql_exec_start,
s.last_call_et,
s.logon_time,
s.event,
s.machine,
s.program,
s.action,
s.blocking_session_status,
s.module
from
fnd_concurrent_requests cr,
v$session s,
v$process p
where
cr.request_id in ('233229598')
and p.spid=cr.oracle_process_id
and s.paddr=p.addr
order by cr.request_id;

--- RAC

select fcrv.request_id REQUEST,
decode(fcrv.phase_code,'P','Pending','R','Running','I','Inactive','Completed') PHASE,
decode(fcrv.status_code, 'A','Waiting', 'B','Resuming', 'C','Normal', 'F','Scheduled',
'G','Warning', 'H','On Hold', 'I','Normal', 'M','No Manager',
'Q','Standby', 'R','Normal', 'S','Suspended', 'T','Terminating',
'U','Disabled', 'W','Paused', 'X','Terminated',
'Z','Waiting',fcrv.status_code) STATUS,
fcrv.program,
vs.inst_id,
vs.sql_id,
vs.event,
vs.sid,
vs.serial#,
fcrv.requestor,
fcr.oracle_process_id
from apps.fnd_conc_req_summary_v fcrv,
apps.fnd_concurrent_requests fcr,
gv$session vs,
gv$process vp
where fcrv.phase_code = 'R'
and fcrv.request_id = fcr.request_id
and fcr.oracle_process_id = vp.spid
and vs.paddr = vp.addr
and fcrv.request_id='233229598'
order by inst_id;


select 
sysdate,
p.spid,
cr.request_id,
decode(cr.phase_code,'R','Running','C','Completed','P','Pending','I','Inactive',cr.phase_code) Phase,
decode(cr.status_code,'R','Normal','C','Normal','X','Terminated','E','ERROR','G','Warning','W','Paused','Q','Standby','D', 'Cancelled', cr.status_code) status_code,
s.inst_id,
s.sid,
s.serial#,
s.status,
s.sql_id,
s.sql_exec_start,
s.last_call_et,
s.logon_time,
s.event,
s.machine,
s.program,
s.action,
s.blocking_session_status,
s.module
from
fnd_concurrent_requests cr,
gv$session s,
gv$process p
where
cr.request_id in ('228813362')
and p.spid=cr.oracle_process_id
and s.paddr=p.addr
and s.status='ACTIVE'
and type <> 'BACKGROUND'
order by cr.request_id
;



select 
sysdate,
p.spid,
cr.request_id,
decode(cr.phase_code,'R','Running','C','Completed','P','Pending','I','Inactive',cr.phase_code) Phase,
decode(cr.status_code,'R','Normal','C','Normal','X','Terminated','E','ERROR','G','Warning','W','Paused','Q','Standby','D', 'Cancelled', cr.status_code) status_code,
s.inst_id,
s.sid,
s.serial#,
s.status,
s.sql_id,
q.plan_hash_value,
s.sql_exec_start,
s.last_call_et,
s.logon_time,
s.event,
s.machine,
s.program,
s.action,
s.blocking_session_status,
s.module
from
fnd_concurrent_requests cr,
gv$session s,
gv$process p,
gv$sql q
where
cr.request_id in ('228813362')
and p.spid=cr.oracle_process_id
and s.paddr=p.addr
and s.status='ACTIVE'
and type <> 'BACKGROUND'
and s.sql_id=q.sql_id
order by cr.request_id
;


select inst_id,sql_fulltext,sql_id,child_number,executions,parse_calls,loads,invalidations,first_load_time,last_load_time,last_active_time
,buffer_gets,plan_hash_value,child_number,module,action
,sql_profile,sql_patch,sql_plan_baseline
from gv$sql
where sql_id in ('');

select * from gv$session where inst_id=2 and sid='180' and serial#='52332';


select inst_id,sid,serial#,status from gv$session where sql_id='';

select paddr,sysdate,inst_id,sid,serial#,status,machine,program,sql_id,sql_exec_start,last_call_et,logon_time,
event,action,module,blocking_session_status,blocking_session,final_blocking_instance,final_blocking_session,final_blocking_session_status
module from gv$session where inst_id=1 and sid='3182' and serial#='6634';

select * from gv$process where addr='00000008B0F81258';

alter system kill session '1064, 14962' immediate;



/*


select oracle_process_id from apps.fnd_concurrent_requests where request_id='213478495';

select * from apps.fnd_concurrent_requests where oracle_process_id='51142' ;order by request_start_date desc;

select inst_id,addr from gv$process where spid='51142';

select * from gv$process where addr='0000000A3892EFF0';

select * from gv$session where inst_id=1 and paddr='0000000A50A0B848';

select sysdate,inst_id,sid,serial#,status,machine,program,sql_id,sql_exec_start,last_call_et,logon_time,
event,action,blocking_session_status,module from gv$session where inst_id=1 and paddr='0000000A50A0B848';

-- e:SQLGL:cp:xla/XLAREPSEQ
-- 3tvbcfdddp5fh


select * from gv$sql where sql_id='';

select paddr,sysdate,inst_id,sid,serial#,status,machine,program,sql_id,sql_exec_start,last_call_et,logon_time,
event,action,blocking_session_status,module from gv$session where program like 'MSCNPL64%'; --='e:MSC:cp:msc/MSCNSPWL64';



select sysdate,status,last_call_et,sql_id,sql_exec_start,logon_time,
event,action,blocking_session_status,module from gv$session where program like 'MSCNPL64%'; 

select inst_id,sql_fulltext,sql_id,child_number,executions,parse_calls,loads,invalidations,first_load_time,last_load_time,last_active_time
,buffer_gets,plan_hash_value,child_number,module,action
,sql_profile,sql_patch,sql_plan_baseline
from gv$sql
where sql_id='';


select * from dba_objects where object_name like '%XXMFG_EPLM_EBS_BOM_INTERFACE%';


select module,sql_fulltext from gv$sql where  sql_id='';


select dbms_metadata.get_ddl('PACKAGE','XXMFG_EPLM_EBS_BOM_INTERFACE','APPS')
from dual;

select inst_id,executions,buffer_gets,sql_id,plan_hash_value,module,action,sql_profile,sql_plan_baseline from gv$sql where sql_id='';

-- SYS_SQLPROF_0165b08b88cf0000
-- select * from table(dbms_xplan.display_cursor('f1ztpxgjbs5p2',0));


select  sql_id,LAST_ACTIVE_TIME,executions
,PLAN_HASH_VALUE
--,DISK_READS
--,DIRECT_WRITES
,BUFFER_GETS
,ROWS_PROCESSED
,USER_IO_WAIT_TIME/1000000
,CPU_TIME/1000000
,ELAPSED_TIME/executions/1000000 elt_exec from gv$sqlstats where sql_id='';




select oracle_process_id from apps.fnd_concurrent_requests where request_id='208609255';

select inst_id,addr from gv$process where spid='45776';

select * from gv$session where inst_id=2 and paddr='0000000890EBAFE8';

select sysdate,inst_id,sid,serial#,status,machine,program,sql_id,sql_exec_start,last_call_et,logon_time,
event,action,blocking_session_status,module from gv$session where inst_id=2 and paddr='0000000890EBAFE8';

/*
select
fcr.oracle_process_id,
p.inst_id,
p.addr,
s.sid,
s.serial#,
s.status,
s.sql_id,
s.sql_exec_start,
s.last_call_et,
s.machine,
s.program,
s.action,
s.module
from 
apps.fnd_concurrent_requests fcr,
gv$session s,
gv$process p
where 
fcr.request_id='228813263'
and p.spid=fcr.oracle_process_id
and p.addr=s.paddr
and s.status='ACTIVE'
*/

-- e:SQLGL:cp:xla/XLAREPSEQ
-- 3tvbcfdddp5fh


select * from gv$sql where sql_id='';

select inst_id,sql_fulltext,sql_id,child_number,executions,parse_calls,loads,invalidations,first_load_time,last_load_time,last_active_time
,buffer_gets,plan_hash_value,child_number,module,action
,sql_profile,sql_patch,sql_plan_baseline
from gv$sql
where sql_id='';


select * from dba_objects where object_name like '%XXMFG_EPLM_EBS_BOM_INTERFACE%';


select module,sql_fulltext from gv$sql where  sql_id='';


select dbms_metadata.get_ddl('PACKAGE','XXMFG_EPLM_EBS_BOM_INTERFACE','APPS')
from dual;

select inst_id,executions,buffer_gets,sql_id,plan_hash_value,module,action,sql_profile,sql_plan_baseline from gv$sql where sql_id='';

-- SYS_SQLPROF_0165b08b88cf0000
-- select * from table(dbms_xplan.display_cursor('',0));


select
inst_id,
sql_id,
LAST_ACTIVE_TIME,
executions
,PLAN_HASH_VALUE
--,DISK_READS
--,DIRECT_WRITES
,BUFFER_GETS
,ROWS_PROCESSED
,USER_IO_WAIT_TIME/1000000
,CPU_TIME/1000000
,ELAPSED_TIME/executions/1000000 elt_per_exec 
from 
gv$sqlstats 
where 
sql_id=''
and executions > 0
and inst_id=1
;
