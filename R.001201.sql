/*
R.001201

----------

Name: Collection Code List
Created by: -

----------

Group: Administrative Reports
     System-admin

Created on: 2011-10-11 10:55:27
Modified on: 2014-11-11 13:14:35
Date last run: 2018-10-24 12:58:55

----------

Public: 0
Expiry: 0

----------

Admin list of collection codes and descriptions

----------
*/

select * from authorised_values where category = 'CCODE' ORDER BY authorised_value LIMIT 100



