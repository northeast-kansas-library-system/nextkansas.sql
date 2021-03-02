/*
R.003120

----------

Name: GHW - Z39.50 targets
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-09-15 11:22:32
Modified on: 2018-09-25 10:42:59
Date last run: 2018-10-22 00:04:21

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates basic Z39.50 list (makes it easy to share with other people)</p>
<ul><li>Shows current Z39.50 list used by Next Search Catalog</li>
<li>does not include Z39.50 targets that require a username/password for access</li>
<li>grouped by server ID number</li>
<li>sorted by server type and server name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Good report for sharing Z39.50 data with other libraries.</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3120&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3120">Click here to download as a csv file</a></p>
</div>

----------
*/

SELECT
  z3950servers.servername AS SERVER_NAME,
  z3950servers.host AS HOSTNAME,
  z3950servers.port AS PORT,
  z3950servers.db AS `DATABASE`,
  z3950servers.syntax,
  z3950servers.encoding,
  z3950servers.recordtype AS RECORD_TYPE
FROM
  z3950servers
WHERE
  z3950servers.userid LIKE ""
GROUP BY
  z3950servers.id
ORDER BY
  RECORD_TYPE DESC,
  SERVER_NAME



