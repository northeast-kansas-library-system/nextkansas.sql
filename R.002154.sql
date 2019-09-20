/*
R.002154

----------

Name: Yearly Circulation at your library by Patron Category
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2014-01-13 17:42:50
Modified on: 2014-01-13 18:02:02
Date last run: 2019-09-11 13:31:43

----------

Public: 0
Expiry: 0

----------

Does not account for deleted patron accounts' circulation [which isn't possible to track at this time]

----------
*/

SELECT borrowers.categorycode, 
case
  when categories.category_type= 'A' then 'Adult'
  when categories.category_type= 'C' then 'Child'
  when categories.category_type= 'I' then 'ILL'
  when categories.category_type= 'P' then 'Professional'
  when categories.category_type= 'S' then 'Staff'
  when categories.category_type= 'X' then 'Statistical'
  else categories.category_type end as categorytype, COUNT(*) FROM statistics JOIN borrowers USING (borrowernumber) LEFT JOIN categories USING(categorycode) WHERE statistics.branch=<<branch|branches>> AND statistics.type IN ('issue', 'renew','localuse') AND YEAR(datetime)=<<enter year>> GROUP BY borrowers.categorycode



