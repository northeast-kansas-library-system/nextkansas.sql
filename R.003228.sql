/*
R.003228

----------

Name: GHW - List / virtualshelf report 005 - Display list titles with links to bibliographic records
Created by: George Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 16:43:43
Modified on: 2024-01-17 12:08:23
Date last run: 2022-03-29 14:07:32

----------

Public: 0
Expiry: 300

----------

 
Shows the titles on a list with just the author and title and links to the title's bibliographic record
Displays titles currently on a list
only displays the list you specify
grouped by biblionumber
sorted by author and title
links to the title

Notes:

To determine the list id number, look at the URL for the list and take the number off of the end of the URL. For example, the list at
https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=6003
would be list number 6003.

Can be accessed by running reports 3224 or 3225 and clicking on the link in the "REPORT_TO_PRINT" column

Replaces the following reports:

3003 - List information


Click here to run in a new window


----------
*/



SELECT
  biblio.author,
  biblio.title,
  Concat('Go to title') AS BUTTON
FROM
  biblio
  JOIN virtualshelfcontents
    ON biblio.biblionumber = virtualshelfcontents.biblionumber
WHERE
  virtualshelfcontents.shelfnumber LIKE &lt;&gt;
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title

























