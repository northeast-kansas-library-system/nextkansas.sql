/*
R.002758

----------

Name: Authors with possible duplicates
Created by: Heather Braum

----------

Group: Administrative Reports
     Post-Lansing

Created on: 2016-09-04 16:38:55
Modified on: 2019-02-10 20:54:14
Date last run: 2026-01-09 14:40:31

----------

Public: 0
Expiry: 0

----------

Backwards - start at page 55

----------
*/



SELECT
  Concat(
     'Run targeted search'
  ) AS ASEARCH,
  Concat(
    '',
    Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""),
    ''
  ) AS "Author Search",
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", "") AS AUTHOR,
  Count(items.itemnumber)
FROM
  biblio
  JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  items.homebranch = 'HIGH_CC'
GROUP BY
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", "")
HAVING
  Count(items.itemnumber) &gt; 1
ORDER BY
  Count(items.itemnumber) DESC

























