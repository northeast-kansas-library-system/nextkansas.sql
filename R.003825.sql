/*
R.003825

----------

Name: GHW - Borrower Category Cleanup
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-11 15:39:29
Modified on: 2024-04-11 16:04:17
Date last run: 2025-06-23 09:52:53

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  branches.branchname,
  available.available AS AVAILABLE,
  GROUP_CONCAT(
    DISTINCT actual.actual
    ORDER BY actual.actual SEPARATOR ' '
  ) AS ACTUAL,
  GROUP_CONCAT(
    DISTINCT exempt.exempt
    ORDER BY exempt.exempt SEPARATOR ' '
  ) AS EXEMPT,
  GROUP_CONCAT(
    DISTINCT other.other
    ORDER BY other.other SEPARATOR ' '
  ) AS OTHER
FROM branches
  LEFT JOIN (
    SELECT 
      categories_branches.branchcode,
      GROUP_CONCAT(
        '<li>',
        categories.description,
        '</li>'
        ORDER BY categories.description SEPARATOR ' '
      ) AS available
    FROM categories_branches
      JOIN categories ON categories_branches.categorycode = categories.categorycode
    GROUP BY categories_branches.branchcode
    ORDER BY categories_branches.branchcode
  ) available 
  ON available.branchcode = branches.branchcode
  LEFT JOIN (
    SELECT 
      borrowers.branchcode,
      Concat(
        '<li>',
        categories.description,
        ': ',
        Count(DISTINCT borrowers.borrowernumber),
        If(
          categories_branches.branchcode IS NOT NULL,
          '</li>',
          ' (See notes)</li>'
        )
      ) AS actual
    FROM categories
      JOIN borrowers ON borrowers.categorycode = categories.categorycode
      LEFT JOIN categories_branches ON categories_branches.categorycode = categories.categorycode
      AND categories_branches.branchcode = borrowers.branchcode
    GROUP BY borrowers.branchcode,
      categories.description
  ) actual 
  ON actual.branchcode = branches.branchcode
  LEFT JOIN (
    SELECT 
      categories_branches.branchcode,
      Concat_Ws(
        '',
        '<li>',
        categories.description,
        ': ',
        Count(borrowers.borrowernumber),
        '</li>'
      ) AS exempt
    FROM categories_branches
      JOIN categories ON categories_branches.categorycode = categories.categorycode
      JOIN borrowers ON borrowers.categorycode = categories.categorycode
      AND borrowers.branchcode = categories_branches.branchcode
    WHERE (
        categories.categorycode = 'ASSOCIATE'
        OR categories.categorycode = 'STUDENT'
        OR categories.categorycode = 'TEACHER'
      )
    GROUP BY categories_branches.branchcode,
      categories.categorycode
    ORDER BY categories_branches.branchcode
  ) exempt 
  ON exempt.branchcode = branches.branchcode
  LEFT JOIN (
    SELECT 
      categories_branches.branchcode,
      Concat_Ws(
        '',
        '<li>',
        categories.description,
        ': ',
        Count(borrowers.borrowernumber),
        '</li>'
      ) AS other
    FROM categories_branches
      JOIN categories ON categories_branches.categorycode = categories.categorycode
      JOIN borrowers ON borrowers.categorycode = categories.categorycode
      AND borrowers.branchcode = categories_branches.branchcode
    WHERE (
        categories.categorycode = 'OTHERADULT'
        OR categories.categorycode = 'OTHERCHILD'
      )
    GROUP BY categories_branches.branchcode,
      categories.categorycode
    ORDER BY categories_branches.branchcode
  ) other 
  ON other.branchcode = branches.branchcode
GROUP BY branches.branchname,
  available.available

























