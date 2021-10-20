/*
R.002924

----------

Name: GHW - BONNERSPGS price repair
Created by: George H Williams

----------

Group:  BONNERSPGS
     -

Created on: 2017-03-17 16:59:13
Modified on: 2021-08-16 20:41:35
Date last run: 2019-12-26 17:27:38

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Report for Bonner Springs to help add discounted costs of items to records</p>
<ul><li>Shows items added in the date range you specify</li>
<li>Shows items owned by Bonner Springs with a value in the 952g field of less than $0.01</li>
<li>Allows the user to specify shelving location, collection code, item type, and source of acquisition</li>
<li>sorted by standard NExpress classification scheme</li>
<li>links to the "Edit item" page for each item</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>The sources of acquisition in the database appear to be “AMAZON,” “AUTHOR,” “CENTER POINT,” “CHILDREN'S PLUS,” “Donation,” “GALE,” “INGRAM,” “INGRAMS,” “MIDWEST TAPE,” “MIDWEST TAPES,” “NEW READERS PRESS,” “OMNIGRAPHICS,” "PUBLISHER DIRECT," "RECATALOG," “RECORDED BOOKS,” and “TURN THE PAGE KC.”  If staff want to limit to one source, they can enter the exact name of the source in the "Source of acquisition" field in this report, or, since Ingram appears to be spelled two different ways, staff can type "Ing%" to get all items from Ingram - even if "Ingram" is misspelled in the item record.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2924=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('<a href=https://staff.nexpresslibrary.org/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', items.biblionumber, '&itemnumber=', items.itemnumber, '\" target="_blank">', biblio.biblionumber, '</a>') AS
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
  items.dateaccessioned BETWEEN <<Items added after|date>> AND <<but before|date>> AND
  items.homebranch = "BONNERSPGS" AND
  items.location LIKE <<Enter shelving location|LLOC>> AND
  items.itype LIKE <<Enter item type|LITYPES>> AND
  items.ccode LIKE <<Enter item collection code|LCCODE>> AND
  Coalesce(items.booksellerid, "-") LIKE Concat("%", <<Enter the name, or part of the name, of the acquisition source>>, "%") AND
  Coalesce(items.price, 0) < .01
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

























