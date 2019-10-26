/*
R.002994

----------

Name: GHW - PFL INCIDENT
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-09-11 15:31:47
Modified on: 2017-09-11 15:34:03
Date last run: 2018-05-04 17:33:04

----------

Public: 0
Expiry: 300

----------

Report for PFL incident

----------
*/

SELECT
  action_logs.action_id,
  action_logs.timestamp,
  staff.cardnumber AS STAFF,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  action_logs.info,
  action_logs.interface,
  patron.cardnumber,
  Concat('<a href=https://staff.nexpresslibrary.org/cgi-bin/koha/circ/circulation.pl?borrowernumber=', patron.borrowernumber,' target="_blank">Link to patron</a>') AS
  LINK
FROM
  action_logs
  INNER JOIN borrowers staff ON action_logs.user = staff.borrowernumber
  INNER JOIN borrowers patron ON action_logs.object = patron.borrowernumber
WHERE
  action_logs.timestamp BETWEEN "2017-09-11 11:00" AND "2017-09-11 12:00" AND
  staff.cardnumber LIKE "%PAOLA%" AND
  action_logs.module = 'CIRCULATION' AND
  (action_logs.action = 'ISSUE' OR
    action_logs.action = 'RENEW')


