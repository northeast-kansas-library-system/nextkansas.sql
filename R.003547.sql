/*
R.003547

----------

Name: GHW - Circulation statistics by biblio number and item home library
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-08-03 16:04:25
Modified on: 2021-08-03 16:04:25
Date last run: 2021-08-03 16:05:30

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  biblio.title,
  Count(statistics.datetime) AS Count_datetime
FROM
  biblio JOIN
  items ON items.biblionumber = biblio.biblionumber JOIN
  statistics ON statistics.itemnumber = items.itemnumber
WHERE
  (statistics.type = 'issue' OR
    statistics.type = 'renew') AND
  Year(statistics.datetime) = 2021 AND
  Month(statistics.datetime) = 6 AND
  biblio.biblionumber LIKE <<Enter a biblio number>> AND
  items.homebranch Like <<Choose the items' home library|LBRANCH>>
GROUP BY
  biblio.biblionumber,
  biblio.title

























