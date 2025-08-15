/*
R.002960

----------

Name: GHW - GitHub Notices and Slips report
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2017-06-23 11:25:44
Modified on: 2024-01-17 11:51:34
Date last run: 2024-07-08 16:41:47

----------

Public: 0
Expiry: 300

----------

 
Generates a report for converting notices and slips into text files for storage on GITHUB.
Shows current notice and slip data
at all NExpress locations
sorted by branchcode and lettercode

Notes:

Run this report and open the file in EXCEL.  Then run the macro to output the rows from this file into separate text files.
Click here to run in a new window


----------
*/



SELECT 
  Concat( 
    If(letter.branchcode = " ", "AAAAA", letter.branchcode), 
    "\\", 
    letter.code, 
    ".", 
    letter.lang, 
    ".", 
    letter.message_transport_type 
  ) AS FILE, 
  Concat( 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    Concat("Name: ", letter.name), 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    Concat("-----"), 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    letter.title, 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    Concat("-----"), 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    Concat("Message content:"), 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    Concat("----------"), 
    CHAR(13), CHAR(10), CHAR(13), CHAR(10), 
    letter.content 
  ) AS CONTENTS 
FROM 
  letter 
GROUP BY 
  FILE 
ORDER BY 
FILE

























