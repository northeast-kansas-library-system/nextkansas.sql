/*
R.003549

----------

Name: 942e - Blank or way off
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-08-06 11:01:19
Modified on: 2022-12-05 16:08:19
Date last run: 2022-12-13 10:04:26

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblioitems.biblionumber
FROM
  biblioitems
WHERE
  biblioitems.agerestriction LIKE "" OR 
  biblioitems.agerestriction IS NULL
GROUP BY
  biblioitems.biblionumber
/*
HAVING Group_Concat_permanent_location like "%ADULT%"
HAVING Group_Concat_permanent_location like "%CHILD%"
HAVING Group_Concat_permanent_location like "%YA%"
*/
ORDER BY
  biblioitems.biblionumber

























