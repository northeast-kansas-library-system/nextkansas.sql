/*
R.003191

----------

Name: FFTEST
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-03-29 14:33:13
Modified on: 2019-03-31 02:30:57
Date last run: 2019-04-12 14:28:00

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  items.itemnumber,
  IF(items.homebranch IS NULL, "", CONCAT("<br />(Item owned by: ", items.homebranch, ") ")) AS RESULT
FROM
  items



