/*
R.003070

----------

Name: GHW - Z39.50 Backup - ADMINREPORT
Created by: George H Williams

----------

Group: Administrative Reports
     System-admin

Created on: 2018-04-12 15:04:40
Modified on: 2018-09-18 15:12:27
Date last run: 2018-09-18 14:51:37

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws("<br />",
    Concat("Name: ", z3950servers.servername),
    Concat("Host name: ", z3950servers.host),
    Concat("Port: ", z3950servers.port),
    Concat("Database name: ", z3950servers.db),
    Concat("Syntax: ",  z3950servers.syntax),
    Concat("Encoding: ", z3950servers.encoding),
    Concat("Record type: ", z3950servers.recordtype),
    "<br />"
  ) AS SERVERS
FROM
  z3950servers
WHERE
  z3950servers.userid = ""
GROUP BY
  z3950servers.recordtype,
  z3950servers.id

























