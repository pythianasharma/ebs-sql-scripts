-- Alter session set nls_date_format='DD-MM-YYYY HH24:MI:SS';

select fcp.logfile_name
from apps.fnd_concurrent_processes fcp, apps.fnd_svc_components fsc
where fsc.component_name = 'Workflow Notification Mailer'
and fsc.concurrent_queue_id = fcp.concurrent_queue_id
and fcp.process_status_code = 'A';


select 
sysdate,count(*) total_cnt 
from
apps.wf_notifications
where 
mail_status in ('MAIL') and status = 'OPEN';



select 
COMPONENT_NAME,COMPONENT_STATUS,COMPONENT_TYPE,LAST_UPDATE_DATE,
decode(COMPONENT_TYPE,
'WF_AGENT_LISTENER','Agent Listener container',
'WF_JAVA_AGENT_LISTENER','Listener container',
'WF_DOCUMENT_WEB_SERVICES','Document WebService container',
'WF_MAILER','Workflow Mailer container') Container
from 
apps.fnd_svc_components;


SELECT  
    fcp.logfile_name
FROM    
    fnd_concurrent_processes fcp, fnd_concurrent_queues fcq
WHERE   
    fcp.concurrent_queue_id = fcq.concurrent_queue_id
    AND     fcp.queue_application_id = fcq.application_id
    AND     fcq.manager_type = '0'
    AND     fcp.process_status_code = 'A';


select decode(fcq.concurrent_queue_name,
'WFMLRSVC','Workflow Mailer container',
'WFALSNRSVC','Agent Listener container',
'WFWSSVC','Document WebService container') WF_Container,
fl.meaning status, fcp.node_name,fcp.concurrent_queue_id,
fcp.concurrent_process_id,os_process_id, fcp.logfile_name
from 
  apps.fnd_concurrent_queues fcq,
  apps.fnd_concurrent_processes fcp, apps.fnd_lookups fl
where fcq.concurrent_queue_name in('WFMLRSVC','WFALSNRSVC','WFWSSVC')
  and fcq.concurrent_queue_id=fcp.concurrent_queue_id
  and fcp.process_status_code in ('Z','C','A','R')
  and fl.lookup_type='CP_PROCESS_STATUS_CODE'
  and fl.lookup_code=fcp.process_status_code
  --and fcp.concurrent_queue_id=<alert queue_id> --remove this line if you do not have <alert queue_id>
order by 
  fcp.logfile_name;
