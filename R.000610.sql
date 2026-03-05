/*
R.000610

----------

Name: Library basic information
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     System-admin

Created on: 2009-06-24 16:26:50
Modified on: 2024-01-17 11:18:26
Date last run: 2025-09-25 16:36:53

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Reports library basic information including&lt;/p&gt; 

    &lt;ol&gt;
      &lt;li&gt;Library name&lt;/li&gt;
      &lt;li&gt;Library branchcode&lt;/li&gt;
      &lt;li&gt;Current borrower count&lt;/li&gt;
      &lt;li&gt;Current title count&lt;/li&gt;
      &lt;li&gt;Current item count&lt;/li&gt;
    &lt;/ol&gt;
 
    &lt;ul&gt; 
      &lt;li&gt;Reports current data&lt;/li&gt; 
      &lt;li&gt;at all member libraries&lt;/li&gt; 
      &lt;li&gt;grouped by library branchcode&lt;/li&gt; 
      &lt;li&gt;sorted by library branch name&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt;

  &lt;div class="reportInfoNotes"&gt;
 
    &lt;p&gt; &lt;/p&gt; 

    &lt;p&gt; 
      Notes go here.
    &lt;/p&gt; 
 
    &lt;p&gt; 
      Title count = number of titles owned by this library / item count = number of items.  Item counts are usually higher than title counts because most libraries own duplicate copies for several titles.
    &lt;/p&gt; 

    &lt;p&gt; 
      Updated by GHW on 2023.08.01
    &lt;/p&gt; 
   
  &lt;/div&gt; 

----------
*/



SELECT
  branches.branchname,
  branches.branchcode,
  Coalesce(borrower_count.Count_borrowernumber, 0) AS BORROWER_COUNT,
  Coalesce(biblio_count.Count_biblionumber, 0) AS TITLE_COUNT,
  Coalesce(item_count.Count_itemnumber, 0) AS ITEM_COUNT
FROM
  branches LEFT JOIN
  (
    SELECT
      items.homebranch,
      Count(DISTINCT items.biblionumber) AS Count_biblionumber
    FROM
      items
    GROUP BY
      items.homebranch
  ) biblio_count ON 
    biblio_count.homebranch = branches.branchcode LEFT JOIN
  (
    SELECT
      items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.homebranch) item_count ON item_count.homebranch =
      branches.branchcode LEFT JOIN
  (
    SELECT
      borrowers.branchcode,
      Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber
    FROM
      borrowers
    GROUP BY
      borrowers.branchcode
  ) borrower_count ON 
    borrower_count.branchcode = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchname
LIMIT 500

























