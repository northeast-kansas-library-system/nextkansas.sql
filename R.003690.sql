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

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Quick count for titles, items, and borrowers&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Shows current data for the time the report is run&lt;/li&gt;
    &lt;li&gt;at all libraries&lt;/li&gt;
    &lt;li&gt;grouped and sorted by library&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p&gt;Notes go here.&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#quick_count&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

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

























