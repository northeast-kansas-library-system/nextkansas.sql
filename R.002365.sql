/*
R.002365

----------

Name: Records in All Caps
Created by: Heather Braum

----------

Group: Administrative Reports
     Post-Lansing

Created on: 2014-09-08 16:17:01
Modified on: 2014-09-29 16:40:12
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT DISTINCT biblio.biblionumber, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"bib search"'</a>') as "bib search", title, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',biblio.title,'&sort_by=title_az\" target="_blank">'"title search"'</a>') AS "Title Search", items.ccode FROM biblio JOIN items USING(biblionumber) WHERE biblio.title REGEXP BINARY '^[^a-z]+$' AND items.homebranch='LANSING' AND biblio.biblionumber > '639000' AND biblio.biblionumber NOT IN ('642189','647919','653948','651330','656126','655167','652071','648218','648217','643189') ORDER BY items.ccode



