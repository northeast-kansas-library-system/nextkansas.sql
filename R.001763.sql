/*
R.001763

----------

Name: Top 100 Titles with Holds Report for Media (DVDs, Blu-Ray, TV Series, Videogames)
Created by: Heather Braum

----------

Group: Popular Reports
     -

Created on: 2013-02-25 12:18:01
Modified on: 2020-01-28 15:07:07
Date last run: 2020-09-09 13:59:54

----------

Public: 0
Expiry: 0

----------



----------
*/



Select
  Count(Distinct reserves.borrowernumber) As reservecount,
  Count(Distinct items.itemnumber) As itemcount,
  ROUND(Count(Distinct reserves.borrowernumber) / Count(Distinct items.itemnumber)) As holdsratio,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code>="b"]') As 'Remainder of Title',
  items.ccode,
  items.itype,
  biblio.biblionumber
From
  borrowers Left Join
  reserves On reserves.borrowernumber = borrowers.borrowernumber Join
  biblio On biblio.biblionumber = reserves.biblionumber Join
  biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber Join
  items On items.biblionumber = biblio_metadata.biblionumber
Where
  items.ccode In ('DVD', 'TVSERIES', 'BLURAY', 'VIDEOGAME')
Group By
  items.biblionumber
Order By
  holdsratio Desc,
  reservecount Desc
Limit 100

























