/*
R.003474

----------

Name: GHW - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-04 18:30:04
Modified on: 2021-03-04 19:23:30
Date last run: 2021-03-04 22:58:11

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  @1:="5175" AS "expiry year",
  branches.branchcode,
  Max(Query1.publicationyear) AS MEDIAN_COLLECTION_AGE
FROM
  branches JOIN
  (SELECT
      items.homebranch,
      items.itemnumber,
      biblioitems.publicationyear
    FROM
      biblioitems JOIN
      items ON items.biblioitemnumber = biblioitems.biblioitemnumber
    WHERE
      items.homebranch LIKE <<Choose your library|LBRANCH>> AND
      biblioitems.publicationyear < Year(Now()) AND
      biblioitems.publicationyear REGEXP '^[0-9]+$'
    GROUP BY
      items.homebranch,
      items.itemnumber,
      biblioitems.publicationyear
    ORDER BY
      biblioitems.publicationyear
    ) Query1 ON Query1.homebranch = branches.branchcode
GROUP BY
  branches.branchcode

























