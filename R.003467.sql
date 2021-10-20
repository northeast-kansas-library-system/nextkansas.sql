/*
R.003467

----------

Name: GHW - Update asc
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-02-28 19:40:20
Modified on: 2021-03-01 01:48:38
Date last run: 2021-03-01 21:25:27

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber,
  items.permanent_location,
  items.location
FROM
  items
WHERE
  (items.permanent_location = 'BALDYA') OR
  (items.location = 'BALDYA')
GROUP BY
  items.itemnumber,
  items.permanent_location,
  items.location
LIMIT 1000

























