/*
R.003264

----------

Name: GHW - MAFIA - draft
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-10 19:19:35
Modified on: 2019-09-12 00:51:35
Date last run: 2020-03-09 13:33:29

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws("", '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link to title</a>') AS LINK,
  Concat("-", items.barcode, "-") AS BC,
  items.homebranch AS OWNING_LIB,
  items.holdingbranch AS CURRENT_LIB,
  locs.lib AS LOCATION,
  Concat(itypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author AS AUTHOR,
  biblio.title AS TITLE,
  items.datelastseen AS LAST_SEEN_ON,
  Concat_Ws("", "Sent from ", branchtransfers.frombranch, " to ", branchtransfers.tobranch, " on ", branchtransfers.datesent) AS STATUS
FROM
  (items
  JOIN branchtransfers
    ON items.itemnumber = branchtransfers.itemnumber)
  JOIN biblio
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      itemtypes.description,
      itemtypes.itemtype
    FROM
      itemtypes
  ) itypes
    ON itypes.itemtype = items.itype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes
    ON ccodes.authorised_value = items.ccode
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs
    ON locs.authorised_value = items.location
WHERE
  items.datelastseen BETWEEN (<<Start date|date>>) AND (<<end date|date>>) AND
  branchtransfers.datearrived IS NULL AND
  ((items.homebranch = <<Choose your library|branches>>) OR
    (branchtransfers.frombranch = <<Choose your library|branches>>) OR
    (branchtransfers.tobranch = <<Choose your library|branches>>))
GROUP BY
  locs.lib,
  ccodes.lib,
  items.barcode
UNION
SELECT
  Concat_Ws("", '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link to title</a>') AS LINK,
  Concat("-", items.barcode, "-") AS BC,
  items.homebranch AS OWNING_LIB,
  items.holdingbranch AS CURRENT_LIB,
  Coalesce(locs.lib, "-") AS LOCATION,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author AS AUTHOR,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')) AS TITLE,
  items.datelastseen AS LAST_SEEN_ON,
  Concat_Ws("", losts.lib, " on ", items.itemlost_on) AS STATUS
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON items.ccode = ccodes.authorised_value
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN itemtypes
    ON items.itype = itemtypes.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
  ) nfl
    ON nfl.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damageds
    ON damageds.authorised_value = items.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = items.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawns
    ON withdrawns.authorised_value = items.withdrawn
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs
    ON locs.authorised_value = items.location
WHERE
  items.onloan IS NULL AND
  items.homebranch = <<Choose your library|branches>> AND
  (items.itemlost = 9 OR
    items.itemlost = 3) AND
  items.itemlost_on BETWEEN (<<Start date|date>>) AND (<<end date|date>>)
GROUP BY
  items.itemlost_on,
  biblio.biblionumber,
  items.itemnumber,
  damageds.lib,
  items.damaged_on
UNION
SELECT
  Concat_Ws("", '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link to title</a>') AS LINK,
  Concat("-", items.barcode, "-") AS BC,
  items.homebranch AS OWNING_LIB,
  items.holdingbranch AS CURRENT_LIB,
  Coalesce(locs.lib, "-") AS LOCATION,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author AS AUTHOR,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')) AS TITLE,
  items.datelastseen AS LAST_SEEN_ON,
  Concat_Ws("", losts.lib, " on ", items.itemlost_on) AS STATUS
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON items.ccode = ccodes.authorised_value
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN itemtypes
    ON items.itype = itemtypes.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
  ) nfl
    ON nfl.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damageds
    ON damageds.authorised_value = items.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = items.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawns
    ON withdrawns.authorised_value = items.withdrawn
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs
    ON locs.authorised_value = items.location
WHERE
  items.onloan IS NULL AND
  items.homebranch = <<Choose your library|branches>> AND
  items.itemlost <> 9 AND
  items.itemlost <> 3 AND
  items.itemlost_on BETWEEN (<<Start date|date>>) AND (<<end date|date>>)
GROUP BY
  items.itemlost_on,
  biblio.biblionumber,
  items.itemnumber,
  damageds.lib,
  items.damaged_on
UNION
SELECT
  Concat_Ws("", '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link to title</a>') AS LINK,
  Concat("-", items.barcode, "-") AS BC,
  items.homebranch AS OWNING_LIB,
  items.holdingbranch AS CURRENT_LIB,
  Coalesce(locs.lib, "-") AS LOCATION,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author AS AUTHOR,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')) AS TITLE,
  items.datelastseen AS LAST_SEEN_ON,
  Concat_Ws("", Coalesce(locs.lib, "NO SHELVING LOCATION"), " since at least ", items.timestamp) AS STATUS
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON items.ccode = ccodes.authorised_value
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN itemtypes
    ON items.itype = itemtypes.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
  ) nfl
    ON nfl.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damageds
    ON damageds.authorised_value = items.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = items.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawns
    ON withdrawns.authorised_value = items.withdrawn
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs
    ON locs.authorised_value = items.location
WHERE
  items.onloan IS NULL AND
  items.homebranch = <<Choose your library|branches>> AND
  (items.location = 'PROC' OR
    items.location = 'CATALOGING' OR
    items.location = 'CART' OR
    items.location IS NULL) AND
  items.timestamp BETWEEN (<<Start date|date>>) AND (<<end date|date>>)
GROUP BY
  biblio.biblionumber,
  items.itemnumber
UNION
SELECT
  Concat_Ws("", '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Link to title</a>') AS LINK,
  Concat("-", items.barcode, "-") AS BC,
  items.homebranch AS OWNING_LIB,
  items.holdingbranch AS CURRENT_LIB,
  Coalesce(locs.lib, "-") AS LOCATION,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author AS AUTHOR,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')) AS TITLE,
  items.datelastseen AS LAST_SEEN_ON,
  Concat_Ws("", nfl.lib, " since ", items.dateaccessioned) AS STATUS
FROM
  biblio
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccodes
    ON items.ccode = ccodes.authorised_value
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber AND
      items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN itemtypes
    ON items.itype = itemtypes.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
  ) nfl
    ON nfl.authorised_value = items.notforloan
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGED'
  ) damageds
    ON damageds.authorised_value = items.damaged
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = items.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) withdrawns
    ON withdrawns.authorised_value = items.withdrawn
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locs
    ON locs.authorised_value = items.location
WHERE
  items.homebranch = <<Choose your library|branches>> AND
  items.dateaccessioned BETWEEN (<<Start date|date>>) AND (<<end date|date>>) AND
  items.notforloan = -1
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  OWNING_LIB,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  AUTHOR,
  TITLE,
  BC

























