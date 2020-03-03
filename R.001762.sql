/*
R.001762

----------

Name: Top 100 Titles with Holds Report for non-Media (NOT DVDs, Blu-Ray, TV Series, Videogames)
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2013-02-25 11:42:02
Modified on: 2017-12-18 15:37:46
Date last run: 2020-02-25 21:05:11

----------

Public: 0
Expiry: 0

----------



----------
*/

select count(DISTINCT reserves.borrowernumber) as reservecount, count(DISTINCT items.itemnumber) as itemcount, ROUND(count(DISTINCT reserves.borrowernumber)/count(DISTINCT items.itemnumber)) AS holdsratio, biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code>="b"]') as 'Remainder of Title', items.ccode, items.itype, biblio.biblionumber f from borrowers LEFT JOIN reserves USING(borrowernumber) join biblio USING(biblionumber) join biblio_metadata USING(biblionumber) JOIN items USING(biblionumber) WHERE items.ccode NOT IN ('DVD','TVSERIES','BLU-RAY','VIDEOGAME','DISPLAY') AND items.itype NOT IN ('NEWMEDIA','MEDIA','GAME') AND biblio.biblionumber NOT IN ('538887','546605','538630','547805','549282','547390','539751','548383','545000','547992','548987','550575','550477','549927','549613','551569','550183','550186') group by biblionumber order by holdsratio desc, reservecount desc limit 100



