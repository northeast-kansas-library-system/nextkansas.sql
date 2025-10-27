/*
R.003842

----------

Name: 0135 - Count of failed login attempts monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2024-06-05 14:57:10
Modified on: 2025-04-30 11:50:30
Date last run: 2025-10-02 01:35:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  'branchname' AS 'branchname',
  'ATTEMPTS_FAILED_VIA_STAFF' AS 'ATTEMPTS_FAILED_VIA_STAFF',
  'LOCKOUTS_VIA_STAFF' AS 'LOCKOUTS_VIA_STAFF',
  'ATTEMPTS_FAILED_NON_INTRANET' AS 'ATTEMPTS_FAILED_NON_INTRANET',
  'LOCKOUTS_VIA_OPAC' AS 'LOCKOUTS_VIA_OPAC',
  'LOCKOUTS_VIA_SIP' AS 'LOCKOUTS_VIA_SIP',
  'LOCKOUTS_VIA_API' AS 'LOCKOUTS_VIA_API'
UNION 
(SELECT 
  branchess.branchname, 
  intranet_login_attempts.login_attempst AS ATTEMPTS_FAILED_VIA_STAFF, 
  intranet_attempt_results_in_locked.intranet_lockouts AS LOCKOUTS_VIA_STAFF, 
  opac_login_attempts.login_attempst AS ATTEMPTS_FAILED_NON_INTRANET, 
  opac_attempt_results_in_locked.Count_action_id AS LOCKOUTS_VIA_OPAC, 
  sip_attempt_results_in_locked.Count_action_id AS LOCKOUTS_VIA_SIP, 
  api_attempt_results_in_locked.Count_action_id AS LOCKOUTS_VIA_API 
FROM 
  ( 
    SELECT 
      branches.branchname, 
      branches.branchcode 
    FROM 
      branches 
    UNION 
    SELECT 
      ' Branch not defined' AS Branchname, 
      '-' AS branchcode 
  ) branchess 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(action_logs.action_id) AS login_attempst 
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
      Count(action_logs.action_id) AS login_attempst 
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
      Count(DISTINCT action_logs.action_id) AS intranet_lockouts 
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
  ) intranet_attempt_results_in_locked 
    ON intranet_attempt_results_in_locked.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.action_id) AS Count_action_id 
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
  ) opac_attempt_results_in_locked 
    ON opac_attempt_results_in_locked.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.action_id) AS Count_action_id 
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
  ) sip_attempt_results_in_locked 
    ON sip_attempt_results_in_locked.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, '-') AS branchcode, 
      Count(DISTINCT action_logs.action_id) AS Count_action_id 
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
  ) api_attempt_results_in_locked 
    ON api_attempt_results_in_locked.branchcode = branchess.branchcode 
ORDER BY 
  branchess.branchname 
) 

























