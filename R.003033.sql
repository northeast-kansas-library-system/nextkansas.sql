/*
R.003033

----------

Name: GHW - Fixing 856u
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2018-01-08 16:23:36
Modified on: 2018-01-08 16:29:48
Date last run: 2018-05-04 17:41:43

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  CONCAT("<a href='https://staff.nexpresslibrary.org/cgi-bin/koha/cataloguing/addbiblio.pl?biblionumber=", biblio_metadata.biblionumber,  " ' target='_blank'>Edit in new window</a>") AS LINK,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="856"]//subfield[@code="u"]') AS URI
FROM
  biblio_metadata
WHERE
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="856"]//subfield[@code="u"]') LIKE "%overdrive%"
GROUP BY
  biblio_metadata.biblionumber

























