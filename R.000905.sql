/*
R.000905

----------

Name: Titles with 20+ holds. 
Created by:  Tongie Book Club

----------

Group: Popular Reports
     -

Created on: 2010-08-16 15:45:59
Modified on: 2015-08-16 17:01:23
Date last run: 2023-04-25 15:59:25

----------

Public: 0
Expiry: 0

----------

Run to get a list of bib numbers, titles, etc. for Titles with 20+ holds. #holds

----------
*/



select reserves.biblionumber, biblio.title, biblio.author, biblioitems.publicationyear, biblio.notes, count(*) AS "Number of Holds" from reserves left join biblio USING (biblionumber) left join biblioitems USING(biblionumber) group by reserves.biblionumber having count(*) > 19 ORDER BY count(*) DESC

























