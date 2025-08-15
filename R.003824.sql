/*
R.003824

----------

Name: GHW - Basic borrower category list
Created by: George Williams

----------

Group: -
     -

Created on: 2024-04-11 15:26:33
Modified on: 2024-07-22 00:54:42
Date last run: 2024-07-23 10:38:53

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  categories.description,
  categories.categorycode,
  CASE
    WHEN
      categories.category_type = 'A'
    THEN 'Adult'
    WHEN
      categories.category_type = 'C'
    THEN 'Child'
    WHEN
      categories.category_type = 'S'
    THEN 'Staff'
    WHEN
      categories.category_type = 'I'
    THEN 'Organization'
    WHEN
      categories.category_type = 'P'
    THEN 'Professional'
    WHEN
      categories.category_type = 'X'
    THEN 'Statistical'
    ELSE categories.category_type
  END AS TYPE,
  If(
    (categories.dateofbirthrequired + categories.upperagelimit) = 999, 
    'Any age', 
    IF(
      (categories.dateofbirthrequired + categories.upperagelimit) = 118, 
      'Special category', 
      IF(
        (categories.dateofbirthrequired + categories.upperagelimit) = 1099,
        'Special category',
        If(
          categories.upperagelimit = 999, 
          Concat_Ws('', categories.dateofbirthrequired, ' and up'), 
          Concat_Ws('', categories.dateofbirthrequired, ' - ', categories.upperagelimit)
        )
      )
    )
  ) AS AGE_RANGE
FROM
  categories
ORDER BY
  DESCRIPTION, 
  categories.categorycode
LIMIT 1000

























