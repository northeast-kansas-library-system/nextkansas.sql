/*
R.003056

----------

Name: GHW - BLIC test
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-03-05 10:29:27
Modified on: 2018-03-16 11:06:21
Date last run: 2019-11-19 12:34:32

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  BLICSQ.BRANCH_NAMES,
  BLICSQ.LOCATIONS,
  BLICSQ.ITEM_TYPE_NAME,
  BLICSQ.CCODES,
  IF(Coalesce(ITEMSSQ.Count_itemnumber, "--") = "--", "--", CONCAT("<span style='color: red; font-weight: bold; font-size: 120%'>", ITEMSSQ.Count_itemnumber, "</span>")) AS COUNT_OF_ITEMS,
  Concat('<a href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=2731&phase=Run+this+report&sql_params=',
  BLICSQ.branchcode, '&sql_params=', BLICSQ.LOC_AV, '&sql_params=', BLICSQ.ITYPE_VAL, '&sql_params=', BLICSQ.CCODE_AV, '&sql_params=%25&sql_params=12%2F31%2F2050&sql_params=12%2F31%2F2050&sql_params=12%2F31%2F2050&sql_params=999999999999&sql_params=%25&sql_params=%25\" target="_blank">Open in report 2731</a>') AS LINK_TO_REPORT
FROM
    (SELECT
        branches.branchcode,
        branches.branchname AS BRANCH_NAMES,
        LOCATIONSQ.authorised_value AS LOC_AV,
        LOCATIONSQ.lib AS LOCATIONS,
        itemtypes.itemtype AS ITYPE_VAL,
        itemtypes.description AS ITEM_TYPE_NAME,
        CCODESQ.authorised_value AS CCODE_AV,
        CCODESQ.lib AS CCODES
      FROM
        branches,
          (SELECT
              authorised_values.category,
              authorised_values.authorised_value,
              authorised_values.lib
            FROM
              authorised_values
            WHERE
              authorised_values.category = 'LOC'
            GROUP BY
              authorised_values.category,
              authorised_values.authorised_value,
              authorised_values.lib) LOCATIONSQ,
        itemtypes,
          (SELECT
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
              authorised_values.lib) CCODESQ
      WHERE
        branches.branchcode LIKE <<Choose your library|ZBRAN>> AND
        LOCATIONSQ.authorised_value LIKE <<Choose a shelving location|LLOC>> AND
        itemtypes.itemtype LIKE <<Choose an item type|itemtypes>>
      GROUP BY
        branches.branchcode,
        branches.branchname,
        LOCATIONSQ.authorised_value,
        LOCATIONSQ.lib,
        itemtypes.itemtype,
        itemtypes.description,
        CCODESQ.authorised_value,
        CCODESQ.lib) BLICSQ
  LEFT JOIN (SELECT
        Count(items.itemnumber) AS Count_itemnumber,
        items.homebranch,
        items.itype,
        If(items.ccode IS NULL, "---", items.ccode) AS CCODEX,
        If(items.location IS NULL, "---", items.location) AS LOCATIONX
      FROM
        items
      GROUP BY
        items.homebranch,
        items.itype,
        If(items.ccode IS NULL, "---", items.ccode),
        If(items.location IS NULL, "---", items.location)) ITEMSSQ ON BLICSQ.ITYPE_VAL = ITEMSSQ.itype AND
    BLICSQ.LOC_AV = ITEMSSQ.LOCATIONX AND BLICSQ.CCODE_AV = ITEMSSQ.CCODEX AND BLICSQ.branchcode = ITEMSSQ.homebranch
GROUP BY
  BLICSQ.BRANCH_NAMES,
  BLICSQ.LOCATIONS,
  BLICSQ.ITEM_TYPE_NAME,
  BLICSQ.CCODES



