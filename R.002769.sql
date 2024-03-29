/*
R.002769

----------

Name: GHW - TEST accounts
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-09-10 23:12:34
Modified on: 2018-04-16 10:48:39
Date last run: 2018-01-24 16:28:48

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Shows all of the NExpress test accounts</p>
<ul><li>Shows current accounts</li>
<li>at all NExpress libraries</li>
<li>links directly to the details page of the account (links open in a new window)</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>This report lists all of the information from the patron's account except the userid, password, and flags fields so that the report can be downloaded, the "borrowernumber" links column can be deleted, changes can be made to the account information, and then the data can be imported back into Koha without accidentally changing the userid, password, or flags fields (which can screw up the accounts - yes - learned this one the hard way - again).</p>
</div>

----------
*/



SELECT
  CONCAT( '<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowers.borrowernumber ,'\" target="_blank">', borrowers.borrowernumber, '</a>' ) AS 'BORROWER_NUMBER',
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
  borrowers.privacy
FROM
  borrowers
WHERE
  borrowers.othernames LIKE "%TEST%"
ORDER BY
  borrowers.surname,
  borrowers.firstname
  ASC

























