/*
R.003777

----------

Name: ADDRESS CLEANUP by city
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-19 08:29:34
Modified on: 2023-10-20 18:47:20
Date last run: 2023-10-20 18:52:52

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
  borrowers.city Like 'DeSoto%' And
  borrowers.categorycode &lt;&gt; 'BOOKCLUB' And
  borrowers.categorycode &lt;&gt; 'ILL' And
  borrowers.categorycode &lt;&gt; 'INHOUSE' And
  borrowers.categorycode &lt;&gt; 'S_SIP' And
  borrowers.categorycode &lt;&gt; 'STAFF' And
  borrowers.categorycode &lt;&gt; 'ASSOCIATE'

























