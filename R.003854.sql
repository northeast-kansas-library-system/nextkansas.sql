/*
R.003854

----------

Name: GHW - staff borrower list
Created by: George Williams

----------

Group: -
     -

Created on: 2024-07-29 16:15:23
Modified on: 2024-07-29 16:52:24
Date last run: 2024-11-18 16:13:45

----------

Public: 0
Expiry: 30

----------



----------
*/



SELECT
    Group_Concat(
      '<li><span style="font-weight: 1000">Permission list:</span> ', 
      '<a href="/cgi-bin/koha/patron_lists/list.pl?patron_list_id=',
      patron_list_patrons.patron_list_id,
      '" target="_blank">',
      patron_lists.name,
      '</a>',
      '</li>'
      ORDER BY patron_lists.name ASC 
    ) AS LIST_NAME
FROM
  patron_list_patrons JOIN
  patron_lists ON patron_list_patrons.patron_list_id = patron_lists.patron_list_id
WHERE
  patron_list_patrons.borrowernumber = <<borrowernumber>>

























