/*
R.002346

----------

Name: Records with 024s
Created by: Heather Braum

----------

Group: Administrative Reports
     Duplicate Records-admin

Created on: 2014-09-01 16:56:33
Modified on: 2017-12-18 15:40:39
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblionumber,'\">',biblionumber,'</a>')
AS bibnumber 
FROM 
(SELECT biblionumber, ExtractValue(metadata,'//datafield[@tag="024"]/subfield[@code>="a"]') AS upc
FROM biblio_metadata) AS upcs 
WHERE upc <> ''



