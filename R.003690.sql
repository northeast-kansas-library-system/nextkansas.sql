/*
R.003690

----------

Name: GHW - Quick count - Titles, items, borrowers
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-14 15:40:40
Modified on: 2022-12-14 15:40:40
Date last run: 2023-01-31 17:07:35

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Quick count for titles, items, and borrowers</p>
  <ul>
    <li>Shows current data for the time the report is run</li>
    <li>at all libraries</li>
    <li>grouped and sorted by library</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Notes go here.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#quick_count</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

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

























