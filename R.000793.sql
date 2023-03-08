/*
R.000793

----------

Name: Monthly ILL (loans and borrows)
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2010-01-25 09:54:12
Modified on: 2022-03-29 13:25:21
Date last run: 2023-03-07 15:35:15

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Counts the number of items that were put in transit to fill requests at other libraries</p>
<ul><li>during the month you specify</li>
<li>Based on the item's home library</li>
<li>grouped by library and shipping or receiving date</li>
<li>sorted by library name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>NX_ILL_LOANED_LM = the number of items owned by your library that were shipped "in transit" to another library during the month.</p>
<p>NX_ILL_BORROWED_LM = the number of items not owned by your library that arrived "in transit" to your library during the month.</p>
<p>This report does not take into account whether the item was actually checked out by a borrower - it only considers that the item was shipped from or to your library.</p>
<p>Replaces report 794.</p>
<p></p>
<p>Updated on 2022.03.29</p>
<p></p>
<p class= "notetags" style="display: none;">#ILL #statistics #count</p>
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

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
      items.homebranch <> branchtransfers.tobranch AND 
      Year(branchtransfers.datesent) = <<Enter the year|R_YEAR>> AND 
      Month(branchtransfers.datesent) = <<Enter the month|LMONTH>> AND 
      branchtransfers.tobranch <> branchtransfers.frombranch AND 
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
      branchtransfers.tobranch <> items.homebranch AND 
      Year(branchtransfers.datearrived) = <<Enter the year|R_YEAR>> AND 
      Month(branchtransfers.datearrived) = <<Enter the month|LMONTH>> AND 
      branchtransfers.frombranch <> branchtransfers.tobranch AND 
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

























