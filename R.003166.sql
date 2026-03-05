/*
R.003166

----------

Name: GHW - Bullseye search
Created by: George Williams

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
    Trim(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),".",""),",",""),"'",""),"/",""),":",""),";",""),"[",""),"]",""),"(",""),")","")) &lt;&gt; "",
    Concat(
      'Search the catalog'
    ),
    Concat(
      'Search the catalog'
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
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", "") LIKE Concat(&lt;&gt;, "%")
GROUP BY
  Replace(Replace(Replace(biblio.author, ".", ""), ",", ""), "'", ""),
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(biblio.title, ".", ""), ",", ""), "'", ""), "/", ""), ":", ""),
  ";", "")),
  Trim(Replace(Replace(Replace(Replace(Replace(Replace(ExtractValue(biblio_metadata.metadata,
  '//datafield[@tag="245"]/subfield[@code="h"]'), ".", ""), ",", ""), "'", ""), "/", ""), ":", ""), ";", ""))
HAVING
  Count(biblio.biblionumber) &gt; 1 AND
  GMD NOT LIKE "%Hoopla%"

























