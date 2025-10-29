/*
R.003209

----------

Name: GHW - Rotating collections - Report 1
Created by: George Williams

----------

Group: -
     -

Created on: 2019-06-10 11:43:41
Modified on: 2024-01-17 11:54:07
Date last run: 2019-06-10 15:06:34

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Identifies all "Rotating collection" groups</p>
<ul><li>Shows all current groups</li>
<li>grouped and sorted by collection ID</li>
<li>links to the print and edit reports for "Rotating collections"</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3209&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat_WS(
    "",
    Concat("Title: ", collections.colTitle),
    Concat("Description: ", collections.colDesc)
  ) AS COLLECTION,
  Concat('Run report to print') AS PRINT,
  Concat('Run report to batch edit') AS EDIT
FROM
  collections
GROUP BY
  collections.colId
ORDER BY
  collections.colId
DESC
  

























