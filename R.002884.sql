/*
R.002884

----------

Name: GHW - Flexible INV for NF
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-01-13 10:42:53
Modified on: 2017-12-19 09:31:17
Date last run: 2017-09-11 13:44:44

----------

Public: 0
Expiry: 0

----------


<p><span style="background-color: darkred; color: white">Needs metadata conversion post 17.05</p>

----------
*/

SELECT
  items.homebranch,
  items.holdingbranch,
  Coalesce(items.location, '') AS LOCATION,
  Coalesce(items.itype, '') AS ITYPE,
  Coalesce(items.ccode, '') AS CCODE,
  items.itemcallnumber,
  items.barcode,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  Concat_Ws(' ', ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="a"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="v"]')) AS SERIES,
  items.onloan,
  If(items.onloan IS NULL, '0', '1') AS CHECKED_OUT,
  If(Sum(items.damaged + items.itemlost + items.withdrawn) = 0, '0', '1') AS STATUS_PROBLEM,
  items.issues AS CKO_COUNT,
  items.renewals AS REN_COUNT,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  If(items.itemcallnumber LIKE " %", Trim(LEADING " " FROM items.itemcallnumber),
    If(items.itemcallnumber LIKE "  %", Trim(LEADING "  " FROM items.itemcallnumber),
    If(items.itemcallnumber LIKE "   %", Trim(LEADING "   " FROM items.itemcallnumber), items.itemcallnumber))) AS ALPHACALL,
  If(biblio.author LIKE "%., ", SubString(biblio.author FROM 1 FOR  Char_Length(biblio.author) - 3 ),
    If(biblio.author LIKE "%.,", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 2 ),
    If(biblio.author LIKE "%. ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 2 ),
    If(biblio.author LIKE "%, ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 2 ),
    If(biblio.author LIKE "%.", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 1 ),
    If(biblio.author LIKE "%,", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 1 ),
    If(biblio.author LIKE "% ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 1 ), biblio.author))))))) AS ALPHAAUTHOR,
  If(biblio.title LIKE "The %", Trim(LEADING "The " FROM biblio.title),
    If(biblio.title LIKE "A %", Trim(LEADING "A " FROM biblio.title),
    If(biblio.title LIKE "An %", Trim(LEADING "An " FROM biblio.title),
    If(biblio.title LIKE "'%", Trim(LEADING "'" FROM biblio.title),
    If(biblio.title LIKE '"%', Trim(LEADING '"' FROM biblio.title), biblio.title))))) AS ALPHATITLE,
  If(items.itemnumber IN (SELECT branchtransfers.itemnumber FROM branchtransfers WHERE branchtransfers.datearrived IS NULL), "1", "0") AS IN_TRANSIT,
  If(items.itemnumber IN (SELECT reserves.itemnumber FROM reserves WHERE reserves.waitingdate IS NULL), "1", "0") AS ON_HOLD
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  (items.homebranch LIKE "%") AND
   Coalesce(items.location, '') LIKE "ADULT" AND
   items.itype LIKE <<Choose item type|LITYPES>> AND
   (items.ccode = 'BIOGRAPHY' OR items.ccode = 'NONFICTION')
GROUP BY
  items.barcode
ORDER BY
  ALPHACALL,
  ALPHAAUTHOR,
  ALPHATITLE



