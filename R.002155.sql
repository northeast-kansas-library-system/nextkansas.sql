/*
R.002155

----------

Name: Circulation for a Year by Patron Category Type
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-13 18:00:42
Modified on: 2014-01-13 18:00:42
Date last run: 2020-12-03 13:04:21

----------

Public: 0
Expiry: 300

----------

Select branch, enter year. Does not account for deleted patron account statistics (and can't figure out how to add that successfully yet). 

----------
*/

SELECT case
  when categories.category_type= 'A' then 'Adult'
  when categories.category_type= 'C' then 'Child'
  when categories.category_type= 'I' then 'ILL'
  when categories.category_type= 'P' then 'Professional'
  when categories.category_type= 'S' then 'Staff'
  when categories.category_type= 'X' then 'Statistical'
  else categories.category_type end as categorytype,
   COUNT(*) FROM statistics JOIN borrowers USING (borrowernumber) LEFT JOIN categories USING(categorycode) WHERE statistics.branch=<<branch|branches>> AND statistics.type IN ('issue', 'renew','localuse') AND YEAR(datetime)=<<enter year>> GROUP BY categories.category_type



