/*
R.003145

----------

Name: GHW - ADMINREPORT - Adult patrons with guarantors
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-12-17 15:12:26
Modified on: 2019-08-27 15:53:21
Date last run: 2019-09-06 16:56:26

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Adult patrons with lingering guarantor problems</p>
<ul><li>Shows patrons who still have guarantor information linked to their accounts even though they are now adults</li>
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
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.title,
  borrowers.othernames,
  borrowers.initials,
  borrowers.streetnumber,
  borrowers.streettype,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.email,
  borrowers.phone,
  borrowers.mobile,
  borrowers.fax,
  borrowers.emailpro,
  borrowers.phonepro,
  borrowers.B_streetnumber,
  borrowers.B_streettype,
  borrowers.B_address,
  borrowers.B_address2,
  borrowers.B_city,
  borrowers.B_state,
  borrowers.B_zipcode,
  borrowers.B_country,
  borrowers.B_email,
  borrowers.B_phone,
  borrowers.dateofbirth,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  IF(
    borrowers.dateexpiry >= curdate(),
    (curdate() - interval 1 day),
    borrowers.dateexpiry
  ) AS dateexpiry,
  borrowers.date_renewed,
  borrowers.gonenoaddress,
  borrowers.lost,
  borrowers.debarred,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.guarantorid,
  borrowers.relationship,
  borrowers.ethnicity,
  borrowers.ethnotes,
  borrowers.sex,
  borrowers.sort1,
  borrowers.sort2,
  borrowers.altcontactfirstname,
  borrowers.altcontactsurname,
  borrowers.altcontactaddress1,
  borrowers.altcontactaddress2,
  borrowers.altcontactaddress3,
  borrowers.altcontactstate,
  borrowers.altcontactzipcode,
  borrowers.altcontactcountry,
  borrowers.altcontactphone
FROM
  borrowers
WHERE
  (borrowers.dateofbirth <= CurDate() - INTERVAL 18 YEAR OR
    borrowers.dateofbirth IS NULL) AND
  (borrowers.guarantorid IS NOT NULL OR
    borrowers.guarantorid <> "" OR
    borrowers.contactname <> "" OR
    borrowers.contactfirstname <> "" OR
    borrowers.contacttitle <> "")
ORDER BY
  borrowers.borrowernumber



