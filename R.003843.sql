/*
R.003843

----------

Name: 0145 - Count of password resets and password reset emails
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2024-06-05 16:27:16
Modified on: 2024-06-05 16:27:59
Date last run: 2024-10-01 01:45:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  branchess.branchname, 
  staff_managed.Count_action_id AS STAFF_MANAGED_RESETS, 
  patron_managed.Count_action_id AS PATRON_MANAGED_RESETS, 
  staff_emails.Count_message_id AS STAFF_INITIATED_RESET_EMAILS, 
  opac_emails.Count_message_id AS OPAC_INITIATED_RESET_EMAILS 
FROM 
  ( 
    SELECT 
      branches.branchname, 
      branches.branchcode, 
      branches.branchemail 
    FROM 
      branches 
  ) branchess 
  LEFT JOIN 
  ( 
    SELECT 
      borrowers.branchcode, 
      Count(action_logs.action_id) AS Count_action_id 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'members' AND 
      action_logs.action = 'change pass' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.interface = 'intranet' 
    GROUP BY 
      borrowers.branchcode 
  ) staff_managed 
    ON staff_managed.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      borrowers.branchcode, 
      Count(action_logs.action_id) AS Count_action_id 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'members' AND 
      action_logs.action = 'change pass' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.interface = 'opac' 
    GROUP BY 
      borrowers.branchcode 
  ) patron_managed 
    ON patron_managed.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      message_queue.from_address, 
      Count(message_queue.message_id) AS Count_message_id 
    FROM 
      message_queue 
    WHERE 
      message_queue.letter_code LIKE 'STAFF_PASSWORD_RESET' AND 
      Year(message_queue.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(message_queue.updated_on) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      message_queue.from_address 
  ) staff_emails 
    ON staff_emails.from_address = branchess.branchemail 
  LEFT JOIN 
  ( 
    SELECT 
      message_queue.from_address, 
      Count(message_queue.message_id) AS Count_message_id 
    FROM 
      message_queue 
    WHERE 
      message_queue.letter_code LIKE 'PASSWORD_RESET' AND 
      Year(message_queue.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(message_queue.updated_on) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      message_queue.from_address 
  ) opac_emails 
    ON opac_emails.from_address = branchess.branchemail 
ORDER BY 
  branchess.branchname 

























