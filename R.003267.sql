/*
R.003267

----------

Name: GHW - ISBN helper
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-25 09:45:18
Modified on: 2019-09-25 09:45:18
Date last run: 2019-09-25 11:35:27

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  biblioitems.isbn,
  biblioitems.itemtype
FROM
  biblio
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  biblioitems.isbn LIKE '%(%' AND
  biblioitems.itemtype <> 'DIGITAL'
ORDER BY
  biblio.biblionumber DESC



