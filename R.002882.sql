/*
R.002882

----------

Name: GHW - Patrons with multiple holds on 1 biblio
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-01-10 11:28:21
Modified on: 2023-04-18 13:58:53
Date last run: 2023-05-23 09:56:44

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of all items where 1 patron has more than 1 hold on 1 bibliographic record</p>
<ul><li>Shows current multiple holds</li>
<li>at all NExpress libraries</li>
<li>grouped by biblionumber, patron barcode, and borrowernumber</li>
<li>sorted by biblionumber, patron barcode, and borrowernumber</li>
<li>contains links to the request record and the patron record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2882&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=', reserves.biblionumber, '\" target="_blank">',
  reserves.biblionumber, '</a>') AS LINK_TO_REQUESTS,
  reserves.biblionumber AS BIBLIO,
  borrowers.cardnumber AS CARD_NUMBER,
  Count(reserves.borrowernumber) AS Count_borrowernumber,
  Concat('<a href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=', borrowers.borrowernumber, '\" target="_blank">', borrowers.borrowernumber, '</a>') AS LINK_TO_PATRON
FROM
  reserves
  JOIN borrowers ON reserves.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.categorycode <> 'BOOKCLUB'  AND
  reserves.found IS NULL   
GROUP BY
  reserves.biblionumber,
  borrowers.cardnumber,
  borrowers.borrowernumber
HAVING
  Count(reserves.borrowernumber) > 1

























