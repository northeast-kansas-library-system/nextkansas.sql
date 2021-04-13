/*
R.003473

----------

Name: GHW- Median collection age ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-03-04 10:27:13
Modified on: 2021-03-04 20:12:50
Date last run: 2021-03-04 22:26:17

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.homebranch,
  biblioitems.publicationyear AS MEDIAN_COLLECTION_AGE
FROM
  biblioitems JOIN
  items ON items.biblioitemnumber = biblioitems.biblioitemnumber
WHERE
  items.homebranch = <<Choose your library|branches>> AND
  biblioitems.publicationyear < Year(Now()) AND
  biblioitems.publicationyear REGEXP '^[0-9]+$'
GROUP BY
  items.homebranch,
  biblioitems.publicationyear,
  items.itemnumber
ORDER BY
  MEDIAN_COLLECTION_AGE



