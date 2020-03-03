/*
R.003257

----------

Name: GHW - Patron output for input ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-24 00:37:54
Modified on: 2020-02-26 14:43:51
Date last run: 2020-02-28 13:23:33

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.borrowernumber,
  borrowers.cardnumber,
  REGEXP_REPLACE(TRIM(borrowers.surname), '[[:space:]]+', ' ') AS surname,
  REGEXP_REPLACE(TRIM(borrowers.firstname), '[[:space:]]+', ' ') AS firstname,
  borrowers.title,
  borrowers.othernames,
  borrowers.initials,
  borrowers.streetnumber,
  borrowers.streettype,
  REGEXP_REPLACE(TRIM(REPLACE(borrowers.address, ".", "")), '[[:space:]]+', ' ') AS address,
  REGEXP_REPLACE(TRIM(REPLACE(borrowers.address, ".", "")), '[[:space:]]+', ' ') AS addressx,
  REGEXP_REPLACE(TRIM(REPLACE(borrowers.address2, ".", "")), '[[:space:]]+', ' ') AS address2,
  REGEXP_REPLACE(TRIM(REPLACE(borrowers.address2, ".", "")), '[[:space:]]+', ' ') AS address2x,
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
  borrowers.gonenoaddress,
  borrowers.lost,
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
  borrowers.categorycode <> "STAFF" AND
  borrowers.branchcode Like <<Select your library|LBRANCH>> AND
  borrowers.city Like Concat(<<Enter a left anchored city name search or a % symbol>>, "%")
ORDER BY
  borrowers.borrowernumber



