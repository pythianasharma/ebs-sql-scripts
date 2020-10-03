Select User_Concurrent_Queue_Name Manager, Q.Target_Node Node, Os_Process_ID
from apps.fnd_concurrent_queues_vl Q,apps.Fnd_Concurrent_Processes P
where Q.Application_Id = Queue_Application_ID
And (Q.Concurrent_Queue_ID = P.Concurrent_Queue_ID);

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
and fcrv.request_id='177282949'
order by inst_id;

-- select * from apps.fnd_conc_req_summary_v;

select owner,table_name,tablespace_name,status,ini_trans,num_rows,degree,last_analyzed from dba_tables where table_name
in
(
'',
'',
'',
'',
''
);

select * from dba_tables where table_name='';


select * from dba_indexes where index_name='';

select inst_id,sql_id,child_number,plan_hash_value,executions,sql_profile,sql_plan_baseline from gv$sql where sql_id='';


select * from gv$sql where sql_id='';

select ADDRESS, HASH_VALUE from GV$SQL where sql_id = '';

select ADDRESS, HASH_VALUE from GV$SQL where hash_value = '';

