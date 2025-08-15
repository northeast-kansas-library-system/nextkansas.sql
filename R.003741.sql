/*
R.003741

----------

Name: GHW - Sandbox BSCLEANUP
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-26 11:41:56
Modified on: 2024-01-17 11:14:13
Date last run: 2023-10-20 14:55:17

----------

Public: 0
Expiry: 300

----------

 

ADMINREPORT



----------
*/



Select
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.middle_name,
  borrowers.streetnumber,
  borrowers.streettype,
  borrowers.address,
  borrowers.address2,
  borrowers.city,
  borrowers.state,
  borrowers.zipcode,
  borrowers.country,
  borrowers.branchcode,
  borrowers.categorycode,
  borrowers.userid
From
  borrowers
Where
  borrowers.branchcode = 'BONNERSPGS' And
  borrowers.categorycode &lt;&gt; 'BOOKCLUB' And
  borrowers.categorycode &lt;&gt; 'ILL' And
  borrowers.categorycode &lt;&gt; 'INHOUSE' And
  borrowers.categorycode &lt;&gt; 'S_SIP' And
  borrowers.categorycode &lt;&gt; 'STAFF' And
  borrowers.categorycode &lt;&gt; 'ASSOCIATE'

























