/*
R.002924

----------

Name: GHW - BONNERSPGS price repair
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2017-03-17 16:59:13
Modified on: 2024-01-17 11:49:27
Date last run: 2019-12-26 17:27:38

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Report for Bonner Springs to help add discounted costs of items to records&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items added in the date range you specify&lt;/li&gt;
&lt;li&gt;Shows items owned by Bonner Springs with a value in the 952g field of less than $0.01&lt;/li&gt;
&lt;li&gt;Allows the user to specify shelving location, collection code, item type, and source of acquisition&lt;/li&gt;
&lt;li&gt;sorted by standard NExpress classification scheme&lt;/li&gt;
&lt;li&gt;links to the "Edit item" page for each item&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;The sources of acquisition in the database appear to be “AMAZON,” “AUTHOR,” “CENTER POINT,” “CHILDREN'S PLUS,” “Donation,” “GALE,” “INGRAM,” “INGRAMS,” “MIDWEST TAPE,” “MIDWEST TAPES,” “NEW READERS PRESS,” “OMNIGRAPHICS,” "PUBLISHER DIRECT," "RECATALOG," “RECORDED BOOKS,” and “TURN THE PAGE KC.”  If staff want to limit to one source, they can enter the exact name of the source in the "Source of acquisition" field in this report, or, since Ingram appears to be spelled two different ways, staff can type "Ing%" to get all items from Ingram - even if "Ingram" is misspelled in the item record.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2924=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('', biblio.biblionumber, '') AS
  LINK_TO_ITEM,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned,
  Coalesce(items.booksellerid, "-") AS SOURCE,
  Coalesce(items.price, 0) AS PRICE,
  items.price,
  items.replacementprice
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  JOIN biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.dateaccessioned BETWEEN &lt;&gt; AND &lt;&gt; AND
  items.homebranch = "BONNERSPGS" AND
  items.location LIKE &lt;&gt; AND
  items.itype LIKE &lt;&gt; AND
  items.ccode LIKE &lt;&gt; AND
  Coalesce(items.booksellerid, "-") LIKE Concat("%", &lt;&gt;, "%") AND
  Coalesce(items.price, 0) &lt; .01
GROUP BY
  items.barcode
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title
LIMIT 10000

























