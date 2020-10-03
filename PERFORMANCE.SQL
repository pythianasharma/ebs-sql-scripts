select 
sql_plan_line_id, count(1) 
from 
dba_hist_active_sess_history 
where 
sql_id='' 
group by sql_plan_line_id
order by 2 desc
;

select 
* 
from 
dba_hist_active_sess_history 
where 
sql_id=''
and 
sql_plan_line_id='88'
order by sample_time;



select * from dba_hist_sql_plan where sql_id='';

select inst_id,sql_fulltext,sql_id,child_number,executions,parse_calls,loads,invalidations,first_load_time,last_load_time,last_active_time
,buffer_gets,plan_hash_value,child_number,module,action
,sql_profile,sql_patch,sql_plan_baseline
from gv$sql
where sql_id='';


select inst_id,sql_id,child_number,name,position,datatype_string,was_captured,last_captured,value_string
from gv$sql_bind_capture
where sql_id=''
order by child_number,position;


with myq as
(SELECT
sq.snap_id,
sq.SQL_ID
,sq.instance_number
,sq.plan_hash_value
,t.begin_interval_time
,t.end_interval_time
,sq.EXECUTIONS_TOTAL
,sq.executions_delta
,sq.ELAPSED_TIME_TOTAL
,sq.ELAPSED_TIME_delta
,sq.DISK_READS_total
,sq.disk_reads_delta
,sq.BUFFER_GETS_total
,sq.BUFFER_GETS_delta
,sq.ROWS_PROCESSED_total
,sq.ROWS_PROCESSED_delta
,sq.SQL_PROFILE
,round(sq.ELAPSED_TIME_TOTAL/EXECUTIONS_TOTAL/1000000) elt_exec
from
dba_hist_sqlstat sq,
dba_hist_snapshot t
where
sq.sql_id=''
and sq.snap_id=t.snap_id
order by T.Begin_Interval_Time desc)
select
snap_id
,min(begin_interval_time)
,max(end_interval_time)
,instance_number
,sql_id
,EXECUTIONS_TOTAL
,executions_delta
,elt_exec
,PLAN_HASH_VALUE
from myq
group by snap_id,sql_id,EXECUTIONS_TOTAL,executions_delta,elt_exec,PLAN_HASH_VALUE,instance_number
order by 2 desc;


SELECT x.reason,
decode(x.optimizer_mode_cursor,
1,'ALL_ROWS',
2,'FIRST_ROWS',
3,'RULE',
4,'CHOOSE',x.optimizer_mode_cursor) AS optimizer_mode_cursor,
decode(x.optimizer_mode_current,
1,'ALL_ROWS',
2,'FIRST_ROWS',
3,'RULE',
4,'CHOOSE',x.optimizer_mode_current) AS optimizer_mode_current
FROM gv$sql_shared_cursor s,
XMLTable('/ChildNode'
PASSING XMLType(reason)
COLUMNS
reason VARCHAR2(100) PATH '/ChildNode/reason',
optimizer_mode_cursor  NUMBER PATH '/ChildNode/optimizer_mode_cursor',
optimizer_mode_current NUMBER PATH '/ChildNode/optimizer_mode_current'
) x
WHERE s.sql_id = ''
AND s.child_number = 0;
 
