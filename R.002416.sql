/*
R.002416

----------

Name: Checkouts, Checkins, Renewals on a specific date
Created by: Heather Braum

----------

Group: Daily, Monthly, Yearly Stats
     Daily

Created on: 2014-11-17 15:29:59
Modified on: 2014-11-17 15:42:44
Date last run: 2025-10-06 09:37:29

----------

Public: 0
Expiry: 0

----------

This report returns circulation statistics (checkins, checkouts, renewals) for a single date that you enter for your library. It breaks down the number of checkins, checkouts, and renewals per hour of a day. 

----------
*/



SELECT month(datetime), day(datetime), hour(datetime), type, count(&ast;) FROM statistics WHERE branch=&lt;&gt; AND datetime LIKE &lt;&gt; GROUP BY day(datetime), hour(datetime), type

























