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
Date last run: 2025-10-27 13:37:58

----------

Public: 0
Expiry: 0

----------

Enhanced. Choose Run --&gt; 1) Enter the date you want to count + % (ex. 2011-11-16%). 2) Choose your branch.  #circ

----------
*/



SELECT COUNT(*) FROM statistics WHERE statistics.type IN ('issue','renew') AND statistics.datetime LIKE &lt;&gt; AND statistics.branch = &lt;&gt; 

























