/*
R.003054

----------

Name: GHW - Videos without links
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-03-02 10:10:47
Modified on: 2022-03-08 21:03:58
Date last run: 2021-10-21 23:01:01

----------

Public: 0
Expiry: 300

----------

zbrq

<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3054">Click here to download as a csv file</a></p>

----------
*/



SELECT
  biblio.biblionumber,
  biblio.datecreated,
  biblio.timestamp,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="a"]') AS TITLE_A,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="n"]') AS TITLE_N,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="p"]') AS TITLE_P,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="h"]') AS TITLE_H,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="b"]') AS TITLE_B,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=245]/subfield[@code="c"]') AS TITLE_C,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=130]/subfield[@code="a"]') AS UNTITLE_OA,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=730]/subfield[@code="a"]') AS UNTITLE_SA,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=300]/subfield[@code="a"]') AS DESCRIP,
  Group_Concat(DISTINCT items.ccode ORDER BY items.ccode ASC) AS Group_Concat_ccode,
  biblio.frameworkcode,
  Concat_WS("", 
    "-",
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag=306]/subfield[@code="a"]'),
    "-"
    ) AS TIMESS,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="h"]') AS CCODE,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="e"]') AS LOC
FROM  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  (items.itype LIKE 'NVID%' OR
    items.itype = 'MEDIA')
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.biblionumber DESC

























