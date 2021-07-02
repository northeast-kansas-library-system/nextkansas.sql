/*
R.001275

----------

Name: List of Titles with Holds
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2011-12-18 19:08:58
Modified on: 2013-11-17 13:44:27
Date last run: 2021-06-28 10:53:57

----------

Public: 0
Expiry: 0

----------

Enhanced. Choose library. #holds

----------
*/

SELECT biblio.biblionumber, items.ccode, CONCAT('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=',biblio.title,'&sort_by=title_az\" target="_blank">',biblio.title,'</a>')
AS Title, items.dateaccessioned, CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">',biblio.biblionumber,'</a>') AS bibnumber
FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN reserves USING (biblionumber) WHERE reserves.borrowernumber IS NOT NULL and items.homebranch =<<Pick branch|branches>> GROUP BY biblio.biblionumber ORDER BY biblio.biblionumber DESC LIMIT 1000



