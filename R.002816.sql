/*
R.002816

----------

Name: GHW - Quick list of titles by an author
Created by: George Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-11-04 16:40:55
Modified on: 2024-01-17 11:47:05
Date last run: 2024-04-29 19:59:29

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;What it does generates a list of all titles by an author by brief title&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items currently in the catalog&lt;/li&gt;
&lt;li&gt;shows items at a specified library by a specified author&lt;/li&gt;
&lt;li&gt;grouped by classification, call number, author, and title information&lt;/li&gt;
&lt;li&gt;sorted by title&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Report created at the request of Baldwin Public Library.&lt;/p&gt;
&lt;p&gt;The author's name must be entered as SURNAME, FIRSTNAME or the report will not work&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2816&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  items.location,
  items.itype,
  authorised_values.lib AS COLLECTION_CODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author,
  biblio.title
FROM
  items LEFT JOIN
  biblioitems
    ON items.biblioitemnumber = biblioitems.biblioitemnumber LEFT JOIN
  biblio
    ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  authorised_values
    ON items.ccode = authorised_values.authorised_value
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  biblio.author LIKE concat('%',&lt;&gt;, '%') AND
  authorised_values.category = "CCODE"
ORDER BY
  biblio.title

























