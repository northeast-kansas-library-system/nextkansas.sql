/*
R.003819

----------

Name: GHW - Bib level CCODE count
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-28 18:02:07
Modified on: 2024-03-28 18:02:07
Date last run: 2024-03-29 15:19:08

----------

Public: 0
Expiry: 300

----------

 - links to records by itype

----------
*/



SELECT
  ccodes.authorised_value,
  biblioitems.cn_class,
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
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      biblioitems.cn_class
GROUP BY
  ccodes.authorised_value,
  biblioitems.cn_class

























