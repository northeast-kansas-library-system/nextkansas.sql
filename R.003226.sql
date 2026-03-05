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

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Creates a simple printable list of titles and authors from a list&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Displays titles and authors currently on a list&lt;/li&gt;
&lt;li&gt;you need to specify the list number (see below for more informaiton)&lt;/li&gt;
&lt;li&gt;grouped by biblio number&lt;/li&gt;
&lt;li&gt;sorted by author and title&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;To determine the list id number, look at the URL for the list and take the number off of the end of the URL.  For example, the list at&lt;br /&gt;
https://staff.nextkansas.org/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=6003&lt;br /&gt;
would be list number 6003.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Can be accessed by running reports 3224 or 3225 and clicking on the link in the "LINKS_TO_TITLES" column&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces report:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;1746 - Shelf List from a Private List&lt;/li&gt;
&lt;li&gt;3021 - GHW - Print a list - variant&lt;/li&gt;
&lt;li&gt;3063 - GHW - Print list by ID number&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3226&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

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

























