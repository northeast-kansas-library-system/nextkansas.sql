/*
R.002969

----------

Name: GHW - Monthly 104
Created by: George H Williams

----------

Group: Statistics
     End of month statistics

Created on: 2017-07-01 13:22:33
Modified on: 2019-11-14 09:20:23
Date last run: 2021-09-01 09:08:59

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates end of month data for spreadsheet report</p>
<ul><li>Reports end of month data for Next-wide spreadsheet - Cells G58, H58, and I58</li>
</ul><br />
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=2969">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">Monthly</p>
</div>



----------
*/



SELECT
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(*) AS COUNT
FROM
  biblio
WHERE
  biblio.datecreated < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)
UNION
SELECT
  'Biblios added last month' AS DESCRIPTION,
  Count(*)
FROM
  biblio
WHERE
  Month(biblio.datecreated) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(biblio.datecreated) = Year(Now() - INTERVAL 1 MONTH)
UNION
SELECT
  'Biblios deleted last month' AS DESCRIPTION,
  Count(*)
FROM
  deletedbiblio
WHERE
  Month(deletedbiblio.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(deletedbiblio.timestamp) = Year(Now() - INTERVAL 1 MONTH)

























