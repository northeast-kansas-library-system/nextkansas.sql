/*
R.003127

----------

Name: GHW - Audiobooks without links
Created by: George Williams

----------

Group: -
     -

Created on: 2018-10-04 22:35:11
Modified on: 2025-11-19 20:42:31
Date last run: 2025-12-26 22:42:03

----------

Public: 0
Expiry: 300

----------

zbrq

&lt;p&gt;Click here to download as a csv file&lt;/p&gt;

&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3127&reportname=GHW%20-%20Audiobooks%20without%20links" target="_blank"&gt;Download csv&lt;/a&gt;

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
  Group_Concat(DISTINCT items.permanent_location ORDER BY items.permanent_location ASC) AS Group_Concat_location,
  Group_Concat(DISTINCT items.ccode ORDER BY items.ccode ASC) AS Group_Concat_ccode,
  biblio.frameworkcode,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=306]/subfield[@code="a"]') AS TIMESS,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="e"]') AS BIB_LOC,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="c"]') AS BIB_ITYPE,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag=942]/subfield[@code="h"]') AS BIB_CCODE,
  ExtractValue(biblio_metadata.metadata, '//leader') AS 'LDR',  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=006]') AS '006 - Fixed-Length Data Elements - Additional Material Characteristics',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=007]') AS '007 - Physical Description Fixed Field',
  ExtractValue(biblio_metadata.metadata, '//controlfield[@tag=008]') AS '008 - Fixed-Length Data Elements'
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
WHERE
  items.itype LIKE 'N_AB%'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.biblionumber DESC

























