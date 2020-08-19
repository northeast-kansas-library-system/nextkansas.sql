/*
R.002279

----------

Name: Which titles have the most holds by your patrons?
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2014-06-10 15:16:34
Modified on: 2015-08-16 20:51:25
Date last run: 2020-07-02 18:18:37

----------

Public: 0
Expiry: 0

----------

Returns titles with holds by your patrons, sorted by the records with the biggest number of your patrons with holds on them (based on their hold pickup location). 

----------
*/

select CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Link to Record", b.title, b.author, t.publicationyear, count(*) AS "Number of Holds by Your Patrons" from reserves r left join biblio b USING (biblionumber) left join biblioitems t USING(biblionumber) where r.branchcode = <<branch|branches>> group by r.biblionumber ORDER BY count(*) DESC, r.reservedate DESC



