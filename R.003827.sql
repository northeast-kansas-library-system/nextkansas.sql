/*
R.003827

----------

Name: GHW - Basic collection code list
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-11 16:22:00
Modified on: 2024-08-07 22:44:08
Date last run: 2025-05-05 09:59:55

----------

Public: 0
Expiry: 300

----------

Collection codes where the  "COLLECTION_CODE_DESCRIPTION_OPAC" = "Z" are in the process of being removed from the system.

Collection codes with descriptions containing a colon will be renamed with a - on January 1, 2025.

----------
*/



SELECT 
  authorised_values.lib AS COLLECTION_CODE_DESCRIPTION, 
  authorised_values.lib_opac AS COLLECTION_CODE_DESCRIPTION_OPAC, 
  authorised_values.authorised_value AS COLLECTION_CODE_CODE 
FROM 
  authorised_values 
WHERE 
  authorised_values.category = 'CCODE' 
ORDER BY 
  authorised_values.lib 
LIMIT 2500 

























