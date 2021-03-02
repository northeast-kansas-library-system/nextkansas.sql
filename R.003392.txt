/*
R.003392

----------

Name: test
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2020-12-29 07:30:17
Modified on: 2020-12-29 07:31:04
Date last run: 2020-12-29 07:31:06

----------

Public: 0
Expiry: 300

----------



----------
*/

select *
from accountlines
where credit_type_code='payment'
and note like '%paypal%'
order by date desc
limit 5



