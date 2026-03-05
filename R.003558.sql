/*
R.003558

----------

Name: GHW - Count of items by barcode number length
Created by: George Williams

----------

Group: -
     -

Created on: 2021-09-08 16:19:14
Modified on: 2024-01-17 11:28:43
Date last run: 2025-06-13 09:20:55

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts all items at a library based on the length of their barcode numbers&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Lists current data&lt;/li&gt;
&lt;li&gt;At the library you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by the name of the library and the length of the barcode numbers&lt;/li&gt;
&lt;li&gt;links to report 3557 which lists all of the items at a library with a specified barcode number length&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Can be used to identified errors made when items are entered with an incorrect barcode number&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#item barcode #length #barcode count&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  branches.branchname,
  Coalesce(Length(items.barcode), 0) AS ITEM_BARCODE_LENGTH,
  Count(DISTINCT items.itemnumber) AS ITEM_BARCODE_COUNT,
  CONCAT(
    'List of items'
  ) AS LINK_TO_FULL_LIST
FROM
  items JOIN
  branches ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  Length(items.barcode)

























