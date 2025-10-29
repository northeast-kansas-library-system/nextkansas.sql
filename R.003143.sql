/*
R.003143

----------

Name: GHW -Overdues report replacement
Created by: George Williams

----------

Group: Circulation
     Overdues

Created on: 2018-12-15 20:07:44
Modified on: 2024-01-17 11:55:57
Date last run: 2025-06-10 12:15:41

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Replacement for built-in for Overdue reports</p>
<ul><li>Shows overdues during the date range you specify</li>
<li>At the checkout library/the item home library/or patron home library you specify</li>
<li>sorted by date due and patron name, </li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3143&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  issues.date_due,
  Concat_Ws(", ", borrowers.surname, borrowers.firstname, borrowers.cardnumber) AS NAME,
  Concat_Ws(", ", guarantor.surname, guarantor.firstname, borrowers.relationship) AS GUARANTOR,
  borrowers.phone,
  borrowers.email,
  borrowers.branchcode,
  issues.issuedate,
  items.barcode,
  items.homebranch,
  items.holdingbranch,
  biblio.title,
  biblio.author,
  items.itemcallnumber,
  items.replacementprice
FROM
  issues
  LEFT JOIN borrowers ON issues.borrowernumber = borrowers.borrowernumber
  LEFT JOIN items ON issues.itemnumber = items.itemnumber
  LEFT JOIN biblioitems ON biblioitems.biblioitemnumber = items.biblioitemnumber
  LEFT JOIN biblio ON biblio.biblionumber = items.biblionumber
  LEFT JOIN borrowers guarantor ON guarantor.borrowernumber = borrowers.guarantorid
WHERE (date_due BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)) AND
  (borrowers.cardnumber LIKE Concat("%",&lt;&gt;,"%")) AND
  (borrowers.categorycode LIKE &lt;&gt;) AND
  (items.itype LIKE &lt;&gt;) AND
  (items.homebranch LIKE &lt;&gt;) AND
  (items.holdingbranch LIKE &lt;&gt;) AND
  (borrowers.branchcode LIKE &lt;&gt;)
ORDER BY
  issues.date_due,
  borrowers.surname,
  borrowers.firstname

























