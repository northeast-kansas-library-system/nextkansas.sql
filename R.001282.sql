/*
R.001282

----------

Name: Media in the catalog.
Created by: Heather Braum

----------

Group: -
     -

Created on: 2011-12-22 20:47:58
Modified on: 2017-12-11 14:47:40
Date last run: 2018-10-08 12:55:27

----------

Public: 0
Expiry: 0

----------

Includes DVD, VHS, MUSIC, Bluray, and Videogame collection codes. For catalog cleanup.

----------
*/

SELECT DISTINCT
  biblio.biblionumber,
  items.ccode,
  biblio.title,
  items.dateaccessioned,
  Concat('<a href=\"/cgi-bin/koha/catalogue/MARCdetail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">',
  biblio.biblionumber, '</a>') AS "MARC View",
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="024"]/subfield[@code>="a"]') AS 'Standard Number'
FROM
  biblio
  JOIN items ON biblio.biblionumber = items.biblionumber
  JOIN biblio_metadata ON biblio.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch = <<branch|branches>> AND
  items.ccode IN ('DVD', 'VHS', 'MUSIC', 'BLURAY', 'GAME')
ORDER BY
  biblio.biblionumber DESC



