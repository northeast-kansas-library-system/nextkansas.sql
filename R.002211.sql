/*
R.002211

----------

Name: Not Sure?
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-03-14 02:45:11
Modified on: 2014-08-09 00:29:38
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

select CONCAT('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',biblionumber,'\" target="_blank">',biblio.title,'</a>') as Title, count(*) as 'Number of Holds' from reserves join biblio USING(biblionumber) join biblioitems USING(biblionumber) group by biblionumber order by count(*) asc LIMIT 6000



