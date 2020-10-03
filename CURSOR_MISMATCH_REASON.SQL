SELECT 
s.sql_id,
s.child_number,
x.reason,
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
--AND s.child_number = 1
;


select * from
  (select sql_id, count(child_number)
     from gv$sql_shared_cursor
    group by sql_id
    order by count(child_number) desc)
--where rownum <=5
;


set serveroutput on

DECLARE
 v_count number;
 v_sql varchar2(500);
 v_sql_id varchar2(30) := '&sql_id';
BEGIN
 v_sql_id := lower(v_sql_id);
 dbms_output.put_line(chr(13)||chr(10));
 dbms_output.put_line('sql_id: '||v_sql_id);
 dbms_output.put_line('------------------------');
 FOR c1 in
   (select column_name
      from dba_tab_columns
     where table_name ='V_$SQL_SHARED_CURSOR'
       and column_name not in ('SQL_ID', 'ADDRESS', 'CHILD_ADDRESS', 'CHILD_NUMBER', 'REASON', 'CON_ID')
     order by column_id)
 LOOP
   v_sql := 'select count(*) from V_$SQL_SHARED_CURSOR
             where sql_id='||''''||v_sql_id||''''||'
             and '||c1.column_name||'='||''''||'Y'||'''';
   execute immediate v_sql into v_count;
   IF v_count > 0
   THEN
     dbms_output.put_line(' - '||rpad(c1.column_name,30)||' count: '||v_count);
   END IF;
 END LOOP;
END;
/
