col value format a10
col SHORT_NAME format a25
col NAME format a29
col CONTEXT format a20
set pages 168
set lines 168
select p.profile_option_name SHORT_NAME,
n.user_profile_option_name NAME,
decode(v.level_id,
10001, 'Site',
10002, 'Application',
10003, 'Responsibility',
10004, 'User',
10005, 'Server',
'UnDef') LEVEL_SET,
decode(to_char(v.level_id),
'10001', '',
'10002', app.application_short_name,
'10003', rsp.responsibility_key,
'10005', svr.node_name,
'10006', org.name,
'10004', usr.user_name,
'UnDef') "CONTEXT",
v.profile_option_value VALUE
from fnd_profile_options p,
fnd_profile_option_values v,
fnd_profile_options_tl n,
fnd_user usr,
fnd_application app,
fnd_responsibility rsp,
fnd_nodes svr,
hr_operating_units org
where p.profile_option_id = v.profile_option_id (+)
and p.profile_option_name = n.profile_option_name
and usr.user_id (+) = v.level_value
and rsp.application_id (+) = v.level_value_application_id
and rsp.responsibility_id (+) = v.level_value
and app.application_id (+) = v.level_value
and svr.node_id (+) = v.level_value
AND ORG.ORGANIZATION_ID (+) = V.LEVEL_VALUE
and usr.user_name like ('%MTANIGUCHI%')
AND N.LANGUAGE='US'
order by short_name,CONTEXT;