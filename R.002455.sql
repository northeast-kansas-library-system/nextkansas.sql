/*
R.002455

----------

Name: Test public report
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-02-02 15:27:34
Modified on: 2015-08-16 20:00:53
Date last run: -

----------

Public: 0
Expiry: 0

----------

(not currently a public report) link for public report when active: https://catalog.nexpresslibrary.org/cgi-bin/koha/svc/report?id=2455

----------
*/

SELECT b.title from biblioitems t left join biblio b using(biblionumber) where t.publicationyear='2015' LIMIT 20



