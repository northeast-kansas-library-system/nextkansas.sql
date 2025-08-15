/*
R.003817

----------

Name: GHW - Bib level item types count - links to records by itype
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-28 15:18:13
Modified on: 2024-03-29 15:25:04
Date last run: 2024-03-29 15:25:14

----------

Public: 0
Expiry: 300

----------

/cgi-bin/koha/reports/guided_reports.pl?reports=3818&phase=Run%20this%20report

----------
*/



SELECT
  biblioitems.itemtype AS BIB_ITYPE,
  itemtypes.itemtype AS itemtype1,
  Count(DISTINCT biblioitems.biblionumber) AS Count_biblionumber,
  IF(
    biblioitems.itemtype is null,
    Concat(
      '',
      'Null item types',
      ''
    ), 
    IF(
      itemtypes.itemtype is null, 
      Concat(
        '',
        'Problematic item types',
        ''
      ),
      Concat(
        '',
        'Itype list',
        ''
      )
    )
  ) AS RECORDS_BY_ITYPE
FROM
  biblioitems LEFT JOIN
  itemtypes ON itemtypes.itemtype = biblioitems.itemtype
GROUP BY
  biblioitems.itemtype,
  itemtypes.itemtype
LIMIT 500

























