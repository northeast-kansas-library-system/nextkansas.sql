/*
R.001884

----------

Name: Possible Cataloging Mistakes, education, eresource ccode
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Items-admin

Created on: 2013-05-24 15:51:29
Modified on: 2013-06-16 16:46:49
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT ('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'\" target="_blank">',biblio.biblionumber,'</a>') AS "Linked Record", items.itemnumber, items.ccode, items.itemcallnumber, items.homebranch FROM biblio join items USING(biblionumber) WHERE items.ccode IN ('EDUCATION','ERESOURCE') and items.homebranch <> 'NEKLS' ORDER BY items.homebranch LIMIT 400



