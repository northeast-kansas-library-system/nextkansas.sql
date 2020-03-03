/*
R.002993

----------

Name: Patron re-import
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-09-06 13:56:13
Modified on: 2017-09-06 14:53:12
Date last run: 2019-11-08 21:57:27

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
  borrowers.gonenoaddress,
  borrowers.lost,
  borrowers.debarred,
  borrowers.debarredcomment,
  borrowers.contactname,
  borrowers.contactfirstname,
  borrowers.contacttitle,
  borrowers.guarantorid,
  borrowers.borrowernotes,
  borrowers.relationship,
  borrowers.ethnicity,
  borrowers.ethnotes,
  borrowers.sex,
  borrowers.password,
  borrowers.flags,
  borrowers.userid,
  borrowers.opacnote,
  borrowers.contactnote,
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
  borrowers.sms_provider_id,
  borrowers.privacy,
  borrowers.privacy_guarantor_checkouts,
  borrowers.checkprevcheckout,
  borrowers.updated_on,
  borrowers.lastseen
FROM
  borrowers
WHERE
  borrowers.dateofbirth < CurDate() - INTERVAL 18 YEAR
GROUP BY
  borrowers.borrowernumber



