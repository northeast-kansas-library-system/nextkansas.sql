/*
R.003003

----------

Name: List information
Created by: Robin Hastings

----------

Group: Lists Module
     -

Created on: 2017-10-04 13:29:00
Modified on: 2019-07-17 16:57:38
Date last run: 2019-07-17 16:35:40

----------

Public: 0
Expiry: 300

----------

asks for virtual shelf number, found in URL of list

<p>&nbsp;</p>
<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>
<p><span style="background-color: black; color: white">Is being replaced by report 3228</p>
<p>&nbsp;</p>

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\">',biblio.title,'</a>') AS Title,author
FROM biblio,virtualshelfcontents
WHERE biblio.biblionumber=virtualshelfcontents.biblionumber
AND shelfnumber=<<Enter Shelf number>>



