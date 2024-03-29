/*
R.003166

----------

Name: GHW - Bullseye search
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-02-08 14:26:15
Modified on: 2019-02-11 23:18:52
Date last run: 2022-01-14 16:54:20

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  IF(
    Trim(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),".",""),",",""),"'",""),"/",""),":",""),";",""),"[",""),"]",""),"(",""),")","")) <> "",
    Concat(
      '<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',
      Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""),
      '&op=and&idx=ti&q=',
      Trim(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title,".",""),"?",""),",",""),"'",""),"/",""),":",""),";",""),"&","")," ","+")),
      '&op=and&idx=kw&q=',
      Trim(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),".",""),",",""),"'",""),"/",""),":",""),";",""),"[",""),"]",""),"(",""),")","")),
      '&sort_by=title_az\" target="_blank">Search the catalog</a>'
    ),
    Concat(
      '<a href=\"/cgi-bin/koha/catalogue/search.pl?idx=au&q=',
      Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""),
      '&op=and&idx=ti&q=',
      Trim(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title,".",""),"?",""),",",""),"'",""),"/",""),":",""),";",""),"&","")," ","+")),
      '&op=not&idx=kw%2Cphr&q=sound+recording&op=not&idx=kw%2Cphr&q=videorecording&sort_by=title_az\" target="_blank">Search the catalog</a>'
    )
  ) AS BULLSEYE_SEARCH,
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", "") AS AUTHOR,
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title, ".", ""), ",", ""), "'", ""), "/", ""), ":", ""),";", "")) AS TITLE,
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), ".", ""), ",", ""), "'", ""), "/", ""), ":", ""), ";", ""), "[", ""), "]", ""), "(", ""), ")", "")) AS GMD,
  Count(biblio.biblionumber) AS Count_biblionumber,
  Group_Concat(biblio_metadata.biblionumber) AS Group_Concat_biblionumber
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
WHERE
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", "") LIKE Concat(<<searchterm>>, "%")
GROUP BY
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""),
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title, ".", ""), ",", ""), "'", ""), "/", ""), ":", ""),
  ";", "")),
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="h"]'), ".", ""), ",", ""), "'", ""), "/", ""), ":", ""), ";", ""))
HAVING
  Count(biblio.biblionumber) > 1 AND
  GMD NOT LIKE "%Hoopla%"

























