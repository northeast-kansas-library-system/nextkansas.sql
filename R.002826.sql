/*
R.002826

----------

Name: GHW - Item data by barcode number
Created by: George Williams

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2016-11-15 16:53:28
Modified on: 2024-01-17 11:46:56
Date last run: 2019-02-18 15:29:37

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows information on an item based on its barcode number&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;shows current data on that item's record&lt;/li&gt;
&lt;li&gt;on any item in NExpress&lt;/li&gt;
&lt;li&gt;sorted by homebranch, shelving location, item type, collection code, call number, author, and title&lt;/li&gt;
&lt;li&gt;contains links to the bibliographic record of the item&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report was created to help find items while we work through our indexing problems.&lt;/p&gt;
&lt;p&gt;The input field in this report can accept the standard SQL wildcard characters (%, _, [charlist], [^charlist], [!charlist]).&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2826&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('', biblio.biblionumber, '') AS LINK_TO_TITLE,
  biblio.biblionumber,
  Coalesce(items.barcode, '') AS BARCODE,
  Coalesce(items.homebranch, '') AS HOMEBRANCH,
  Coalesce(items.location, '') AS LOCATION,
  Coalesce(items.itype, '') AS ITYPE,
  Coalesce(items.ccode, '') AS CCODE,
  Coalesce(items.itemcallnumber, '') AS CALL_NUMBER,
  biblio.author,
  biblio.title
FROM
  biblio LEFT JOIN
  items
    ON items.biblionumber = biblio.biblionumber INNER JOIN
  biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  Coalesce(items.barcode, '') LIKE &lt;&gt;
ORDER BY
  HOMEBRANCH,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title

























