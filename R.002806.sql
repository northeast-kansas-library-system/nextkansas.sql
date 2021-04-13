/*
R.002806

----------

Name: GHW - Circulation statistics for locally owned items by date range
Created by: George H Williams

----------

Group: Statistics
     Date range

Created on: 2016-10-13 16:32:19
Modified on: 2021-04-06 09:56:34
Date last run: 2021-04-10 10:35:53

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Counts circulation (check-outs, renewals, and local use) of items checked out at a library that were owned by that library</p>
<ul><li>Counts circulation during the date range you specify</li>
<li>At the library you specify</li>
<li>grouped and sorted by item type, collection code, and shelving location code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report is in the process of being rewritten due to changes in item type codes and shelving location codes.  If you are unsure what a location code or an item type from this report represents, run report 3490 for a list of location codes or 3491 for a list of item type codes.</p>
<p></p>
<p><a href="https://staff.nextkansas.org/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3490&limit=1000" target="_blank">Report 3490</a></p>
<p><a href="https://staff.nextkansas.org/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3491&limit=1000" target="_blank">Report 3491</a></p>
<p></p>
<p>Updated on 2020.01.06 to reflect changes in the database structure</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2806&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">statistics by date range</p>
</div>

----------
*/

SELECT
  If(statistics.itemtype IS NULL, "BOOK", statistics.itemtype) AS ITEM_TYPE,
  If(statistics.ccode IS NULL, "(Unclassified)", ccodes.lib) AS CCODE,
  If(statistics.location IS NULL, "ADULT", statistics.location) AS SHELVING_LOCATION,
  Count(*) AS count
FROM
  statistics
  LEFT JOIN items
    ON statistics.itemnumber = items.itemnumber
  LEFT JOIN deleteditems
    ON statistics.itemnumber = deleteditems.itemnumber
  LEFT JOIN borrowers
    ON statistics.borrowernumber = borrowers.borrowernumber
  LEFT JOIN deletedborrowers
    ON statistics.borrowernumber = deletedborrowers.borrowernumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes
    ON ccodes.authorised_value = statistics.ccode
WHERE
  (statistics.branch LIKE @brn:=<<Enter your branch|LBRANCH>> COLLATE utf8mb4_unicode_ci) AND
  statistics.type IN ('issue', 'renew', 'localuse') AND
  statistics.datetime BETWEEN (<<Enter start date|date>>) AND (<<Enter end date|date>> + INTERVAL 1 DAY) AND
  Coalesce(items.homebranch, deleteditems.homebranch) LIKE @brn AND
  Coalesce(borrowers.categorycode, deletedborrowers.categorycode) <> "INHOUSE"
GROUP BY
  If(statistics.itemtype IS NULL, "BOOK", statistics.itemtype),
  If(statistics.ccode IS NULL, "(Unclassified)", ccodes.lib),
  If(statistics.location IS NULL, "ADULT", statistics.location)
ORDER BY
  ITEM_TYPE,
  CCODE,
  SHELVING_LOCATION



