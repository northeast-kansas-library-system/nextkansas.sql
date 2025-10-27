/*
R.003421

----------

Name: 0020 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 17:45:36
Modified on: 2025-04-30 10:10:22
Date last run: 2025-10-03 12:47:43

----------

Public: 0
Expiry: 300

----------

 
Monthly overview - items loaned to and borrowed from other libraries in Next Search Catalog 
Shows item transfer counts for the previous calendar month 
At all Next Search Catalog libraries 
grouped and sorted by branch name 
 
Notes: 
 
Generates data for: 
 
  NX_ILL_LOANED_LM = count of items your library loaned to another Next Search Catalog library last month 
  NX_ILL_BORROWED_LM = count of items your library borrowed from another Next Search Catalog library last month 
 
 
These counts are are based on whether you shipped or received an item via the Kansas Library Express courier.  Whether or not the item was actually checked out to a borrower is irrelevant in this count because, whether or not loaned to a borrower, the item was loaned to another library or borrowed from your library. 
 
This report and these notes updated on 2022.03.10 
 
Click here to download as a csv file 
#monthly #statistics #overview #monthly_overview 
 
 

----------
*/



SELECT 
  'BRANCHNAME' AS BRANCHNAME,
  'NX_ILL_LOANED_LM' AS NX_ILL_LOANED_LM,
  'NX_ILL_BORROWED_LM' AS NX_ILL_BORROWED_LM
UNION  
(SELECT 
  'BRANCHNAME' AS BRANCHNAME,
  'NX_ILL_LOANED_LM' AS NX_ILL_LOANED_LM, 
  'NX_ILL_BORROWED_LM' AS NX_ILL_BORROWED_LM
UNION
(SELECT 
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
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND 
      branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch AND 
      branchtransfers.comments IS NULL  AND
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
      Month(branchtransfers.datearrived) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(branchtransfers.datearrived) = Year(Now() - INTERVAL 1 MONTH) AND 
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
  branches.branchname))

























