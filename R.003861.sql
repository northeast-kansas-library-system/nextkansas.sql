/*
R.003861

----------

Name: ghw
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-09 17:33:28
Modified on: 2024-10-09 17:35:58
Date last run: 2026-04-10 14:39:24

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  borrowers.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.middle_name,
  borrowers.title,
  borrowers.othernames,
  borrowers.initials,
  borrowers.pronouns,
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
  borrowers.password_expiration_date,
  borrowers.date_renewed,
  borrowers.gonenoaddress,
  borrowers.lost,
  borrowers.debarred,
  borrowers.debarredcomment,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.borrowernotes,
  borrowers.relationship,
  borrowers.ethnicity,
  borrowers.ethnotes,
  borrowers.sex
From
  borrowers
Where
  borrowers.cardnumber LIKE <<Enter library card number>>

























