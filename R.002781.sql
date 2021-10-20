/*
R.002781

----------

Name: Sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-28 11:45:44
Modified on: 2021-10-01 14:29:51
Date last run: 2021-10-01 23:19:16

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  reserves.reserve_id,
  borrowers.branchcode,
  reserves.expirationdate,
  Concat(
    '<a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    reserves.biblionumber, 
    '" target="_blank">Go to biblio</a>'
  ) AS BORROWER,
  Concat(
    '<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', 
    reserves.borrowernumber, 
    '#add_message_form" target="_blank">Go to borrower</a>'
  ) AS BORROWER,
  Concat_Ws('', 
    '&lt;div style="font-size: 125%;"&gt;&lt;br /&gt;REQUEST CANCELLED&lt;br /&gt;', 
    Upper(
      Concat_Ws(' ', 
        '&lt;ins&gt;&lt;i&gt;TITLE&lt;/i&gt;&lt;/ins&gt;: ', 
        biblio.title, 
        biblio.subtitle, 
        biblioitems.number, 
        biblio.part_name
      )
    ), 
    '&lt;br /&gt;', 
    If(biblio.author IS NULL, "", Concat_Ws('', '\&lt;ins\&gt;&lt;i&gt;AUTHOR&lt;/i&gt;&lt;/ins&gt;: ', biblio.author, '&lt;br /&gt;')), 
    '&lt;ins&gt;&lt;i&gt;REASON&lt;/i&gt;&lt;/ins&gt;: All copies in the system have been removed from circulation.&lt;br /&gt;', 
    Concat_Ws('', 
      'Request originally placed on ', 
      reserves.reservedate, 
      ' for pickup at ', 
      reserves_branches.branchname, 
      '&lt;br /&gt;'
    ), 
    Concat_Ws('', 
      'Request cancelled on ', 
      CurDate(), 
      '.&lt;br /&gt;', 
      'Please contact your library at ', 
      borrower_branches.branchphone, 
      ' for more information.&lt;/div&gt;'
    )
  ) AS MESSAGE
FROM
  (SELECT
      biblio.biblionumber AS biblionumber,
      Count(items.itemnumber) AS COUNT_IN,
      Coalesce(nfl_d_l_w_items.Count_itemnumber, 0) AS UNCOUNT,
      (Count(items.itemnumber) - Coalesce(nfl_d_l_w_items.Count_itemnumber,
      0)) AS COUNTING
    FROM
      biblio LEFT JOIN
      (SELECT
          items.biblionumber,
          Count(items.itemnumber) AS Count_itemnumber
        FROM
          items
        WHERE
          (items.notforloan >= 1) OR
          (items.damaged >= 1) OR
          (items.itemlost >= 1) OR
          (items.withdrawn >= 1)
        GROUP BY
          items.biblionumber) nfl_d_l_w_items ON nfl_d_l_w_items.biblionumber =
          biblio.biblionumber JOIN
      items ON items.biblionumber = biblio.biblionumber
    GROUP BY
      biblio.biblionumber
    HAVING
      COUNT_IN - UNCOUNT = 0) count_out JOIN
  reserves ON count_out.biblionumber = reserves.biblionumber JOIN
  biblio ON reserves.biblionumber = biblio.biblionumber JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  branches reserves_branches ON
      reserves.branchcode = reserves_branches.branchcode JOIN
  borrowers ON reserves.borrowernumber = borrowers.borrowernumber JOIN
  branches borrower_branches ON
      borrowers.branchcode = borrower_branches.branchcode
WHERE
  reserves.reservedate < Now() - INTERVAL 90 DAY AND
  reserves.expirationdate is null
ORDER BY
  borrowers.branchcode,
  reserves.reservedate

























