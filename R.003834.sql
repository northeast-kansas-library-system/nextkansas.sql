/*
R.003834

----------

Name: GHW - Lockout count for last month
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2024-05-30 14:59:57
Modified on: 2024-05-30 15:01:33
Date last run: 2024-10-01 01:50:02

----------

Public: 0
Expiry: 300

----------

Work in progress - this counts by number of actions - not number of borrowers.  If a borrower resets their password 10 times, the math is borrowers=1; resets=10.

----------
*/



SELECT
  branchess.branchname,
  total_lockouts.Count_action_id AS TOTAL_LOCKOUTS_LM,
  intranet_lockouts.Count_action_id AS STAFF_MEMBERS,
  opac_lockouts.Count_action_id AS KOHA_OPAC,
  sip_lockouts.Count_action_id AS SIP_LOCKOUTS,
  api_lockouts.Count_action_id AS API_LOCKOUTS,
  opac_emails.Count_message_id AS RESET_EMAILS_INITIATED_VIA_OPAC,
  staff_emails.Count_message_id AS RESET_EMAILS_INITIATED_BY_STAFF,
  staff_managed.Count_action_id AS PASSWORDS_RESET_BY_STAFF,
  patron_managed.Count_action_id AS PASSWORDS_RESET_VIA_OPAC
FROM
  (SELECT
      branches.branchname,
      branches.branchcode,
      branches.branchemail
    FROM
      branches) branchess LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(action_logs.action_id) AS Count_action_id
    FROM
      action_logs LEFT JOIN
      borrowers ON borrowers.borrowernumber = action_logs.object
    WHERE
      action_logs.module = 'members' AND
      action_logs.action = 'modify' AND
      action_logs.info LIKE '%login_attempts%' AND
      action_logs.info LIKE '%"after" : "5"%' AND
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      borrowers.branchcode) total_lockouts ON total_lockouts.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(action_logs.action_id) AS Count_action_id
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
      borrowers.branchcode) intranet_lockouts ON intranet_lockouts.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(action_logs.action_id) AS Count_action_id
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
      action_logs.interface = 'opac'
    GROUP BY
      borrowers.branchcode) opac_lockouts ON opac_lockouts.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(action_logs.action_id) AS Count_action_id
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
      action_logs.interface = 'sip'
    GROUP BY
      borrowers.branchcode) sip_lockouts ON sip_lockouts.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
      borrowers.branchcode,
      Count(action_logs.action_id) AS Count_action_id
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
      action_logs.interface = 'api'
    GROUP BY
      borrowers.branchcode) api_lockouts ON api_lockouts.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
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
      borrowers.branchcode) staff_managed ON staff_managed.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
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
      borrowers.branchcode) patron_managed ON patron_managed.branchcode =
      branchess.branchcode LEFT JOIN
  (SELECT
      message_queue.from_address,
      Count(message_queue.message_id) AS Count_message_id
    FROM
      message_queue
    WHERE
      message_queue.letter_code LIKE 'PASSWORD_RESET' AND
      Year(message_queue.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(message_queue.updated_on) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      message_queue.from_address) opac_emails ON opac_emails.from_address =
      branchess.branchemail LEFT JOIN
  (SELECT
      message_queue.from_address,
      Count(message_queue.message_id) AS Count_message_id
    FROM
      message_queue
    WHERE
      message_queue.letter_code LIKE 'STAFF_PASSWORD_RESET' AND
      Year(message_queue.updated_on) = Year(Now() - INTERVAL 1 MONTH) AND
      Month(message_queue.updated_on) = Month(Now() - INTERVAL 1 MONTH)
    GROUP BY
      message_queue.from_address) staff_emails ON staff_emails.from_address =
      branchess.branchemail
GROUP BY
  branchess.branchname

























