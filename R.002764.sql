/*
R.002764

----------

Name: GHW - PAOLA Computers Report
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-07 22:58:52
Modified on: 2016-09-07 23:14:11
Date last run: 2022-09-13 13:35:16

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  biblio.title,
  issues.date_due,
  CONCAT( '<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=',issues.borrowernumber ,'\" target="_blank">Open patron in new window</a>' ) AS BORROWER_LINK
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber LEFT JOIN
  issues
    ON issues.itemnumber = items.itemnumber
WHERE
  items.homebranch = 'PAOLA' AND
  items.itype = 'COMPUTER'

























