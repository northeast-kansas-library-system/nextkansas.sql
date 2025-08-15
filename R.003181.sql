/*
R.003181

----------

Name: GHW - Checkouts and renewals by title and item type
Created by: George Williams

----------

Group: -
     -

Created on: 2019-03-04 16:13:12
Modified on: 2024-01-17 11:55:01
Date last run: 2024-08-26 22:20:19

----------

Public: 0
Expiry: 300

----------

 
Gives a circulation count by title and item type
Shows items checkedout in the previous calendar month
at the library you specify
grouped and sorted by library, year, month, itemtype and title

Notes:

Click here to run in a new window


----------
*/



SELECT
  statistics.branch,
  Year(statistics.datetime) AS YEAR,
  Month(statistics.datetime) AS MONTH,
  itemtypes.description AS ITYPE,
  Coalesce(biblio.title, biblio1.title) AS TITLE,
  Count(*) AS CKO_RENEW_COUNT
FROM
  statistics
  LEFT JOIN items ON items.itemnumber = statistics.itemnumber
  LEFT JOIN deleteditems ON deleteditems.itemnumber = statistics.itemnumber
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN biblio biblio1 ON biblio1.biblionumber = deleteditems.biblionumber
  INNER JOIN itemtypes ON itemtypes.itemtype = statistics.itemtype
WHERE
  statistics.branch LIKE &lt;&gt; AND
  statistics.itemtype LIKE &lt;&gt; AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  (statistics.type = 'ISSUE' OR
    statistics.type = 'RENEW')
GROUP BY
  statistics.branch,
  Year(statistics.datetime),
  Month(statistics.datetime),
  itemtypes.description,
  Coalesce(biblio.title, biblio1.title)
ORDER BY
  statistics.branch,
  YEAR,
  MONTH,
  ITYPE,
  TITLE

























