/*
R.003240

----------

Name: 23390
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-08-01 14:31:38
Modified on: 2019-08-02 14:24:20
Date last run: 2019-08-02 14:24:26

----------

Public: 0
Expiry: 300

----------

SELECT cardnumber
FROM borrowers WHERE cardnumber LIKE '%9'

----------
*/

SELECT
  borrowers.cardnumber,
  Concat("Patron") AS surname,
  Concat("Deleted") AS firstname,
  Concat("") AS title,
  Concat("") AS othernames,
  Concat("") AS initials,
  Concat("") AS streetnumber,
  Concat("") AS streettype,
  Concat("") AS address,
  Concat("") AS address2,
  borrowers.city,
  borrowers.state,
  LEFT(borrowers.zipcode, 5) as zipcode,
  Concat("") AS country,
  Concat("") AS email,
  Concat("") AS phone,
  Concat("") AS mobile,
  Concat("") AS fax,
  Concat("") AS emailpro,
  Concat("") AS phonepro,
  Concat("") AS B_streetnumber,
  Concat("") AS B_streettype,
  Concat("") AS B_address,
  Concat("") AS B_address2,
  Concat("") AS B_city,
  Concat("") AS B_state,
  Concat("") AS B_zipcode,
  Concat("") AS B_country,
  Concat("") AS B_email,
  Concat("") AS B_phone,
  Concat("01/01/1900") AS dateofbirth,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Concat("") AS date_renewed,
  Concat("") AS gonenoaddress,
  Concat("") AS lost,
  Concat("") AS debarred,
  Concat("") AS debarredcomment,
  Concat("") AS contactname,
  Concat("") AS contactfirstname,
  Concat("") AS contacttitle,
  Concat("") AS guarantorid,
  Concat("Patron deleted in batch deletion process after the account had been expired for more than 3 years - only non-identifying information (card number; city; state; zipcode; homebranch; categorycode; dateenrolled) is left intact on this record in the deleted_borrowers table") AS borrowernotes,
  Concat("") AS relationship,
  Concat("") AS ethnicity,
  Concat("") AS ethnotes,
  borrowers.sex,
  Concat("deleted") AS password,
  Concat("") AS flags,
  Concat("") AS opacnote,
  Concat("") AS contactnote,
  Concat("") AS sort1,
  Concat("") AS sort2,
  Concat("") AS altcontactfirstname,
  Concat("") AS altcontactsurname,
  Concat("") AS altcontactaddress1,
  Concat("") AS altcontactaddress2,
  Concat("") AS altcontactaddress3,
  Concat("") AS altcontactstate,
  Concat("") AS altcontactzipcode,
  Concat("") AS altcontactcountry,
  Concat("") AS altcontactphone,
  Concat("") AS smsalertnumber,
  Concat("") AS sms_provider_id
FROM
  borrowers
WHERE
  borrowers.dateexpiry < "1900-12-31"



