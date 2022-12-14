/*
R.003476

----------

Name: GHW - Median age of entire collection (see instructions)
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-04 22:39:07
Modified on: 2021-03-24 23:35:55
Date last run: 2022-12-14 11:11:53

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<h3>This report cannot be run on its own.  You must run report 3475 and then click the link to trigger a meaningful result from this report</h3><br />
<p>This report helps calculate the median age of a library's entire collection based on the publication year listed in the biblioitems.publicationyear field for that item's bibliographic record</p>
<ul><li>It helps make the calculation on items currently in the collection</li>
<li>at the library you specify</li>
<li>grouped by item number and biblioitems.publicationyear</li>
<li>sorted by biblioitems.publicationyear</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>The statistical median age is calculated by listing the publication year of every item in a collection by publication year in order by publication year and then picking the publication year at the list's midpoint.</p>
<p></p>
<p>This report is designed to be run from report 3475.  Running report 3475 calculates the number of items for that collection with numeric data in biblioitems.publicationyear.  By clicking on the link in that report to run this one, you're telling that report to look at the middle row of this report, which should give you the statistical median age for the items in the same collection .</p>
<p></p>
<p>Bibliographic records which contain incorrect, incomplete, or incompatible data in the biblioitems.publicationyear field are not counted when calculating this data.</p>
<p></p>
<p class= "notetags" style="display: none;">collection statistics, median age, weeding</p>
</div>

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
     items.homebranch = <<Choose your library|branches>> AND
     biblioitems.publicationyear < Year(Now()) AND
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
  ROW_NUM = <<Enter row number>>
ORDER BY
  MEDIAN_AGE.MEDIAN_COLLECTION_AGE ASC


























