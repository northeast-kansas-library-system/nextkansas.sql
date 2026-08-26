/*
R.003841

----------

Name: 0140 - Count of accounts with failed login attempts monthly_statistics
Created by: George Williams

----------

Group: Statistics
     -

Created on: 2024-06-05 14:45:52
Modified on: 2026-01-30 17:32:57
Date last run: 2026-08-05 17:05:02

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  'branchname' AS 'branchname',
  'ACCTS_FAILED_VIA_STAFF' AS 'ACCTS_FAILED_VIA_STAFF',
  'ACCTS_LOCKED_VIA_STAFF' AS 'ACCTS_LOCKED_VIA_STAFF',
  'ACCTS_FAILED_NON_INTRANET' AS 'ACCTS_FAILED_NON_INTRANET',
  'ACCTS_LOCKED_VIA_OPAC' AS 'ACCTS_LOCKED_VIA_OPAC',
  'ACCTS_LOCKED_VIA_SIP' AS 'ACCTS_LOCKED_VIA_SIP',
  'ACCTS_LOCKED_VIA_API' AS 'ACCTS_LOCKED_VIA_API'
UNION 
(SELECT 
  branchess.branchname, 
  intranet_login_attempts.Count_object AS ACCTS_FAILED_VIA_STAFF, 
  intranet_locked_accounts.Count_object AS ACCTS_LOCKED_VIA_STAFF, 
  opac_login_attempts.Count_object AS ACCTS_FAILED_NON_INTRANET, 
  opac_locked_accounts.Count_object AS ACCTS_LOCKED_VIA_OPAC, 
  sip_locked_accounts.Count_object AS ACCTS_LOCKED_VIA_SIP, 
  api_locked_accounts.Count_object AS ACCTS_LOCKED_VIA_API 
FROM 
  ( 
    SELECT 
      branches.branchname, 
      branches.branchcode 
    FROM 
      branches 
  ) branchess 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.object) AS Count_object 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'AUTH' AND 
      action_logs.action = 'FAILURE' AND 
      action_logs.interface = 'INTRANET' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
  ) intranet_login_attempts 
    ON intranet_login_attempts.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.object) AS Count_object 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'AUTH' AND 
      action_logs.action = 'FAILURE' AND 
      action_logs.interface = 'opac' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
  ) opac_login_attempts 
    ON opac_login_attempts.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.object) AS Count_object 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'members' AND 
      action_logs.action = 'modify' AND 
      action_logs.info LIKE '%login_attempts%' AND 
      action_logs.info LIKE '%"after" : "5"%' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.interface = 'intranet' 
    GROUP BY 
      Coalesce(borrowers.branchcode, '-') 
  ) intranet_locked_accounts 
    ON intranet_locked_accounts.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.object) AS Count_object 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'members' AND 
      action_logs.action = 'modify' AND 
      action_logs.info LIKE '%login_attempts%' AND 
      action_logs.info LIKE '%"after" : "5"%' AND 
      action_logs.interface = 'opac' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      Coalesce(borrowers.branchcode, '-') 
  ) opac_locked_accounts 
    ON opac_locked_accounts.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.object) AS Count_object 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'members' AND 
      action_logs.action = 'modify' AND 
      action_logs.info LIKE '%login_attempts%' AND 
      action_logs.info LIKE '%"after" : "5"%' AND 
      action_logs.interface = 'sip' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      Coalesce(borrowers.branchcode, '-') 
  ) sip_locked_accounts 
    ON sip_locked_accounts.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.object) AS Count_object 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'members' AND 
      action_logs.action = 'modify' AND 
      action_logs.info LIKE '%login_attempts%' AND 
      action_logs.info LIKE '%"after" : "5"%' AND 
      action_logs.interface = 'api' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      Coalesce(borrowers.branchcode, '-') 
  ) api_locked_accounts 
    ON api_locked_accounts.branchcode = branchess.branchcode 
ORDER BY 
  branchess.branchname 
) 

























