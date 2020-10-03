ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS';

select 
    inst_id,count(1) 
from 
    gv$session 
group by inst_id 
order by inst_id;

select 
    * 
from 
    gv$session 
where 
    sid = '796'
    and serial# = '19577'
    and inst_id = '4';


select 
    STATUS,
    OSUSER,
    PROCESS,
    MACHINE,
    PROGRAM,
    MODULE,
    LAST_CALL_ET,
    SQL_ID,
    EVENT,
    TYPE,
    BLOCKING_SESSION_STATUS,
    BLOCKING_SESSION
from 
    gv$session 
where 
    sid = '796'
    and serial# = '19577'
    and inst_id = '4';
    
    
    -- 8t6h5k8ybqd38
    
    
    select num_rows , last_analyzed from dba_tables where table_name='FND_LOOKUP_VALUES';
    
    SELECT /*+ parallel(8) */ COUNT(1) FROM APPLSYS.FND_LOOKUP_VALUES;
    
    
    
SELECT 
    SID,
    SERIAL#,
    INST_ID,
    STATUS,
    OSUSER,
    PROCESS,
    MACHINE,
    PROGRAM,
    MODULE,
    LAST_CALL_ET,
    SQL_ID,
    EVENT,
    TYPE,
    BLOCKING_SESSION_STATUS,
    BLOCKING_SESSION,
    LOGON_TIME,
    SQL_EXEC_START    
FROM 
    GV$SESSION 
WHERE 
    USERNAME='';
    
    
    SELECT inst_id,sql_id,sql_fulltext,SQL_PROFILE,SQL_PLAN_BASELINE,child_number FROM GV$SQL WHERE SQL_ID
    in (
    '0utyhm9g1103w',
'dxdz7jky115np',
'2wwup9r0wr6sm',
'98x5hkpzk731a',
'db7q693rxsta3',
'9ytynckbnsrms',
'8t6h5k8ybqd38',
'3wjd3t7jxr467',
'1m28prxk8zuhn',
'a9x8gf9p3xhqt',
'8t6h5k8ybqd38');
    
    
    select sysdate,sysdate-1/96 from dual;
    
    
    
    
SELECT 
    SID,
    SERIAL#,
    INST_ID,
    STATUS,
    OSUSER,
    --PROCESS,
    MACHINE,
    --PROGRAM,
    --MODULE,
    LAST_CALL_ET,
    SQL_ID,
    EVENT,
    TYPE,
    BLOCKING_SESSION_STATUS,
    BLOCKING_SESSION,
    LOGON_TIME,
    SQL_EXEC_START    
FROM 
    GV$SESSION 
WHERE SQL_ID    
        in (
    '0utyhm9g1103w',
'dxdz7jky115np',
'2wwup9r0wr6sm',
'98x5hkpzk731a',
'db7q693rxsta3',
'9ytynckbnsrms',
'8t6h5k8ybqd38',
'3wjd3t7jxr467',
'1m28prxk8zuhn',
'a9x8gf9p3xhqt',
'8t6h5k8ybqd38');


select dbms_metadata.get_ddl('VIEW','','APPS') from dual;


select ROWS_PROCESSED from v$sql where sql_id in
('9ytynckbnsrms',
'a9x8gf9p3xhqt',
'8t6h5k8ybqd38',
'3wjd3t7jxr467',
'1m28prxk8zuhn');

select owner,object_name,object_type,created,last_ddl_time,status
from dba_objects where object_name like '%' and object_type='VIEW';


select name from v$datafile where file#='218'; -- +PRODDATA/EBSPROD_CBF/DATAFILE/apps_ts_seed.735.951806373 -- 559

select name from v$datafile where file#='559';


select * from dba_tables where tablespace_name='APPS_TS_SEED'; -- 1429677 1438591 1258687


SELECT relative_fno, owner, segment_name, segment_type 
  FROM dba_extents
 WHERE file_id = 218
   AND 102496 BETWEEN block_id AND block_id + blocks - 1
;

