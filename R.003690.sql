/*
R.003690

----------

Name: GHW - Quick count - Titles, items, borrowers
Created by: George Williams

----------

Group: -
     -

Created on: 2022-12-14 15:40:40
Modified on: 2023-10-16 21:59:27
Date last run: 2023-10-13 12:59:25

----------

Public: 0
Expiry: 300

----------

 
  Quick count for titles, items, and borrowers
  
    Shows current data for the time the report is run
    at all libraries
    grouped and sorted by library
  
  Notes:
  
  Notes go here.
  
  #quick_count
  


----------
*/



SELECT 
  branches.branchname, 
  biblio_counts.Count_biblionumber AS TITLE_COUNT, 
  item_counts.Count_itemnumber AS ITEM_COUNT, 
  borrower_count.Count_borrowernumber AS BORROWER_COUNT 
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
  ) biblio_counts ON 
    biblio_counts.homebranch = branches.branchcode LEFT JOIN 
  ( 
    SELECT 
      items.homebranch, 
      Count(DISTINCT items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    GROUP BY 
      items.homebranch 
  ) item_counts ON 
    item_counts.homebranch = branches.branchcode LEFT JOIN 
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
  branches.branchname, 
  biblio_counts.Count_biblionumber, 
  item_counts.Count_itemnumber, 
  borrower_count.Count_borrowernumber 
LIMIT 100 

























