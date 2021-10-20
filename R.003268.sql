/*
R.003268

----------

Name: GHW - ADMINREPORT - REGBRANCH cleanup
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-26 10:52:49
Modified on: 2019-09-26 13:34:10
Date last run: 2019-11-04 15:53:00

----------

Public: 0
Expiry: 300

----------



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
  borrowers.dateexpiry,
  borrowers.date_renewed,
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
  borrowers.altcontactphone,
  Concat_Ws(':', borrower_attributes.code, branches.branchname) AS patron_attributes
FROM
  borrowers
  INNER JOIN borrower_attributes
    ON borrower_attributes.borrowernumber = borrowers.borrowernumber
  INNER JOIN branches
    ON borrowers.branchcode = branches.branchcode
WHERE
  borrower_attributes.code = 'REGBRANCH' AND
  borrower_attributes.attribute IN [<<Enter REGBRANCH code>>]
ORDER BY
  borrowers.borrowernumber

























