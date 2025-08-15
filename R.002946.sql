/*
R.002946

----------

Name: GHW - Library information for contact list
Created by: George Williams

----------

Group: -
     -

Created on: 2017-05-12 01:07:13
Modified on: 2024-01-17 11:49:38
Date last run: 2023-02-24 09:00:08

----------

Public: 0
Expiry: 86400

----------

 
Generates the table that gets used for the contacts tab on the "Library contact information" tab on the circulation home page
Shows current contact information
For all libraries
grouped and sorted by library location code
contains links to each branch's home page that open in a new window/tab

Notes:

Updated on 2022.05.04 to include: Registered borrowers = Number of borrowers with this home library

Updated on 2023.02.23 to remove active borrowers in previous 12 months



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
      Count(DISTINCT items.biblionumber)
    ),
    Concat(
      'Total items: ',
      Count(DISTINCT items.itemnumber)
    ),
    ' ',
    Concat('Last updated: ', Now())
  ) AS "Staff contacts / holdings"
FROM branches
  LEFT JOIN items 
    ON items.homebranch = branches.branchcode
  LEFT JOIN (
    SELECT borrowers.branchcode,
      Count(DISTINCT borrowers.borrowernumber) AS TOTAL_REGISTERED
    FROM borrowers
    GROUP BY borrowers.branchcode
  ) total_borrowerss 
    ON total_borrowerss.branchcode = branches.branchcode
WHERE 
  branches.branchcode LIKE "%"
GROUP BY 
  branches.branchcode
ORDER BY 
  Library
LIMIT 
  500

























