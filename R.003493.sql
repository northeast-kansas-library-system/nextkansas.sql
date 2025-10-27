/*
R.003493

----------

Name: GHW - Export authorised_values table
Created by: George Williams

----------

Group: -
     -

Created on: 2021-04-13 15:14:34
Modified on: 2025-08-15 14:03:06
Date last run: 2025-10-03 12:51:27

----------

Public: 0
Expiry: 300

----------

 
Outputs a backup of the authorised_values table to store on Github
Shows the authorised_values at the time the report is run
Shows all authorised values system wide
sorted by category and value

Notes:

Run monthly and output data to Next SQL wiki

Click here to download as a csv file
authorised_values backup github


----------
*/



SELECT
  authorised_values.id,
  authorised_values.category,
  authorised_values.authorised_value,
  authorised_values.lib,
  authorised_values.imageurl,
  authorised_values.lib_opac
FROM
  authorised_values
ORDER BY
  authorised_values.category,
  authorised_values.authorised_value

























