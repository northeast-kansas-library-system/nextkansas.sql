/*
R.003862

----------

Name: Forbidden words
Created by: George Williams

----------

Group: -
     -

Created on: 2024-10-14 13:30:37
Modified on: 2024-10-14 13:34:07
Date last run: 2025-05-19 15:24:16

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
  borrowers.sex,
  borrowers.auth_method,
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
  borrowers.privacy_guarantor_fines,
  borrowers.privacy_guarantor_checkouts,
  borrowers.checkprevcheckout,
  borrowers.updated_on,
  borrowers.lastseen,
  borrowers.lang,
  borrowers.login_attempts,
  borrowers.anonymized,
  borrowers.autorenew_checkouts,
  borrowers.primary_contact_method,
  borrowers.protected
FROM
  borrowers

























