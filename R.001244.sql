/*
R.001244

----------

Name: Circ Stats for Specific day
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Daily

Created on: 2011-11-23 13:12:03
Modified on: 2014-01-08 16:33:25
Date last run: 2021-07-01 12:39:27

----------

Public: 0
Expiry: 0

----------

Enhanced. Choose Run --> 1) Enter the date you want to count + % (ex. 2011-11-16%). 2) Choose your branch.  #circ

----------
*/

SELECT COUNT(*) FROM statistics WHERE statistics.type IN ('issue','renew') AND statistics.datetime LIKE <<Date you want to count and % (example: 2011-11-16%) >> AND statistics.branch = <<Pick your branch|branches>> 



