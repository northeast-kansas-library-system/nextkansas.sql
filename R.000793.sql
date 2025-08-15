/*
R.000793

----------

Name: Monthly ILL (loans and borrows)
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2010-01-25 09:54:12
Modified on: 2024-02-15 11:32:35
Date last run: 2025-08-10 19:25:22

----------

Public: 0
Expiry: 0

----------

 
Counts the number of items that were put in transit to fill requests at other libraries
during the month you specify
Based on the item's home library
grouped by library and shipping or receiving date
sorted by library name

Notes:

NX_ILL_LOANED_LM = the number of items owned by your library that were shipped "in transit" to another library during the month.
NX_ILL_BORROWED_LM = the number of items not owned by your library that arrived "in transit" to your library during the month.
This report does not take into account whether the item was actually checked out by a borrower - it only considers that the item was shipped from or to your library.
Replaces report 794.

Updated on 2022.03.29

#ILL #statistics #count



----------
*/



SELECT 
  branches.branchname, 
  Coalesce(ILL_LOANED.count, 0) AS NX_ILL_LOANED_LM, 
  Coalesce(ILL_BORROWED.count, 0) AS NX_ILL_BORROWED_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      items.homebranch, 
      COUNT(*) AS count 
    FROM 
      branchtransfers LEFT JOIN 
      items ON branchtransfers.itemnumber = items.itemnumber 
    WHERE 
      items.homebranch &lt;&gt; branchtransfers.tobranch AND 
      Year(branchtransfers.datesent) = &lt;&gt; AND 
      Month(branchtransfers.datesent) = &lt;&gt; AND 
      branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch AND 
      branchtransfers.comments IS NULL AND
      branchtransfers.reason = 'reserve'
    GROUP BY 
      items.homebranch 
    ) ILL_LOANED 
  ON branches.branchcode = ILL_LOANED.homebranch LEFT JOIN 
    (SELECT 
      branchtransfers.tobranch, 
      COUNT(*) AS count 
    FROM 
      branchtransfers LEFT JOIN 
      items ON branchtransfers.itemnumber = items.itemnumber 
    WHERE 
      branchtransfers.tobranch &lt;&gt; items.homebranch AND 
      Year(branchtransfers.datearrived) = &lt;&gt; AND 
      Month(branchtransfers.datearrived) = &lt;&gt; AND 
      branchtransfers.frombranch &lt;&gt; branchtransfers.tobranch AND 
      branchtransfers.comments IS NULL  AND
      branchtransfers.reason = 'reserve'
    GROUP BY 
      branchtransfers.tobranch 
    ) ILL_BORROWED 
  ON branches.branchcode = ILL_BORROWED.tobranch 
GROUP BY 
  branches.branchname 
ORDER BY 
  branches.branchname 
LIMIT 
  100 

























