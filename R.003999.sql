/*
R.003999

----------

Name: Bug report report
Created by: George Williams

----------

Group: -
     -

Created on: 2026-09-10 18:14:43
Modified on: 2026-09-10 18:14:47
Date last run: 2026-10-01 08:12:41

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws('<br>',
    Concat('URL: https://staff.nekls.bywatersolutions.com/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber), 
    Concat('Author: ', biblio.author), 
    Concat('Title: ', 
    Concat_Ws(' ', biblio.title, biblio.medium, biblio.subtitle)), 
    Concat('Date created: ', biblio.datecreated), 
    Concat('Last updat', 'e to biblio: ', biblio.timestamp),
    Concat('Item barcode: ', items.barcode)
  ) AS INFO
FROM
  biblio
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
WHERE
  biblio.datecreated >= '2026-09-09'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.datecreated DESC,
  biblio.biblionumber DESC

























