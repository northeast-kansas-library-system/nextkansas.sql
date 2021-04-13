/*
R.003262

----------

Name: GHW - Multiple requests table
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-10 11:38:23
Modified on: 2019-09-11 16:10:30
Date last run: 2021-04-13 11:06:51

----------

Public: 0
Expiry: 3600

----------



----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', reservess.biblionumber, '\" target="_blank">Link to title</a>') AS GO_TO_RECORD,
  Concat_Ws("<br />", reservess.title, reservess.GMD) AS title,
  reservess.Count_reserve_id AS REQUESTS_AT_THIS_LIBRARY,
  Coalesce(localitems.Count_itemnumber, Concat("<span style='color: red;'>0</span>")) AS YOUR_LIBRARY_OWNS,
  totalitems.Count_itemnumber AS SYSTEM_WIDE_ITEM_COUNT,
  reservesx.Count_reserve_id AS SYSTEM_WIDE_REQUEST_COUNT
FROM
  (
    SELECT
      branches.branchname,
      branches.branchcode
    FROM
      branches
  ) branchess
  JOIN (
    SELECT
      reserves.branchcode,
      reserves.biblionumber,
      Count(reserves.reserve_id) AS Count_reserve_id,
      biblio.title,
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS GMD
    FROM
      reserves
      JOIN biblio
        ON reserves.biblionumber = biblio.biblionumber
      JOIN biblio_metadata
        ON biblio_metadata.biblionumber = biblio.biblionumber
    WHERE
      reserves.found IS NULL
    GROUP BY
      reserves.branchcode,
      reserves.biblionumber
    ORDER BY
      Count_reserve_id DESC
  ) reservess
    ON reservess.branchcode = branchess.branchcode
  LEFT JOIN (
    SELECT
      items.biblionumber,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM
      items
      JOIN reserves
        ON items.biblionumber = reserves.biblionumber
    GROUP BY
      items.biblionumber
  ) totalitems
    ON totalitems.biblionumber = reservess.biblionumber
  LEFT JOIN (
    SELECT
      items.biblionumber,
      items.homebranch,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM
      items
      JOIN reserves
        ON reserves.biblionumber = items.biblionumber
    WHERE
      items.homebranch = <<library1>>
    GROUP BY
      items.biblionumber
  ) localitems
    ON localitems.biblionumber = reservess.biblionumber
  INNER JOIN (
    SELECT
      reserves.biblionumber,
      Count(reserves.reserve_id) AS Count_reserve_id,
      reserves.found
    FROM
      reserves
    WHERE
      reserves.found IS NULL
    GROUP BY
      reserves.biblionumber,
      reserves.found
  ) reservesx
    ON reservesx.biblionumber = reservess.biblionumber
WHERE
  branchess.branchcode = <<library2>> AND
  ((reservess.Count_reserve_id > 1 AND
      Coalesce(localitems.Count_itemnumber, 0) = 0) OR
    (reservess.Count_reserve_id / totalitems.Count_itemnumber > 3))
GROUP BY
  Concat_Ws(" ", reservess.title, reservess.GMD),
  reservess.Count_reserve_id,
  totalitems.Count_itemnumber,
  reservesx.Count_reserve_id,
  reservess.biblionumber,
  localitems.Count_itemnumber,
  reservess.title,
  reservess.GMD
ORDER BY
  REQUESTS_AT_THIS_LIBRARY DESC,
  Coalesce(localitems.Count_itemnumber, 0) DESC,
  totalitems.Count_itemnumber ASC



