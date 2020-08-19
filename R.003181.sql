/*
R.003181

----------

Name: GHW - Checkouts and renewals by title and item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-03-04 16:13:12
Modified on: 2019-03-04 16:16:57
Date last run: 2020-06-16 16:29:11

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Gives a circulation count by title and item type</p>
<ul><li>Shows items checkedout in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by library, year, month, itemtype and title</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3181&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  statistics.branch,
  Year(statistics.datetime) AS YEAR,
  Month(statistics.datetime) AS MONTH,
  itemtypes.description AS ITYPE,
  Coalesce(biblio.title, biblio1.title) AS TITLE,
  Count(*) AS CKO_RENEW_COUNT
FROM
  statistics
  LEFT JOIN items ON items.itemnumber = statistics.itemnumber
  LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblio biblio1 ON biblio1.biblionumber = deleteditems.biblionumber
  INNER JOIN itemtypes ON itemtypes.itemtype = statistics.itemtype
WHERE
  statistics.branch LIKE <<Select your library|ZBRAN>> AND
  statistics.itemtype LIKE <<Select Item type|itemtypes>> AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  (statistics.type = 'ISSUE' OR
    statistics.type = 'RENEW')
GROUP BY
  statistics.branch,
  Year(statistics.datetime),
  Month(statistics.datetime),
  itemtypes.description,
  Coalesce(biblio.title, biblio1.title)
ORDER BY
  statistics.branch,
  YEAR,
  MONTH,
  ITYPE,
  TITLE



