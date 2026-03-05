/*
R.002825

----------

Name: GHW - Newly added - not indexed
Created by: George Williams

----------

Group: Catalog Records and Items
     Fix Items

Created on: 2016-11-15 16:41:08
Modified on: 2024-01-17 11:46:59
Date last run: 2020-11-10 15:50:16

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows titles that haven't indexed properly since 2016.11.10&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items added since 2016.11.10&lt;/li&gt;
&lt;li&gt;At the library you specify&lt;/li&gt;
&lt;li&gt;sorted by homebranch, shelving location, item type, collection code, call number, author, and title&lt;/li&gt;
&lt;li&gt;contains links to the bibliographic record of the item&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report was created to help catalogers find items that can't be searched because of the indexing problems we are currently having.&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2825&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
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
  biblio.biblionumber &gt; '769233' AND
  Coalesce(items.homebranch, '') LIKE &lt;&gt;
ORDER BY
  HOMEBRANCH,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title

























