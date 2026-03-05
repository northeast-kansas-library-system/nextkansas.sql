/*
R.003475

----------

Name: GHW - Average age of entire collection with link to Median Age of entire collection
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-04 21:44:42
Modified on: 2024-01-17 12:01:10
Date last run: 2025-10-13 14:09:49

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;This report helps calculate the average age of a library's entire collection based on the publication year listed in the biblioitems.publicationyear field for that item's bibliographic record&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;It helps make the calculation on items currently in the collection&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by library, total item count, count of items with biblioitems.publicationyear data&lt;/li&gt;
&lt;li&gt;contains links to report 3476 which calculates the same collection's median age&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;The statistical average age is calculated by calculating the sum of the biblioitems.publicationyear and dividing that number by the count of items with data in biblioitems.publicationyear and rounding that number down to 0 decimal places.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Bibliographic records which contain incorrect, incomplete, or incompatible data in the biblioitems.publicationyear field are not counted when calculating this data.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3475&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;collection statistics, median age, weeding&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  branches.branchcode,
  count_total.Count_itemnumber AS ITEMS_COUNT_TOTAL,
  count_with_pubyear.Count_itemnumber AS ITEMS_COUNT_W_PUBYEAR,
  FLOOR(Avg(average_age.publicationyear)) AS AVERAGE_AGE,
  Concat(
    '', 
    'Link to median age report', 
    ''
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
     biblioitems.publicationyear &lt; Year(Now()) AND
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
     biblioitems.publicationyear &lt; Year(Now()) AND
     biblioitems.publicationyear REGEXP '^[0-9]+$'
   GROUP BY
     items.homebranch,
     items.itemnumber,
     biblioitems.publicationyear) average_age ON average_age.homebranch =
      branches.branchcode
WHERE
  branches.branchcode LIKE &lt;&gt;
GROUP BY
  branches.branchcode,
  count_total.Count_itemnumber,
  count_with_pubyear.Count_itemnumber
LIMIT 1000

























