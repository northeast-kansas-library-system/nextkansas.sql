/*
R.003206

----------

Name: GHW -X
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-05-22 23:43:09
Modified on: 2022-12-03 09:58:02
Date last run: 2023-02-09 10:25:41

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  items.itemnumber
FROM
  items
WHERE
  items.permanent_location = 'ADULT' AND
  items.homebranch LIKE <<Library|ZBRAN>>

























