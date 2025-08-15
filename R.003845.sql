/*
R.003845

----------

Name: GHW - Item types and CCODES counts
Created by: George Williams

----------

Group: -
     -

Created on: 2024-06-07 11:18:57
Modified on: 2024-06-07 11:18:57
Date last run: 2024-07-29 15:35:55

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  types_codes.description, 
  types_codes.lib, 
  Count(DISTINCT items.itemnumber) AS Count_itemnumber, 
  Concat_Ws( 
    '', 
    '2731' 
  ) AS LINK 
FROM ( 
    SELECT itemtypes.itemtype, 
      itemtypes.description, 
      authorised_values.lib, 
      authorised_values.category, 
      authorised_values.authorised_value 
    FROM itemtypes, 
      authorised_values 
    WHERE authorised_values.category = 'CCODE' 
  ) types_codes 
  JOIN items 
    ON items.itype = types_codes.itemtype 
    AND items.ccode = types_codes.authorised_value 
GROUP BY 
  types_codes.description, 
  types_codes.lib 
ORDER BY 
  types_codes.description, 
  types_codes.lib 

























