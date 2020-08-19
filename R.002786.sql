/*
R.002786

----------

Name: GHW - Flexible New Items Report
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-10-05 14:39:48
Modified on: 2019-05-30 13:01:13
Date last run: 2020-07-13 16:08:30

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>This report shows all items added to NExpress at a specific library branch during a date range</p>
<ul><li>Shows items that are currently still in NExpress</li>
<li>Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added</li>
<li>grouped by date added, homebranch, location, itype, collection code, and call number</li>
<li>sorted by homebranch, location, itype, collection code, and call number</li>
<li>contains links directly to the item's bibliographic record</li>
</ul><br />
</div>

----------
*/

SELECT
  CONCAT( '<a href=https://catalog.nexpresslibrary.org/cgi-bin/koha/opac-detail.pl?biblionumber=', biblio.biblionumber,'\" target="_blank">', biblio.biblionumber, '</a>' ) AS LINK_TO_OPAC,
  items.homebranch,
  items.barcode,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  CONCAT_WS(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]') ) AS FULL_TITLE,
  items.dateaccessioned,
  IF(items.onloan IS NULL,' ','Currently checked out') AS CHECKED_OUT,
  IF(SUM(items.damaged + items.itemlost + items.withdrawn)=0,' ','Damaged, lost, or withdrawn') AS STATUS_PROBLEMS
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
    items.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch LIKE <<Item home library|LBRANCH>> AND
  items.location LIKE <<Item shelving location|LLOC>> AND
  items.itype LIKE <<Item type|LITYPES>> AND
  items.ccode LIKE <<Item collection code|LCCODE>> AND
  items.dateaccessioned BETWEEN <<Start date|date>> AND <<end date|date>>
GROUP BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  items.enumchron,
  biblio.author,
  biblio.title
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title DESC



