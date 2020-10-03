SELECT a2.application_name, a1.user_concurrent_program_name,
DECODE (running_type,
'P', 'Program',
'S', 'Request set',
'UNKNOWN'
) "Type",
b2.application_name "Incompatible App",
b1.user_concurrent_program_name "Incompatible_Prog",
DECODE (to_run_type,
'P', 'Program',
'S', 'Request set',
'UNKNOWN'
) incompatible_type
FROM apps.fnd_concurrent_program_serial cps,
apps.fnd_concurrent_programs_tl a1,
apps.fnd_concurrent_programs_tl b1,
apps.fnd_application_tl a2,
apps.fnd_application_tl b2
WHERE a1.application_id = cps.running_application_id
AND a1.concurrent_program_id = cps.running_concurrent_program_id
AND a2.application_id = cps.running_application_id
AND b1.application_id = cps.to_run_application_id
AND b1.concurrent_program_id = cps.to_run_concurrent_program_id
AND b2.application_id = cps.to_run_application_id
AND a1.language = 'US'
AND a2.language = 'US'
AND b1.language = 'US'
AND b2.language = 'US' 
AND a1.user_concurrent_program_name='';