/*
R.003310

----------

Name: GHW - duplicates ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-02-08 20:17:56
Modified on: 2020-02-08 21:39:42
Date last run: 2020-08-13 14:13:52

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
  Concat('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=', Trim(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title, '/', ''), ':', ''), ';', ''), '.', ''), '"', ''), "'", "")), '&sort_by=title_az\" target="_blank">SEARCH</a>') As SEARCH,
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title, '/', ''), ':', ''), ';', ''), '.', ''), '"', ''), "'", "")) As TITLE,
  Group_Concat(biblio.biblionumber) As BIBLIONUMBERS,
  Group_Concat(biblio.author, " | ") As AUTHORS,
  Count(biblio.biblionumber) As TITLE_COUNT
From
  biblio Join
  (Select
      items.biblionumber
    From
      items
    Where
      items.ccode Not Like "DL%" And
      items.ccode Not Like "ER%"
    Group By
      items.biblionumber) itemsx On itemsx.biblionumber = biblio.biblionumber
Group By
  Concat('<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=ti&q=', Trim(Replace(Replace(Replace(Replace(Replace(biblio.title, '/', ''), ':', ''), ';', ''), '.', ''), '"', '')), '&sort_by=title_az\" target="_blank">SEARCH</a>'),
  Trim(Replace(Replace(Replace(Replace(Replace(biblio.title, '/', ''), ':', ''), ';', ''), '.', ''), '"', ''))
Having
  Count(biblio.biblionumber) > 1
Order By
  TITLE



