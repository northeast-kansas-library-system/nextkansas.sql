/*
R.003269

----------

Name: GHW - ADMINREPORT - REGBRANCH cleanup 2
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-26 12:42:56
Modified on: 2019-09-26 12:57:07
Date last run: 2019-09-26 12:57:09

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.borrowernumber,
  Concat("-", borrowers.cardnumber, "-") AS cardnumber,
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
  Concat_Ws(':', 'REGBRANCH', branches.branchname) AS patron_attributes
FROM
  borrowers
  JOIN branches
    ON borrowers.branchcode = branches.branchcode
  LEFT JOIN (
    SELECT
      borrower_attributes.id,
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute
    FROM
      borrower_attributes
    WHERE
      borrower_attributes.code = 'REGBRANCH'
  ) attributess
    ON attributess.borrowernumber = borrowers.borrowernumber
WHERE
  attributess.attribute IS NULL AND
  Month(borrowers.dateenrolled) = Month(CurDate() - INTERVAL 0 MONTH) AND
  Year(borrowers.dateenrolled) = Year(CurDate() - INTERVAL 0 MONTH)
ORDER BY
  borrowers.borrowernumber

























