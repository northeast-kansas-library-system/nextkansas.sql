/*
R.003730

----------

Name: GHW - Home library and item counts by first five digits of item barcode number
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-09 11:42:14
Modified on: 2024-01-17 11:14:33
Date last run: 2024-08-20 16:49:59

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Counts items by the first four digits of item barcode number.&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;counts items currently in the catalog&lt;/li&gt;
    &lt;li&gt;at all libraries&lt;/li&gt;
    &lt;li&gt;grouped by first four digits of item barcode number and library&lt;/li&gt;
    &lt;li&gt;sorted by first four digits of item barcode number&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3730"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#barcode #items #prefix&lt;/p&gt;
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt;

----------
*/



SELECT
  Left(items.barcode, 4) AS FIRST_4_DIGITS_OF_ITEM_BARCODE,
  branches.branchname AS LIBRARY_NAME,
  Count(items.itemnumber) AS ITEM_COUNT
FROM
  branches JOIN
  items ON items.homebranch = branches.branchcode
GROUP BY
  Left(items.barcode, 4),
  branches.branchname
ORDER BY
  barcode

























