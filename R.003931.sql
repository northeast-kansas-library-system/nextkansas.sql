/*
R.003931

----------

Name: Action logs test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-12-08 08:51:47
Modified on: 2025-12-08 08:51:51
Date last run: 2025-12-08 08:51:57

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
    action_id,
    timestamp,
    user,
    module,
    action,
    object,
    json_extract(info,"$.itemnumber") AS itemnumber,
    json_extract(info,"$.issue") AS "Issue ID",
    json_extract(info,"$.confirmations") AS "Confirmations",
    json_extract(info,"$.forced") AS "Forced",
    json_extract(info,"$.branchcode") AS "Branchcode"
    
FROM action_logs 
WHERE action='ISSUE' AND DATE(timestamp) BETWEEN <<Start date|date>> AND <<End date|date>>

























