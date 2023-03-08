/*
R.003004

----------

Name: GHW - Circulation Transaction Log
Created by: George H Williams

----------

Group: Circulation
     -

Created on: 2017-10-05 15:03:46
Modified on: 2020-02-18 15:02:02
Date last run: 2023-03-03 08:52:13

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a transaction log for all checkouts and renewals at a branch on one day</p>
<ul><li>Shows a log for the date you specify</li>
<li>Shows all of the checkouts and renewals at the branch you specify</li>
<li>grouped by date, time, item barcode, and patron barcode</li>
<li>sorted by date/time from newest to oldest</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report will only show the staff login for checkouts (renewals are not logged) but the way this report gathers data from the action logs is not perfect so you may see renewals with staff login information and checkouts with no staff login information.<br />
Staff login information can only be recovered if the circulation occurred in the previous 60 days.  The table where that information is stored has data more than 60 days old purged on a daily basis.<br />
Transaction history is only saved for the previous 25 months.  You cannot run this report to gather data more than 25 months old.<br />
This report will only cover 1 day at a time.  Creating a report that generates a log for multiple days has the potential to disrupt the system.<br />
</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3004&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  statistics.datetime,
  statistics.branch,
  actions.cardnumber AS STAFF_LOGIN,
  statistics.type,
  Upper(items.barcode) AS ITEM_BC,
  statistics.itemtype,
  statistics.ccode,
  Upper(borrowers.cardnumber) AS PATRON_BC
FROM
  statistics
  LEFT JOIN items ON statistics.itemnumber = items.itemnumber
  LEFT JOIN borrowers ON statistics.borrowernumber = borrowers.borrowernumber
  LEFT JOIN (SELECT
        action_logs.timestamp,
        action_logs.object,
        action_logs.info,
        action_logs.module,
        action_logs.action,
        action_logs.user,
        borrowers.cardnumber
      FROM
        action_logs
        JOIN borrowers ON action_logs.user = borrowers.borrowernumber
      WHERE
        action_logs.module = 'circulation' AND
        (action_logs.action = 'issue' OR
         action_logs.action = 'renewal')) actions
  ON statistics.itemnumber = actions.info
  AND statistics.borrowernumber = actions.object
  AND statistics.datetime = actions.timestamp
WHERE
  (statistics.type = 'ISSUE' OR
    statistics.type = 'RENEW') AND
  statistics.branch LIKE <<Choose your branch|ZBRAN>> AND
  statistics.datetime BETWEEN (@startdate := CAST(<<Choose the date|date>> AS DATE)) AND (CAST(@startdate AS DATE) + INTERVAL 1 DAY)
GROUP BY
  statistics.datetime,
  ITEM_BC,
  PATRON_BC
ORDER BY
  statistics.datetime DESC

























