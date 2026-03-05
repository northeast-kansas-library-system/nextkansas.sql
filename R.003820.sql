/*
R.003820

----------

Name: GHW - Bib level LOC count
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-28 18:08:23
Modified on: 2024-03-28 18:08:23
Date last run: 2024-04-11 14:33:47

----------

Public: 0
Expiry: 300

----------

 - links to records by loc

----------
*/



SELECT
  locs.authorised_value,
  biblioitems.agerestriction,
  Count(DISTINCT biblioitems.biblionumber) AS Count_biblionumber
FROM
  biblioitems LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      biblioitems.agerestriction
GROUP BY
  locs.authorised_value,
  biblioitems.agerestriction

























