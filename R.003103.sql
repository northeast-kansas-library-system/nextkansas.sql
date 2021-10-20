/*
R.003103

----------

Name: GHW - Details on a specific biblio
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-07-15 14:41:03
Modified on: 2019-01-25 16:50:19
Date last run: 2019-07-14 22:56:01

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  biblio.frameworkcode,
  biblio.author,
  biblio.title,
  biblio.unititle,
  biblio.notes,
  biblio.serial,
  biblio.seriestitle,
  biblio.copyrightdate,
  biblio.timestamp,
  biblio.datecreated,
  biblio.abstract,
  Group_Concat(items.itype) AS ITYPES
FROM
  biblio
LEFT JOIN items on (biblio.biblionumber = items.biblionumber)
WHERE biblio.biblionumber = <<Enter biblio number>>
GROUP BY
  biblio.biblionumber
ORDER BY
 biblio.biblionumber
  DESC


























