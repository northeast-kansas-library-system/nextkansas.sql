/*
R.003897

----------

Name: Local Cover Images
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2025-07-21 11:43:44
Modified on: 2025-07-21 13:36:31
Date last run: 2025-07-21 13:36:31

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT c.biblionumber, b.title, b.author
FROM cover_images c 
	JOIN biblio b ON (c.biblionumber = b.biblionumber)

























