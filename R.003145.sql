/*
R.003145

----------

Name: GHW - ADMINREPORT - Adult patrons with guarantors
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-12-17 15:12:26
Modified on: 2020-07-27 16:21:31
Date last run: 2020-07-27 16:21:33

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Adult patrons with lingering guarantor problems</p>
<ul><li>Shows patrons who still have guarantor information connected to their accounts even though they are now adults</li>
<li>Shows patrons at all libraries</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3145&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3145">Click here to download as a csv file</a></p>
</div>

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.relationship,
  borrower_relationships.guarantor_id
FROM
  borrowers LEFT JOIN
  borrower_relationships ON borrower_relationships.guarantee_id =
      borrowers.borrowernumber
WHERE
  (borrowers.dateofbirth <= CurDate() - INTERVAL 18 YEAR OR
      borrowers.dateofbirth IS NULL) AND
  borrower_relationships.guarantor_id IS NOT NULL
GROUP BY
  borrower_relationships.guarantor_id,
  borrowers.borrowernumber

























