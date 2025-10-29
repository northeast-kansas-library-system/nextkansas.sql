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

<div class="reportinfo noprint"> 
 
  <div class="reportInfoContent"> 
 
    <p>Reports library basic information including</p> 

    <ol>
      <li>Library name</li>
      <li>Library branchcode</li>
      <li>Current borrower count</li>
      <li>Current title count</li>
      <li>Current item count</li>
    </ol>
 
    <ul> 
      <li>Reports current data</li> 
      <li>at all member libraries</li> 
      <li>grouped by library branchcode</li> 
      <li>sorted by library branch name</li> 
    </ul> 
 
  </div>

  <div class="reportInfoNotes">
 
    <p> </p> 

    <p> 
      Notes go here.
    </p> 
 
    <p> 
      Title count = number of titles owned by this library / item count = number of items.  Item counts are usually higher than title counts because most libraries own duplicate copies for several titles.
    </p> 

    <p> 
      Updated by GHW on 2023.08.01
    </p> 
   
  </div> 

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

























