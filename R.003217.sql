/*
R.003217

----------

Name: GHW - Duplicate card helper
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-12 00:20:17
Modified on: 2019-07-22 11:39:15
Date last run: 2020-04-13 14:38:48

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('&lt;br /&gt;POSSIBLE DUPLICATE PATRON&lt;br /&gt;There are two patrons with this name and birth date.  This account (', pat1.cardnumber, ' - ',  pat1.branchcode, ') and another with card number  &lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat2.borrowernumber, '" target="_blank"&gt;', pat2.cardnumber, ' - ',  pat2.branchcode, '.&lt;/a&gt;&lt;br /&gt;Please check with the patron to determine which account is the active account and', ' d', 'elete the inactive account.&lt;br /&gt;GHW - NEKLS&lt;br /&gt;') AS CARDONE,
  Concat('&lt;br /&gt;POSSIBLE DUPLICATE PATRON&lt;br /&gt;There are two patrons with this name and birth date.  This account (', pat2.cardnumber, ' - ',  pat2.branchcode, ') and another with card number  &lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat1.borrowernumber, '" target="_blank"&gt;', pat1.cardnumber, ' - ',  pat1.branchcode, '.&lt;/a&gt;&lt;br /&gt;Please check with the patron to determine which account is the active account and', ' d', 'elete the inactive account.&lt;br /&gt;GHW - NEKLS&lt;br /&gt;') AS CARDTWO
FROM
  borrowers pat1,
  borrowers pat2
WHERE
  pat1.cardnumber = <<Card one>> AND
  pat2.cardnumber = <<Card two>>



