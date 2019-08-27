/*
R.002591

----------

Name: A Month's Circ for Overbrook
Created by: Heather Braum

----------

Group: Library-Specific
     Overbrook

Created on: 2015-08-28 05:49:49
Modified on: 2016-07-01 12:23:35
Date last run: -

----------

Public: 0
Expiry: 0

----------

For whenever Overbrook needs their stat numbers early.

----------
*/

SELECT count(*) FROM statistics WHERE branch='OVERBROOK' AND year(datetime)=<<Choose Year|Year>> AND month(datetime)=<<Choose Month|Month>> AND type IN ('localuse','issue','renew')



