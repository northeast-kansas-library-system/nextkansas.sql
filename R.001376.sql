/*
R.001376

----------

Name: Nonstandard content in title
Created by: Heather Braum

----------

Group: Administrative Reports
     Fix Bib Records-admin

Created on: 2012-05-09 00:46:39
Modified on: 2014-01-15 00:46:00
Date last run: 2018-10-08 12:53:43

----------

Public: 0
Expiry: 0

----------



----------
*/

select DISTINCT CONCAT('<a href=\"/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=',b.biblionumber,'\" target="_blank">'"edit record"'</a>'), b.title, b.author from biblio b join items i using (biblionumber) WHERE b.title LIKE '% tapes]%' OR b.title LIKE '% discs]%' OR b.title LIKE '%DVD%' OR b.title LIKE '%VHS%' OR b.title LIKE '%COMPACT DISC%' OR b.title LIKE '%PBK%' OR b.title LIKE '%Paperback%' OR b.title LIKE '%CD%' AND b.biblionumber NOT IN ('114625','377039','152463','396819','379547','484797','398022','173724','364192','77324','311498','385690','462676','290483','500882','167130','149493','500882','311498','114625') group by b.biblionumber HAVING count(i.itemnumber) > 0 order by b.biblionumber DESC



