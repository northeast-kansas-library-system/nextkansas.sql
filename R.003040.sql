/*
R.003040

----------

Name: GHW - Request action logs by request ID
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-01-16 22:16:46
Modified on: 2018-04-16 11:13:50
Date last run: 2023-04-05 15:07:14

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Shows action log entries for specific requests from the last 60 days</p>
<ul><li>Shows actions that happened within the last 60 days</li>
<li>on the request you specify</li>
<li>grouped and sorted by action log ID</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Data from the action logs is purged once it is 60 days old.  This report cannot show you information about request modifications if those modifications happened more than 60 days ago.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3040&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  REPLACE(action_logs.info, ",", ",<br />") AS DESCRIPTION,
  action_logs.interface,
  CONCAT("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", action_logs.user, "' target='_blank'>See who created/modified/cancelled the request</a>") AS LINK
FROM
  action_logs
WHERE
  action_logs.module = 'HOLDS' AND
  action_logs.object LIKE Concat("%", <<Enter request ID number>>, "%")
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.action_id
  DESC

























