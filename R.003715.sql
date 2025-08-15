/*
R.003715

----------

Name: Library contact information - updated
Created by: George Williams

----------

Group: -
     -

Created on: 2023-02-24 11:03:55
Modified on: 2023-02-24 12:04:55
Date last run: 2023-05-08 11:40:16

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  Concat( 
    Concat( 
      Replace(branches.branchname, ' - ', ''), 
      'Mailing address:', 
      Concat_Ws( 
        '', 
        branches.branchaddress1, 
        Concat( 
          branches.branchcity, 
          ', ', 
          branches.branchstate, 
          ' ', 
          branches.branchzip 
        ) 
      ), 
      '' 
    ), 
    Concat( 
      'Street address:', 
      Concat_Ws( 
        '', 
        If( 
          branches.branchaddress2 = ' ', 
          branches.branchaddress1, 
          branches.branchaddress2 
        ), 
        Concat( 
          branches.branchcity, 
          ', ', 
          branches.branchstate, 
          '' 
        ) 
      ) 
    ) 
  ) AS Library, 
  Concat_Ws( 
    '', 
    Concat('Phone: ', branches.branchphone, ''), 
    Concat('Fax: ', branches.branchfax, ''), 
    Concat('e-mail: ', branches.branchemail, ''), 
    Concat( 
      'Website: Click here' 
    ), 
    Concat( 
      'Courier route #: ', 
      branches.branchcountry, 
      '', 
      Concat('Branch name: ', branches.branchname), 
      '', 
      Concat('Branch code: ', branches.branchcode), 
      '' 
    ) 
  ) AS "Contact information", 
  Concat_Ws( 
    '', 
    Replace( 
      Replace( 
        Replace(branches.branchaddress3, '|', ''), 
        'Director:', 
        'Director:' 
      ), 
      'Accreditation:', 
      'Type:' 
    ), 
    ' ', 
    Concat( 
      'Registered borrowers: ', 
      total_borrowerss.TOTAL_REGISTERED 
    ), 
    ' ', 
    Concat( 
      'Total titles: ', 
      Coalesce(total_titles.Count_biblionumber, 0) 
    ), 
    Concat( 
      'Total items: ', 
      Coalesce(total_items.Count_itemnumber, 0) 
    ), 
    ' ', 
    Concat('Last updated: ', Now()) 
  ) AS "Staff contacts / holdings" 
FROM branches 
  LEFT JOIN 
    ( 
      SELECT borrowers.branchcode, 
        Count(DISTINCT borrowers.borrowernumber) AS TOTAL_REGISTERED 
      FROM borrowers 
      GROUP BY borrowers.branchcode 
    ) total_borrowerss 
  ON 
    total_borrowerss.branchcode = branches.branchcode 
  LEFT JOIN 
    ( 
      SELECT items.homebranch, 
        Count(DISTINCT items.itemnumber) AS Count_itemnumber 
      FROM items 
      GROUP BY items.homebranch 
    ) total_items 
  ON 
    total_items.homebranch = branches.branchcode 
  LEFT JOIN 
    ( 
      SELECT items.homebranch, 
        Count(DISTINCT items.biblionumber) AS Count_biblionumber 
      FROM items 
      GROUP BY items.homebranch 
    ) total_titles 
  ON 
    total_titles.homebranch = branches.branchcode 
GROUP BY 
  branches.branchcode 
ORDER BY 
  Library 
LIMIT 
  60

























