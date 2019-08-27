/*
R.002729

----------

Name: GHW - TITLE
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-08-10 11:52:13
Modified on: 2016-08-12 09:40:12
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT borrowers.borrowernumber,
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
     borrowers.gonenoaddress,
     borrowers.lost,
     borrowers.debarred,
     borrowers.contactname,
     borrowers.contactfirstname,
     borrowers.contacttitle,
     borrowers.guarantorid,
     borrowers.relationship,
     borrowers.ethnicity,
     borrowers.sex,
     borrowers.userid,
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
     borrowers.smsalertnumber,
     borrowers.privacy 
  FROM borrowers
  WHERE borrowers.initials <> ' '
  ORDER BY borrowers.surname asc, borrowers.firstname ASC




