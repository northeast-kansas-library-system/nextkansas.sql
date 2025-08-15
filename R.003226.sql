/*
R.003226

----------

Name: GHW - List / virtualshelf report 003 - Display author/title information for a list - for printing
Created by: George Williams

----------

Group: Lists Module
     -

Created on: 2019-07-17 09:09:51
Modified on: 2024-01-17 12:07:56
Date last run: 2022-03-29 14:07:50

----------

Public: 0
Expiry: 300

----------

 
Creates a simple printable list of titles and authors from a list
Displays titles and authors currently on a list
you need to specify the list number (see below for more informaiton)
grouped by biblio number
sorted by author and title

Notes:

To determine the list id number, look at the URL for the list and take the number off of the end of the URL.  For example, the list at
https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=6003
would be list number 6003.

Can be accessed by running reports 3224 or 3225 and clicking on the link in the "LINKS_TO_TITLES" column

Replaces report:

1746 - Shelf List from a Private List
3021 - GHW - Print a list - variant
3063 - GHW - Print list by ID number


Click here to run in a new window


----------
*/



SELECT
  Concat("Title: ", Coalesce(biblio.title, '--'), "Author: ", Coalesce(biblio.author, '--'), "") AS TITLE_AUTHOR
FROM
  virtualshelfcontents
  LEFT JOIN biblio ON virtualshelfcontents.biblionumber = biblio.biblionumber
WHERE
  virtualshelfcontents.shelfnumber = &lt;&gt;
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.author,
  biblio.title

























