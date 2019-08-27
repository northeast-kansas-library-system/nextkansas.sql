/*
R.002976

----------

Name: GHW - Eudora items checked out and not on hold for NE-EUDORA-ILL (1003008008668)
Created by: George H Williams

----------

Group: Library-Specific
     Eudora

Created on: 2017-07-11 13:56:34
Modified on: 2017-12-19 09:37:37
Date last run: 2017-09-11 13:39:43

----------

Public: 0
Expiry: 300

----------

<p><span style="background-color: darkred; color: white">Needs metadata conversion post 17.05</p>

----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">',
  biblio.biblionumber, '</a>') AS LINK_TO_TITLE,
  items.itemnumber,
  items.homebranch,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  Sum((Coalesce(items.issues, 0)) + Coalesce(items.renewals, 0)) AS CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT,
  If(Sum(Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) + Coalesce(items.withdrawn, 0)) = 0, 'No',
  'Yes') AS STATUS_PROBLEMS,
  items.itemnotes,
  items.itemnotes_nonpublic,
  reservesss.borrowernumber
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  INNER JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND items.biblionumber =
    biblio_metadata.biblionumber
  LEFT JOIN (SELECT
      reserves.itemnumber,
      reserves.borrowernumber
    FROM
      reserves) reservesss ON items.itemnumber = reservesss.itemnumber
WHERE
  items.homebranch LIKE "EUDORA" AND
  items.location LIKE <<Choose shelving location|LLOC>> AND
  items.itype LIKE <<Choose item type|LITYPES>> AND
  items.ccode LIKE <<Choose collection code|LCCODE>> AND
  items.onloan IS NOT NULL AND
  (reservesss.borrowernumber <> 104528 OR
    reservesss.borrowernumber IS NULL)
GROUP BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  items.barcode,
  items.enumchron,
  biblio.title,
  reservesss.borrowernumber



