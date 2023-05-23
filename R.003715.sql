/*
R.003715

----------

Name: Library contact information - updated
Created by: George H Williams

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
      Replace(branches.branchname, ' - ', '<br />'), 
      '<p><ins>Mailing address:</ins><br />', 
      Concat_Ws( 
        '<br />', 
        branches.branchaddress1, 
        Concat( 
          branches.branchcity, 
          ', ', 
          branches.branchstate, 
          ' ', 
          branches.branchzip 
        ) 
      ), 
      '</p>' 
    ), 
    Concat( 
      '<ins>Street address:</ins><br />', 
      Concat_Ws( 
        '<br />', 
        If( 
          branches.branchaddress2 = ' ', 
          branches.branchaddress1, 
          branches.branchaddress2 
        ), 
        Concat( 
          branches.branchcity, 
          ', ', 
          branches.branchstate, 
          '<br />' 
        ) 
      ) 
    ) 
  ) AS Library, 
  Concat_Ws( 
    '<p>', 
    Concat('<p>Phone: ', branches.branchphone, '</p>'), 
    Concat('Fax: ', branches.branchfax, '</p>'), 
    Concat('e-mail: ', branches.branchemail, '</p>'), 
    Concat( 
      'Website: <a href="', 
      branches.branchurl, 
      '" target="_blank">Click here</a></p>' 
    ), 
    Concat( 
      'Courier route #: ', 
      branches.branchcountry, 
      '</p>', 
      Concat('<br /><p>Branch name: ', branches.branchname), 
      '</p>', 
      Concat('<p>Branch code: ', branches.branchcode), 
      '</p>' 
    ) 
  ) AS "Contact information", 
  Concat_Ws( 
    '<br />', 
    Replace( 
      Replace( 
        Replace(branches.branchaddress3, '|', '<br /><br />'), 
        'Director:', 
        '<span style="background: yellow; text-decoration: underline; font-size: 120%;">Director:</span><br />' 
      ), 
      'Accreditation:', 
      '<span style="background: aqua; text-decoration: underline; font-size: 120%;">Type:</span><br />' 
    ), 
    ' ', 
    Concat( 
      '<span style="background: wheat; text-decoration: underline;">Registered borrowers:</span> ', 
      total_borrowerss.TOTAL_REGISTERED 
    ), 
    ' ', 
    Concat( 
      '<span style="background: wheat; text-decoration: underline;">Total titles:</span> ', 
      Coalesce(total_titles.Count_biblionumber, 0) 
    ), 
    Concat( 
      '<span style="background: wheat; text-decoration: underline;">Total items:</span> ', 
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

























