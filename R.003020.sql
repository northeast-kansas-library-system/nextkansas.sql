/*
R.003020

----------

Name: GHW - List of lists
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2017-12-20 18:57:28
Modified on: 2019-07-17 16:59:16
Date last run: 2019-07-17 16:57:58

----------

Public: 0
Expiry: 300

----------

<p>&nbsp;</p>
<p><span style="background-color: darkred; color: white">Scheduled for deletion on August 31, 2019</p>
<p><span style="background-color: black; color: white">Is being replaced by report 3223, 3224, 3225</p>
<p>&nbsp;</p>

----------
*/

SELECT
  virtualshelves.shelfnumber,
  If(virtualshelves.category = 1, "-", Concat("<a href='https://catalog.nexpresslibrary.org/cgi-bin/koha/opac-shelves.pl?op=view&shelfnumber=", virtualshelves.shelfnumber, "/'  target='_blank'>Link to OPAC</a>")) AS OPAC_LINK,
  If(virtualshelves.category = 1, "-", Concat("<a href='/cgi-bin/koha/virtualshelves/shelves.pl?op=view&shelfnumber=", virtualshelves.shelfnumber, "/' target='_blank'>Link to staff client</a>")) AS STAFF_LINK,
  Concat("<a href='/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=3021&sql_params=", virtualshelves.shelfnumber, "&limit=1000/' target='_blank'>Print list</a>") AS PRINT_LIST_LINK,
  virtualshelves.shelfname,
  Count(virtualshelfcontents.biblionumber) AS LIST_COUNT,
  If(virtualshelves.category = 1, "Private list", "Public list") AS LIST_TYPE,
  Coalesce(borrowers.cardnumber, "-") AS cardnumber,
  Coalesce(virtualshelves.owner, "-") AS owner
FROM
  virtualshelves
  LEFT JOIN borrowers ON virtualshelves.owner = borrowers.borrowernumber
  LEFT JOIN virtualshelfcontents ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
WHERE
  virtualshelves.category LIKE <<Enter list privacy level|LVSHELFPR>> AND
  Coalesce(borrowers.cardnumber, "-") LIKE Concat("%", <<Enter patron's library card number or % to see all lists>> ,"%")
GROUP BY
  virtualshelves.shelfnumber,
  Coalesce(borrowers.cardnumber, "-"),
  Coalesce(virtualshelves.owner, "-")



