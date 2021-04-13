/*
R.003111

----------

Name: GHW - S
Created by: George H Williams

----------

Group: -
     -

Created on: 2018-08-08 18:12:23
Modified on: 2018-08-08 18:12:23
Date last run: 2018-09-06 21:44:47

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
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
  borrowers.lastseen,
  borrowers.lang,
  borrowers.login_attempts,
  borrowers.overdrive_auth_token
FROM
  borrowers
WHERE
  borrowers.branchcode LIKE "PH%"
GROUP BY
  borrowers.borrowernumber



