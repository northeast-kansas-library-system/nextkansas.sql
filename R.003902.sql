/*
R.003902

----------

Name: GHW - patron purge 06
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-30 09:27:23
Modified on: 2025-07-30 10:00:48
Date last run: 2025-07-30 10:00:54

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Upper(borrowers.cardnumber) AS cardnumber,
  'DELETED' AS surname,
  'DELETED' AS firstname,
  'DELETED' AS preferred_name,
  'DELETED' AS middle_name,
  '' AS title,
  '' AS othernames,
  '' AS initials,
  '' AS pronouns,
  '' AS streetnumber,
  '' AS streettype,
  '' AS address,
  '' AS address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  '' AS country,
  '' AS email,
  'DELETED' AS phone,
  'DELETED' AS mobile,
  'DELETED' AS fax,
  '' AS emailpro,
  '' AS phonepro,
  '' AS B_streetnumber,
  '' AS B_streettype,
  '' AS B_address,
  '' AS B_address2,
  '' AS B_city,
  '' AS B_state,
  '' AS B_zipcode,
  '' AS B_country,
  '' AS B_email,
  '' AS B_phone,
  borrowers.branchcode,
  borrowers.categorycode,
  '01/01/1900' AS dateexpiry,
  '' AS contactname,
  '' AS contactfirstname,
  '' AS contacttitle,
  '' AS borrowernotes,
  '' AS relationship,
  '' AS ethnicity,
  '' AS ethnotes,
  '' AS sex,
  '' AS opacnote,
  '' AS contactnote,
  '' AS sort1,
  '' AS sort2,
  '' AS altcontactfirstname,
  '' AS altcontactsurname,
  '' AS altcontactaddress1,
  '' AS altcontactaddress2,
  '' AS altcontactaddress3,
  '' AS altcontactstate,
  '' AS altcontactzipcode,
  '' AS altcontactcountry,
  '' AS altcontactphone,
  '' AS smsalertnumber,
  '' AS sms_provider_id
FROM
  borrowers JOIN
  (
    SELECT
      borrower_attributes.borrowernumber,
      authorised_values.lib,
      borrower_attributes.attribute
    FROM
      borrower_attributes JOIN
      authorised_values ON borrower_attributes.attribute =
          authorised_values.authorised_value
    WHERE
      borrower_attributes.code = 'EXPIRED' AND
      authorised_values.category = 'EXPIRED'
    GROUP BY
      borrower_attributes.borrowernumber,
      borrower_attributes.attribute,
      borrower_attributes.code
  ) expired_account 
    ON expired_account.borrowernumber = borrowers.borrowernumber
WHERE
  expired_account.attribute &gt; 4 AND 
  expired_account.attribute LIKE &lt;&gt;

























