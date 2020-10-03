 ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS';

SELECT * FROM (
    SELECT
    f.request_id ,
    pt.user_concurrent_program_name user_conc_program_name,
    f.actual_start_date start_on,
    f.actual_completion_date end_on,
floor(((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)*24*60*60)/3600)
    || ' HOURS ' ||
    floor((((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)
    *24*60*60) -
    floor(((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)
    *24*60*60)/3600)*3600)/60)
    || ' MINUTES ' ||
    round((((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)
    *24*60*60) -
    floor(((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)
    *24*60*60)/3600)*3600 -
    (floor((((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)
    *24*60*60) -
    floor(((nvl(f.actual_completion_date,sysdate)-f.actual_start_date)
    *24*60*60)/3600)*3600)/60)*60) ))
    || ' SECS ' TIME_DIFFERENCE,
    ROUND((F.ACTUAL_COMPLETION_DATE-F.REQUEST_DATE)*24*60*60) as END_TO_END,
    round((f.actual_start_date     -f.request_date)*24*60*60) AS lag_time,
    decode(f.phase_code,'R','Running','C','Completed','P','Pending','I','Inactive',f.phase_code) Phase,
    decode(f.status_code,'R','Normal','C','Normal','X','Terminated','E','ERROR','G','Warning','W','Paused','Q','Standby','D', 'Cancelled', f.status_code) status_code,
    --f.status_code,
    --p.concurrent_program_name concurrent_program_name,
    --F.NUMBER_OF_COPIES,
    f.argument_text params,
    fuv.description requester,
    f.printer,
    f.print_style,
    f.lfile_size,
    f.logfile_name,
    f.ofile_size,
    F.OUTFILE_NAME  /* additional values*/  ,
    round((f.ofile_size/1024/1024),3) ofile_mb_size    
    /**/
    FROM apps.fnd_concurrent_programs p,
    apps.fnd_concurrent_programs_tl pt,
    apps.fnd_concurrent_requests f,
    apps.fnd_user fuv
    WHERE f.concurrent_program_id = p.concurrent_program_id
    AND f.program_application_id = p.application_id
    AND f.concurrent_program_id = pt.concurrent_program_id
    AND F.PROGRAM_APPLICATION_ID = PT.APPLICATION_ID    
    AND f.actual_start_date IS NOT NULL
    AND F.REQUESTED_BY = FUV.USER_ID
    AND UPPER(PT.USER_CONCURRENT_PROGRAM_NAME) LIKE UPPER('Gather Schema%') -- 
    --AND F.PHASE_CODE='R'
    --AND F.STATUS_CODE='E'
    --AND F.REQUEST_ID in ('233840130')
    --AND F.argument_text like '%%'
    --AND PARENT_REQUEST_ID='232060761'
    --AND f.lfile_size > 1134
    --AND FUV.USER_NAME like upper('%%')
    --AND F.ACTUAL_START_DATE > SYSDATE - 5
    ORDER BY  
    F.ACTUAL_START_DATE DESC
    --F.ACTUAL_COMPLETION_DATE-F.ACTUAL_START_DATE DESC
    ) 
    ;



/*
STATUS CODEs
A   Waiting
B   Resuming
C   Normal
D   Cancelled
E   Error
F   Scheduled
G   Warning
H   On Hold
I   Normal
M   No Manager
Q   Standby
R   Normal
S   Suspended
T   Terminating
U   Disabled
W   Paused
X   Terminated
Z   Waiting.
*
