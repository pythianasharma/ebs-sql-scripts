/*
From Concurrent Program name to Module
The program column will give an idea of the module.
The module will be somewhat like 'e:INV:cp:inv/INCOIN'
*/
SELECT   SUBSTR(a.application_name,1,60) Application_NAME
,        b.application_short_name SHORT_NAME
,        DECODE(SUBSTR(cp.user_concurrent_program_name,4,1),':'
         ,      'Concurrent Manager Executable'
         ,      'Subprogram or Function') TYPE
,        d.concurrent_program_name PROGRAM 
,        SUBSTR(cp.user_concurrent_program_name,1,55) USER_PROGRAM_NAME
FROM     applsys.FND_CONCURRENT_PROGRAMS_TL cp, applsys.FND_CONCURRENT_PROGRAMS d, applsys.FND_APPLICATION_TL a, applsys.fnd_application b
WHERE    cp.application_id = a.application_id
AND      d.CONCURRENT_PROGRAM_ID = cp.CONCURRENT_PROGRAM_ID 
AND      a.APPLICATION_ID = b.APPLICATION_ID
--AND      b.application_short_name LIKE UPPER('PA')
and cp.user_concurrent_program_name like ''
--and d.concurrent_program_name like '%WORKERAPPRVL%'
;

-- From Concurrent Program name to Module
-- Substitute TB.USER_CONCURRENT_PROGRAM_NAME LIKE clause with the program name
SELECT
    TB.USER_CONCURRENT_PROGRAM_NAME,
    FCP.CONCURRENT_PROGRAM_NAME MODULE_LIKE
FROM
    FND_CONCURRENT_PROGRAMS_TL TB,
    FND_CONCURRENT_PROGRAMS FCP
WHERE
    TB.CONCURRENT_PROGRAM_ID = FCP.CONCURRENT_PROGRAM_ID
    AND TB.USER_CONCURRENT_PROGRAM_NAME LIKE '%%';

/*
From Module to Concurrent Program Name
Substitute module name with column FCP.CONCURRENT_PROGRAM_NAME in like clause
*/

SELECT
    TB.USER_CONCURRENT_PROGRAM_NAME,
    FCP.CONCURRENT_PROGRAM_NAME MODULE_LIKE
FROM
    FND_CONCURRENT_PROGRAMS_TL TB,
    FND_CONCURRENT_PROGRAMS FCP
WHERE
    TB.CONCURRENT_PROGRAM_ID = FCP.CONCURRENT_PROGRAM_ID
    AND FCP.CONCURRENT_PROGRAM_NAME LIKE '%%';




