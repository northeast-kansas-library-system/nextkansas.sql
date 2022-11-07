/*
R.003549

----------

Name: 942e - Blank or way off
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-08-06 11:01:19
Modified on: 2021-10-19 10:10:01
Date last run: 2022-11-06 21:37:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber,
  biblioitems.agerestriction,
  Group_Concat(items.permanent_location) AS Group_Concat_permanent_location
FROM
  biblioitems JOIN
  items ON items.biblioitemnumber = biblioitems.biblioitemnumber
WHERE
  biblioitems.agerestriction LIKE "" OR
  biblioitems.agerestriction is null OR
  (biblioitems.agerestriction NOT LIKE "%ADULT%" AND
  biblioitems.agerestriction NOT LIKE "%YA%" AND
  biblioitems.agerestriction NOT LIKE "%CHILD%")
GROUP BY
  biblioitems.biblionumber,
  biblioitems.agerestriction
/*
HAVING Group_Concat_permanent_location like "%ADULT%"
HAVING Group_Concat_permanent_location like "%CHILD%"
HAVING Group_Concat_permanent_location like "%YA%"
*/
ORDER BY
  biblioitems.agerestriction

























