/*
R.002215

----------

Name: Not sure? 
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-03-16 13:51:32
Modified on: 2014-08-09 00:29:44
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>') AS "Link to Record", biblio.title FROM biblio JOIN items USING(biblionumber) WHERE items.ccode NOT IN ('MAGAZINE','ILL','ERESOURCE') GROUP BY biblio.biblionumber ORDER BY biblio.biblionumber desc 



