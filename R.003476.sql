/*
R.003476

----------

Name: GHW - Median age of entire collection (see instructions)
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-04 22:39:07
Modified on: 2024-01-17 12:00:58
Date last run: 2024-06-04 15:00:44

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;h3&gt;This report cannot be run on its own.  You must run report 3475 and then click the link to trigger a meaningful result from this report&lt;/h3&gt;&lt;br /&gt;
&lt;p&gt;This report helps calculate the median age of a library's entire collection based on the publication year listed in the biblioitems.publicationyear field for that item's bibliographic record&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;It helps make the calculation on items currently in the collection&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by item number and biblioitems.publicationyear&lt;/li&gt;
&lt;li&gt;sorted by biblioitems.publicationyear&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;The statistical median age is calculated by listing the publication year of every item in a collection by publication year in order by publication year and then picking the publication year at the list's midpoint.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report is designed to be run from report 3475.  Running report 3475 calculates the number of items for that collection with numeric data in biblioitems.publicationyear.  By clicking on the link in that report to run this one, you're telling that report to look at the middle row of this report, which should give you the statistical median age for the items in the same collection .&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Bibliographic records which contain incorrect, incomplete, or incompatible data in the biblioitems.publicationyear field are not counted when calculating this data.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;collection statistics, median age, weeding&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  (@row_number := @row_number + 1) AS ROW_NUM,
  MEDIAN_AGE.homebranch,
  MEDIAN_AGE.MEDIAN_COLLECTION_AGE
FROM
  (SELECT
     items.homebranch,
     biblioitems.publicationyear AS MEDIAN_COLLECTION_AGE,
     items.itemnumber
   FROM
     biblioitems JOIN
     items ON items.biblioitemnumber = biblioitems.biblioitemnumber
   WHERE
     items.homebranch = &lt;&gt; AND
     biblioitems.publicationyear &lt; Year(Now()) AND
     biblioitems.publicationyear REGEXP '^[0-9]+$'
   GROUP BY
     items.homebranch,
     biblioitems.publicationyear,
     items.itemnumber
   ORDER BY
     MEDIAN_COLLECTION_AGE) MEDIAN_AGE,
  (SELECT
     @row_number := 0) t
GROUP BY
  MEDIAN_AGE.itemnumber,
  MEDIAN_AGE.homebranch,
  MEDIAN_AGE.MEDIAN_COLLECTION_AGE
HAVING
  ROW_NUM = &lt;&gt;
ORDER BY
  MEDIAN_AGE.MEDIAN_COLLECTION_AGE ASC


























