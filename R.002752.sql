/*
R.002752

----------

Name: Standalone records range report after a migration
Created by: Heather Braum

----------

Group: Administrative Reports
     Post-Lansing

Created on: 2016-08-30 17:44:12
Modified on: 2017-12-19 09:30:16
Date last run: -

----------

Public: 0
Expiry: 0

----------

(that aren't empty)

----------
*/

SELECT DISTINCT biblio.biblionumber, biblio.title, biblio.author, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="020"]/subfield[@code>="a"]') FROM items LEFT JOIN biblio USING(biblionumber) LEFT JOIN biblio_metadata USING(biblionumber) 
WHERE biblio.biblionumber BETWEEN '745658 ' AND '756704' and biblio.datecreated = '2016-08-26' and biblio.timestamp < '2016-08-28'



