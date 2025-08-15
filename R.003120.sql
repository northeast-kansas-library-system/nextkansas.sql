/*
R.003120

----------

Name: GHW - Z39.50 targets
Created by: George Williams

----------

Group: -
     -

Created on: 2018-09-15 11:22:32
Modified on: 2024-01-17 11:57:53
Date last run: 2024-03-06 14:10:09

----------

Public: 0
Expiry: 300

----------

 
Generates basic Z39.50 list (makes it easy to share with other people)
Shows current Z39.50 list used by Next Search Catalog
does not include Z39.50 targets that require a username/password for access
grouped by server ID number
sorted by server type and server name

Notes:

Good report for sharing Z39.50 data with other libraries.

Click here to run in a new window
Click here to download as a csv file


----------
*/



SELECT
  z3950servers.servername AS SERVER_NAME,
  z3950servers.host AS HOSTNAME,
  z3950servers.port AS PORT,
  z3950servers.db AS `DATABASE`,
  z3950servers.syntax,
  z3950servers.encoding,
  z3950servers.recordtype AS RECORD_TYPE
FROM
  z3950servers
WHERE
  z3950servers.userid LIKE ""
GROUP BY
  z3950servers.id
ORDER BY
  RECORD_TYPE DESC,
  SERVER_NAME

























