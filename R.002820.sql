/*
R.002820

----------

Name: GHW - Flexible Inventory List
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-11-08 15:24:15
Modified on: 2017-12-19 09:30:37
Date last run: 2022-01-09 13:13:46

----------

Public: 0
Expiry: 0

----------

Currently configured for Overbrook
<p><span style="background-color: blue; color: white">Metadata conversion is done on test server.  Update this SQL with SQL from the same report on the test server after the 17.05 upgrade.</p>

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
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  Concat_Ws(' ', ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="a"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="490"]/subfield[@code="v"]'))AS SERIES,
  items.onloan,
  If(items.onloan IS NULL, '0', '1') AS CHECKED_OUT,
  If(Sum(items.damaged + items.itemlost + items.withdrawn) = 0, '0', '1') AS STATUS_PROBLEM,
  If(items.itemcallnumber RLIKE "^CD [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
    If(items.itemcallnumber RLIKE "^INS [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^INSP [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 8 ),
	If(items.itemcallnumber LIKE "FIC %", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^BLU [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^COL [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^DVD [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^FM [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^FW [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^INS [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^INSP [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 8 ),
	If(items.itemcallnumber RLIKE "^J DVD [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 9 ),
	If(items.itemcallnumber RLIKE "^JB [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^JBB [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^JE [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^JF [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^JP [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^LPF [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^LPM [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^LPW [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^MCD [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^SF [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ),
	If(items.itemcallnumber RLIKE "^SFF [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^WII [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 7 ),
	If(items.itemcallnumber RLIKE "^YA [a-zA-Z]", SubString(items.itemcallnumber FROM 1 FOR 6 ), items.itemcallnumber))))))))))))))))))))))))) AS ALPHACALL,
  If(items.itemcallnumber LIKE "%#%", SubString_Index(items.itemcallnumber, "#", -1), "") AS ALPHASERIES,
  If(biblio.author LIKE "%., ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 3 ),
  If(biblio.author LIKE "%.,", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 2 ),
    If(biblio.author LIKE "%. ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 2 ),
	If(biblio.author LIKE "%, ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 2 ),
	If(biblio.author LIKE "%.", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 1 ),
	If(biblio.author LIKE "%,", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 1 ),
	If(biblio.author LIKE "% ", SubString(biblio.author FROM 1 FOR Char_Length(biblio.author) - 1 ), biblio.author))))))) AS ALPHAAUTHOR,
  If(biblio.title Like "The %", Trim(Leading "The " From biblio.title),
    If(biblio.title Like "A %", Trim(Leading "A " From biblio.title),
    If(biblio.title Like "An %", Trim(Leading "An " From biblio.title),
    If(biblio.title Like "'%", Trim(Leading "'" From biblio.title),
    If(biblio.title Like '"%', Trim(Leading '"' From biblio.title), biblio.title))))) AS ALPHATITLE,
  If(items.itemnumber IN (SELECT branchtransfers.itemnumber FROM branchtransfers WHERE branchtransfers.datearrived IS NULL), "1", "0") AS IN_TRANSIT,
  If(items.itemnumber IN (SELECT reserves.itemnumber FROM reserves WHERE reserves.waitingdate IS NULL), "1", "0") AS ON_HOLD
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber INNER JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  items.homebranch LIKE <<Select home branch|ZBRAN>> AND
  Coalesce(items.location, '') LIKE <<Shelving location|LLOC>> AND
  Coalesce(items.itype, '') LIKE <<Item type|LITYPES>> AND
  Coalesce(items.ccode, '') LIKE <<Collection code|LCCODE>>
GROUP BY
  items.barcode
HAVING
  CHECKED_OUT LIKE <<Display items that are checked out|YES_NO>> AND
  STATUS_PROBLEM LIKE <<Display items with status problems|YES_NO>> AND
  IN_TRANSIT LIKE <<Display items that are in transit|YES_NO>> AND
  ON_HOLD LIKE <<Display items on hold|YES_NO>> 
ORDER BY
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  ALPHACALL,
  ALPHASERIES,
  ALPHAAUTHOR,
  ALPHATITLE

























