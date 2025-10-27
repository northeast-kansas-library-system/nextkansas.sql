/*
R.001275

----------

Name: List of Titles with Holds
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2011-12-18 19:08:58
Modified on: 2013-11-17 13:44:27
Date last run: 2025-09-02 15:24:23

----------

Public: 0
Expiry: 0

----------

Enhanced. Choose library. #holds

----------
*/



SELECT biblio.biblionumber, items.ccode, CONCAT('',biblio.title,'')
AS Title, items.dateaccessioned, CONCAT('',biblio.biblionumber,'') AS bibnumber
FROM biblio LEFT JOIN items USING (biblionumber) LEFT JOIN reserves USING (biblionumber) WHERE reserves.borrowernumber IS NOT NULL and items.homebranch =&lt;&gt; GROUP BY biblio.biblionumber ORDER BY biblio.biblionumber DESC LIMIT 1000

























