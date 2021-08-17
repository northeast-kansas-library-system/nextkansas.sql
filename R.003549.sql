/*
R.003549

----------

Name: 942e - Blank or way off
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-08-06 11:01:19
Modified on: 2021-08-09 09:35:01
Date last run: 2021-08-17 09:47:26

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
  biblioitems.agerestriction NOT LIKE "%ADULT%" AND 
  biblioitems.agerestriction NOT LIKE "%YA%" AND 
  biblioitems.agerestriction NOT LIKE "%CHILD%"
GROUP BY
  biblioitems.biblionumber,
  biblioitems.agerestriction
ORDER BY
  biblioitems.agerestriction



