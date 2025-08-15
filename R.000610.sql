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
Date last run: 2025-07-03 11:19:29

----------

Public: 0
Expiry: 0

----------

 
 
   
 
    Reports library basic information including 

    
      Library name
      Library branchcode
      Current borrower count
      Current title count
      Current item count
    
 
     
      Reports current data 
      at all member libraries 
      grouped by library branchcode 
      sorted by library branch name 
     
 
  

  
 
      

     
      Notes go here.
     
 
     
      Title count = number of titles owned by this library / item count = number of items.  Item counts are usually higher than title counts because most libraries own duplicate copies for several titles.
     

     
      Updated by GHW on 2023.08.01
     
   
   

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

























