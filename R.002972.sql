/*
R.002972

----------

Name: GHW - EOM 002
Created by: George Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-07-05 16:06:40
Modified on: 2017-07-05 16:09:03
Date last run: 2018-06-01 15:06:46

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.borrowernumber,
  Concat(borrowers.cardnumber) AS cardnumber,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode
FROM
  borrowers
WHERE
  borrowers.state &lt;&gt; "AL" AND
  borrowers.state &lt;&gt; "AK" AND
  borrowers.state &lt;&gt; "AZ" AND
  borrowers.state &lt;&gt; "AR" AND
  borrowers.state &lt;&gt; "CA" AND
  borrowers.state &lt;&gt; "CO" AND
  borrowers.state &lt;&gt; "CT" AND
  borrowers.state &lt;&gt; "DE" AND
  borrowers.state &lt;&gt; "DC" AND
  borrowers.state &lt;&gt; "FL" AND
  borrowers.state &lt;&gt; "GA" AND
  borrowers.state &lt;&gt; "HI" AND
  borrowers.state &lt;&gt; "ID" AND
  borrowers.state &lt;&gt; "IL" AND
  borrowers.state &lt;&gt; "IN" AND
  borrowers.state &lt;&gt; "IA" AND
  borrowers.state &lt;&gt; "KS" AND
  borrowers.state &lt;&gt; "KY" AND
  borrowers.state &lt;&gt; "LA" AND
  borrowers.state &lt;&gt; "ME" AND
  borrowers.state &lt;&gt; "MD" AND
  borrowers.state &lt;&gt; "MA" AND
  borrowers.state &lt;&gt; "MI" AND
  borrowers.state &lt;&gt; "MN" AND
  borrowers.state &lt;&gt; "MS" AND
  borrowers.state &lt;&gt; "MO" AND
  borrowers.state &lt;&gt; "MT" AND
  borrowers.state &lt;&gt; "NE" AND
  borrowers.state &lt;&gt; "NV" AND
  borrowers.state &lt;&gt; "NH" AND
  borrowers.state &lt;&gt; "NJ" AND
  borrowers.state &lt;&gt; "NM" AND
  borrowers.state &lt;&gt; "NY" AND
  borrowers.state &lt;&gt; "NC" AND
  borrowers.state &lt;&gt; "ND" AND
  borrowers.state &lt;&gt; "OH" AND
  borrowers.state &lt;&gt; "OK" AND
  borrowers.state &lt;&gt; "OR" AND
  borrowers.state &lt;&gt; "PA" AND
  borrowers.state &lt;&gt; "PR" AND
  borrowers.state &lt;&gt; "RI" AND
  borrowers.state &lt;&gt; "SC" AND
  borrowers.state &lt;&gt; "SD" AND
  borrowers.state &lt;&gt; "TN" AND
  borrowers.state &lt;&gt; "TX" AND
  borrowers.state &lt;&gt; "UT" AND
  borrowers.state &lt;&gt; "VT" AND
  borrowers.state &lt;&gt; "VA" AND
  borrowers.state &lt;&gt; "VI" AND
  borrowers.state &lt;&gt; "WA" AND
  borrowers.state &lt;&gt; "WV" AND
  borrowers.state &lt;&gt; "WI" AND
  borrowers.state &lt;&gt; "WY" AND
  borrowers.branchcode NOT LIKE "PH%" AND
  borrowers.branchcode NOT LIKE "LOU%"
GROUP BY
  borrowers.borrowernumber,
  Concat(borrowers.cardnumber),
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.address,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode
ORDER BY
  borrowers.state,
  borrowers.branchcode,
  borrowers.categorycode

























