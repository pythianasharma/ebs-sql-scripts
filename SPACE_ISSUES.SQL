SELECT
    *
FROM
    dba_tablespace_usage_metrics
WHERE
    tablespace_name = 'APPS_TS_TX_IDX';
    
    
    
SELECT
    group_number,
    name,
    state,
    type,
    free_mb / 2024,
    ( ( total_mb - free_mb ) / total_mb ) * 100 "%_used"
FROM
    v$asm_diskgroup;
    
    

WITH s AS (
    SELECT
        trunc(end_interval_time) dat,
        MIN(snap_id) min_snap_id,
        MAX(snap_id) max_snap_id
    FROM
        dba_hist_snapshot s
    WHERE
        end_interval_time > SYSDATE - 9
    GROUP BY
        trunc(end_interval_time)
)
SELECT
    s.dat,
    ts#,
    round(SUM(space_used_delta) / 1024 / 1024 / 1024, 2) grow_gb
FROM
    dba_hist_seg_stat ss,
    s
WHERE
    ts# = 433
    AND ss.snap_id BETWEEN s.min_snap_id AND s.max_snap_id
GROUP BY
    s.dat,
    ts#
ORDER BY
    1;
    
    
    
    
WITH ts_size
     AS (SELECT ts.name
                AS
                ts_name,
                To_number(Substr(( systimestamp - s.end_interval_time ), 1,
                          Instr(
                                    systimestamp - s.end_interval_time, ' ')))
                AS
                   days_ago,
                tablespace_size / 1024 / 1024
                used_gigs
         FROM   dba_hist_snapshot s,
                dba_hist_tbspc_space_usage dhtu,
                v$tablespace ts
         WHERE  dhtu.tablespace_id = ts.ts#
                AND dhtu.snap_id = s.snap_id
                AND s.instance_number = 1
                AND s.end_interval_time > SYSDATE - 5
                AND s.dbid = (SELECT dbid
                              FROM   v$database))
SELECT ts_name,
       Regr_slope(used_gigs, days_ago) *- 1 gigs_per_day,
       Regr_r2(used_gigs, days_ago) *- 1    r_squared
FROM   ts_size
GROUP  BY ts_name
ORDER  BY 2 DESC;
    

SELECT
    file_name,
    round(bytes / 1024 / 1024) AS b_mb,
    round(maxbytes / 1024 / 1024) AS max_mb,
    user_bytes / 1024 / 1024 u_mb,
    autoextensible,
    increment_by
FROM
    dba_data_files
WHERE
    tablespace_name = 'XX_DW2_DATA'
ORDER BY
    u_mb DESC;
    

select
  fs.tablespace_name                          "Tablespace",
  (df.totalspace - fs.freespace)              "Used GB",
  fs.freespace                                "Free GB",
  df.totalspace                               "Total GB",
  round(100 * (fs.freespace / df.totalspace)) "Pct. Free"
from
  (select
     tablespace_name,
     round(sum(bytes) / (1024*1048576)) TotalSpace
  from
     dba_data_files
  group by
     tablespace_name
  ) df,
  (select
     tablespace_name,
     round(sum(bytes) / (1024*1048576)) FreeSpace
  from
     dba_free_space
  group by
     tablespace_name
  ) fs
WHERE
  DF.TABLESPACE_NAME = FS.TABLESPACE_NAME
  and df.tablespace_name like 'XXRPT_TEMP'
 order by 1 ;


