/*
R.002858

----------

Name: GHW - Items more than XX days overdue
Created by: George H Williams

----------

Group: Fines/Fees
     -

Created on: 2016-12-15 16:10:39
Modified on: 2022-03-30 09:09:29
Date last run: 2023-02-08 11:43:08

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Lists patrons with items more than XX days overdue at a specified library</p>
<ul><li>Shows patrons who currently have overdues</li>
<li>that were checked out at the specified location</li>
<li>grouped by</li>
<li>sorted by patron name, card number, and date due</li>
<li>links to the patron record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created at the request of HIAWATHA.</p>
<p>Essentially the same as report 350 - just with fewer fields.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2858&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat_Ws('<br />', 
    Concat(
      borrowers.firstname, 
      ' ', 
      borrowers.surname
    ),  
    (
      IF(
        borrowers.address2 = "", 
        borrowers.address, 
        Concat(borrowers.address, '<br />', borrowers.address2)
      )
    ), 
    Concat(
      borrowers.city, 
      ', ',  
      borrowers.state, 
      ' ', 
      borrowers.zipcode
    ),
    borrowers.categorycode
  ) AS ADDRESS,
  borrowers.firstname,
  borrowers.surname,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  (To_Days(CurDate()) - To_Days(issues.date_due)) AS DAYS_OVERDUE,
  items.replacementprice
FROM
  borrowers JOIN
  issues
    ON borrowers.borrowernumber = issues.borrowernumber JOIN
  items
    ON issues.itemnumber = items.itemnumber JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblioitems
    ON biblio.biblionumber = biblioitems.biblionumber
WHERE
  (To_Days(CurDate()) - To_Days(issues.date_due)) > <<More than XX days overdue>> AND
  issues.branchcode LIKE <<Check-out branch|ZBRAN>>
GROUP BY
  items.itemnumber,
  issues.date_due
ORDER BY
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber,
  issues.date_due

























