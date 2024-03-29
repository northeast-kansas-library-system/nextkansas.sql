/*
R.003085

----------

Name: GHW - Patron attributes Report (master)
Created by: George H Williams

----------

Group: Borrowers
     Patron attributes

Created on: 2018-06-28 15:09:42
Modified on: 2019-07-24 17:47:43
Date last run: 2019-08-22 13:33:18

----------

Public: 0
Expiry: 300

----------

Cannot be exported to csv (too large)

----------
*/



SELECT
  Concat("<a href='/cgi-bin/koha/circ/circulation.pl?borrowernumber=", borrowers.borrowernumber, "' target='_blank'>Patron</a>") AS LINK_TO_PATRON,
  borrowers.cardnumber,
  Concat_Ws("", If(borrowers.surname = "", "-", borrowers.surname), " / ", If(borrowers.firstname = "", "-", borrowers.firstname), If(borrowers.othernames = "", " ", Concat(" - (", borrowers.othernames, ")"))) AS NAME,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.email,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.dateofbirth,
  borrowers.dateenrolled,
  borrowers.dateexpiry,
  Coalesce(otherinfoone.attribute, "~") AS OTHER_IDENTIFIER_ONE,
  Coalesce(otherinfotwo.attribute, "~") AS OTHER_IDENTIFIER_TWO,
  Coalesce(registrationbranch.attribute, "~") AS REGISTRATION_BRANCH,
  Coalesce(collectionagency.lib, "~") AS COLLECTION_AGENCY,
  Coalesce(expired_account.lib, "~") AS EXPIRATION_FLAGS,
  Coalesce(holdscontact.lib, "~") AS HOLDS_CONTACT,
  Coalesce(location.lib, "~") AS SPECIAL_LOCATION,
  Coalesce(internet_permission.lib, "~") AS INTERNET_PERMISSION,
  Coalesce(movie_permissionx.lib, "~") AS FILM_PERMISSION,
  Coalesce(newsletter_permission.lib, "~") AS NEWSLETTER_PERMISSION
FROM
  borrowers
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'ALTID'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.code) otherinfoone ON borrowers.borrowernumber = otherinfoone.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'LICENSE'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.code) otherinfotwo ON borrowers.borrowernumber = otherinfotwo.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute
      FROM
        borrower_attributes
      WHERE
        borrower_attributes.code = 'REGBRANCH'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.code) registrationbranch ON borrowers.borrowernumber = registrationbranch.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'CAOTTAWA' AND
        authorised_values.category = 'COLLAGEN'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) collectionagency ON borrowers.borrowernumber = collectionagency.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'EXPIRED' AND
        authorised_values.category = 'EXPIRED'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) expired_account ON borrowers.borrowernumber = expired_account.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'HOLD' AND
        authorised_values.category = 'HoldsContact'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) holdscontact ON borrowers.borrowernumber = holdscontact.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'Location' AND
        authorised_values.category = 'SPECLOC'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute,
        borrower_attributes.code) location ON borrowers.borrowernumber = location.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'INTERNET' AND
        authorised_values.category = 'InternetPolicy'
      GROUP BY
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute) internet_permission ON
    borrowers.borrowernumber = internet_permission.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'MOVIE' AND
        authorised_values.category = 'FILMPERM'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute) movie_permissionx ON borrowers.borrowernumber = movie_permissionx.borrowernumber
  LEFT JOIN (SELECT
        borrower_attributes.borrowernumber,
        authorised_values.lib,
        borrower_attributes.attribute
      FROM
        borrower_attributes
        INNER JOIN authorised_values ON borrower_attributes.attribute = authorised_values.authorised_value
      WHERE
        borrower_attributes.code = 'NEWSLETTER' AND
        authorised_values.category = 'EmailNews'
      GROUP BY
        borrower_attributes.borrowernumber,
        borrower_attributes.attribute) newsletter_permission ON
    borrowers.borrowernumber = newsletter_permission.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>>  AND
  borrowers.categorycode LIKE <<Choose a borrower category|LBORROWERCAT>> AND
  Coalesce(otherinfoone.attribute, "~") LIKE CONCAT("%", <<Enter part of 'Other identifier 1' or a % symbol>>, "%") AND
  Coalesce(otherinfotwo.attribute, "~") LIKE CONCAT("%", <<Enter part of 'Other identifier 2' or a % symbol>>, "%") AND
  Coalesce(registrationbranch.attribute, "~") LIKE CONCAT("%", <<Enter part of 'Registration branch' or a % symbol>>, "%") AND
  Coalesce(collectionagency.attribute, "~") LIKE <<Select collection agency attribute|LCOLLAGEN>> AND
  Coalesce(expired_account.attribute, "~") LIKE <<Select collection agency attribute|LEXPIRED>> AND
  Coalesce(holdscontact.attribute, "~") LIKE <<Select holds contact attribute|LHOLDSCON>> AND
  Coalesce(location.attribute, "~") LIKE <<Select special locations attribute|LSPECLOC>> AND 
  Coalesce(internet_permission.attribute, "~") LIKE <<Select internet policy attribute|LINTPOLICY>> AND
  Coalesce(movie_permissionx.attribute, "~") LIKE <<Select film permission attribute|LFILMPERM>> AND
  Coalesce(newsletter_permission.attribute, "~") LIKE <<Select newsletter permission attribute|LNEWSPERM>>
GROUP BY
  borrowers.email,
  borrowers.dateofbirth,
  borrowers.borrowernumber,
  borrowers.othernames
ORDER BY
  borrowers.surname,
  borrowers.firstname

























