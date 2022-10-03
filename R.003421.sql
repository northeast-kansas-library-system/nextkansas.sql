/*
R.003421

----------

Name: GHW - A4 Monthly overview - Inter-Next loans and borrows - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-02-04 17:45:36
Modified on: 2022-03-29 11:43:58
Date last run: 2022-10-01 00:20:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Monthly overview - items loaned to and borrowed from other libraries in Next Search Catalog</p> 
<ul><li>Shows item transfer counts for the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by branch name</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>Generates data for:</p> 
<ul> 
  <li>NX_ILL_LOANED_LM = count of items your library loaned to another Next Search Catalog library last month</li> 
  <li>NX_ILL_BORROWED_LM = count of items your library borrowed from another Next Search Catalog library last month</li> 
</ul> 
<p></p> 
<p>These counts are are based on whether you shipped or received an item via the Kansas Library Express courier.  Whether or not the item was actually checked out to a borrower is irrelevant in this count because, whether or not loaned to a borrower, the item was loaned to another library or borrowed from your library.</p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3421">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #overview</p> 
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
      Year(branchtransfers.datesent) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(branchtransfers.datesent) = Month(Now() - INTERVAL 1 MONTH) AND 
      branchtransfers.tobranch <> branchtransfers.frombranch AND 
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
      branchtransfers.tobranch <> items.homebranch AND 
      Month(branchtransfers.datearrived) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(branchtransfers.datearrived) = Year(Now() - INTERVAL 1 MONTH) AND 
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

























