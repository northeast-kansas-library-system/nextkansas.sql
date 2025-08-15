/*
R.003786

----------

Name: GHW - Basic shelving locations list
Created by: George Williams

----------

Group: -
     -

Created on: 2023-11-20 18:03:06
Modified on: 2024-04-11 15:29:46
Date last run: 2024-04-11 15:29:52

----------

Public: 0
Expiry: 300

----------

 
  Simple list of all current shelving locations
  
    Shows current locations
    system-wide
    grouped by code
    sorted by location
    links
  
  Notes:
  
  
  #neststeps #locations
  


----------
*/



SELECT
  authorised_values.lib AS SHELVING_LOCATION,
  authorised_values.authorised_value AS LOCATION_CODE
FROM
  authorised_values
WHERE
  authorised_values.category = 'LOC'
GROUP BY
  authorised_values.authorised_value
ORDER BY
  SHELVING_LOCATION

























