/*
R.002523

----------

Name: Holds with duplicate priorities
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2015-06-17 11:13:16
Modified on: 2015-08-26 10:11:02
Date last run: 2017-07-11 11:42:06

----------

Public: 0
Expiry: 0

----------

Report any biblionumbers listed to ByWater on <a href="http://ticket.bywatersolutions.com/Ticket/Display.html?id=27428" target="_blank">ticket #27428</a>. 

----------
*/

SELECT biblionumber, GROUP_CONCAT(borrowernumber SEPARATOR ', '), GROUP_CONCAT(reserve_id SEPARATOR ', '), GROUP_CONCAT(priority SEPARATOR ', ') FROM reserves WHERE priority <> '0' GROUP BY biblionumber, priority HAVING count(priority) > 1



