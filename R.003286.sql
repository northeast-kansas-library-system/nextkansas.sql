/*
R.003286

----------

Name: GHW - HCC Video problem
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-12-13 21:55:43
Modified on: 2019-12-13 21:56:18
Date last run: 2019-12-22 22:21:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat("https://staff.nextkansas.org/cgi-bin/koha/catalogue/detail.pl?biblionumber=", biblio.biblionumber) AS LINK,
  biblio.biblionumber,
  biblio.title,
  Count(items.itemnumber) AS ICOUNT
FROM
  biblio
  JOIN items
    ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch = 'HIGH_CC' AND
  items.itype LIKE "NVID%"
GROUP BY
  biblio.biblionumber
HAVING
  Count(items.itemnumber) > 1
ORDER BY
  Count(items.itemnumber) DESC

























