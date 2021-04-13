/*
R.003475

----------

Name: GHW - Average age of entire collection with link to Median Age of entire collection
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-04 21:44:42
Modified on: 2021-03-24 21:08:11
Date last run: 2021-04-07 14:45:48

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>This report helps calculate the average age of a library's entire collection based on the publication year listed in the biblioitems.publicationyear field for that item's bibliographic record</p>
<ul><li>It helps make the calculation on items currently in the collection</li>
<li>at the library you specify</li>
<li>grouped and sorted by library, total item count, count of items with biblioitems.publicationyear data</li>
<li>contains links to report 3476 which calculates the same collection's median age</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>The statistical average age is calculated by calculating the sum of the biblioitems.publicationyear and dividing that number by the count of items with data in biblioitems.publicationyear and rounding that number down to 0 decimal places.</p>
<p></p>
<p>Bibliographic records which contain incorrect, incomplete, or incompatible data in the biblioitems.publicationyear field are not counted when calculating this data.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3475&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">collection statistics, median age, weeding</p>
</div>

----------
*/

SELECT
  branches.branchcode,
  count_total.Count_itemnumber AS ITEMS_COUNT_TOTAL,
  count_with_pubyear.Count_itemnumber AS ITEMS_COUNT_W_PUBYEAR,
  FLOOR(Avg(average_age.publicationyear)) AS AVERAGE_AGE,
  Concat(
    '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3476&phase=Run+this+report&param_name=Choose+your+library%7Cbranches&sql_params=', 
    branches.branchcode, 
    '&param_name=Enter+row+number&sql_params=',
    Floor(count_with_pubyear.Count_itemnumber / 2),
    '" target="_blank">', 
    'Link to median age report', 
    '</a>'
  ) AS LINK_TO_MEDIAN_AGE
FROM
  branches LEFT JOIN
  (SELECT
     items.homebranch,
     Count(DISTINCT items.itemnumber) AS Count_itemnumber
   FROM
     items
   GROUP BY
     items.homebranch) count_total ON count_total.homebranch =
      branches.branchcode LEFT JOIN
  (SELECT
     items.homebranch,
     Count(DISTINCT items.itemnumber) AS Count_itemnumber
   FROM
     biblioitems JOIN
     items ON items.biblioitemnumber = biblioitems.biblioitemnumber
   WHERE
     biblioitems.publicationyear < Year(Now()) AND
     biblioitems.publicationyear REGEXP '^[0-9]+$'
   GROUP BY
     items.homebranch) count_with_pubyear ON count_with_pubyear.homebranch =
      branches.branchcode LEFT JOIN
  (SELECT
     items.homebranch,
     items.itemnumber,
     biblioitems.publicationyear
   FROM
     biblioitems JOIN
     items ON items.biblioitemnumber = biblioitems.biblioitemnumber
   WHERE
     biblioitems.publicationyear < Year(Now()) AND
     biblioitems.publicationyear REGEXP '^[0-9]+$'
   GROUP BY
     items.homebranch,
     items.itemnumber,
     biblioitems.publicationyear) average_age ON average_age.homebranch =
      branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchcode,
  count_total.Count_itemnumber,
  count_with_pubyear.Count_itemnumber
LIMIT 1000



