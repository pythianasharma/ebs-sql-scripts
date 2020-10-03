-- SQL to check which CM ran the request
SELECT
    c.request_id,
    b.user_concurrent_queue_name
FROM
    fnd_concurrent_processes a,
    fnd_concurrent_queues_vl b,
    fnd_concurrent_requests c
WHERE
    a.concurrent_queue_id = b.concurrent_queue_id
    AND a.concurrent_process_id = c.controlling_manager
    AND c.request_id IN ('231323884')
    ;
    
-- SQL to find ICM log file location

SELECT  
    fcp.logfile_name
FROM    
    fnd_concurrent_processes fcp, fnd_concurrent_queues fcq
WHERE   
    fcp.concurrent_queue_id = fcq.concurrent_queue_id
    AND     fcp.queue_application_id = fcq.application_id
    AND     fcq.manager_type = '0'
    AND     fcp.process_status_code = 'A';
    

-- SQL to find responsibilities assigned to a user

select 
    fu.user_name, 
    fr.responsibility_name, 
    furg.START_DATE, 
    furg.END_DATE
from 
    fnd_user_resp_groups_direct furg, 
    fnd_user fu, 
    fnd_responsibility_tl fr
where 
    fu.user_name = upper('MTANIGUCHI') 
    and furg.user_id = fu.user_id 
    and furg.responsibility_id = fr.responsibility_id 
    and fr.language = userenv('LANG');
    

-- SQL to find Concurrent Program executable Information

SELECT DISTINCT fcpl.user_concurrent_program_name "Concurrent Program Name",
  fcp.concurrent_program_name "Short Name"                                 ,
  fat.application_name                                                     ,
  fl.meaning execution_method                                              ,
  fe.execution_file_name                                                   ,
  fcp.output_file_type                                                     ,
  fdfcuv.column_seq_num "Column Seq Number"                                ,
  fdfcuv.end_user_column_name "Parameter Name"                             ,
  fdfcuv.form_left_prompt "Prompt"                                         ,
  fdfcuv.enabled_flag " Enabled Flag"                                      ,
  fdfcuv.required_flag "Required Flag"                                     ,
  fdfcuv.display_flag "Display Flag"                                       ,
  fdfcuv.flex_value_set_id "Value Set Id"                                  ,
  ffvs.flex_value_set_name "Value Set Name"                                ,
  flv.meaning "Default Type"                                               ,
  fdfcuv.default_value "Default Value"
   FROM fnd_concurrent_programs fcp ,
  fnd_concurrent_programs_tl fcpl   ,
  fnd_descr_flex_col_usage_vl fdfcuv,
  fnd_flex_value_sets ffvs          ,
  fnd_lookup_values flv             ,
  fnd_lookups fl                    ,
  fnd_executables fe                ,
  fnd_executables_tl fet            ,
  fnd_application_tl fat
  WHERE 1                     = 1
AND fcp.concurrent_program_id = fcpl.concurrent_program_id
AND fcp.enabled_flag          = 'Y'
AND fcpl.user_concurrent_program_name LIKE '' --<Your Concurrent Program Name>
AND fdfcuv.descriptive_flexfield_name = '$SRS$.'
  || fcp.concurrent_program_name
AND ffvs.flex_value_set_id = fdfcuv.flex_value_set_id
AND flv.lookup_type(+)     = 'FLEX_DEFAULT_TYPE'
AND flv.lookup_code(+)     = fdfcuv.default_type
AND fcpl.LANGUAGE          = 'US'
AND flv.LANGUAGE(+)        = 'US'
AND fl.lookup_type         ='CP_EXECUTION_METHOD_CODE'
AND fl.lookup_code         =fcp.execution_method_code
AND fe.executable_id       = fcp.executable_id
AND fe.executable_id       =fet.executable_id
AND fet.LANGUAGE           = 'US'
AND fat.application_id     =fcp.application_id
AND fat.LANGUAGE           = 'US'
ORDER BY fdfcuv.column_seq_num;
