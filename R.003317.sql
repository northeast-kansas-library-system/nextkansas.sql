/*
R.003317

----------

Name: GHW - Self-Registration Report
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-03-27 09:17:33
Modified on: 2020-04-13 14:26:53
Date last run: 2020-06-19 11:21:09

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', borrowers.borrowernumber, '" target="_blank">Link</a>') AS DIRECT_LINK,
  borrowers.cardnumber,
  borrowers.branchcode,
  Concat(Coalesce(borrowers.surname, ''), ', ', Coalesce(borrowers.firstname, '')) AS NAME,
  borrowers.dateofbirth,
  Concat_Ws("<br />",
    Coalesce(borrowers.address, ''),
    Coalesce(borrowers.address2, ''),
    Concat(Coalesce(borrowers.city, ''), ', ', Coalesce(borrowers.state, ''), ' ', Coalesce(borrowers.zipcode, ''))
  ) AS ADDRESS,
  borrowers.email,
  borrowers.phone,
  borrowers.categorycode,
  borrowers.dateenrolled
FROM
  borrowers
WHERE
  borrowers.categorycode = 'A_SELF'
ORDER BY
  borrowers.cardnumber DESC

























