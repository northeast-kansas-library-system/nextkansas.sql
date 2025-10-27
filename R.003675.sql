/*
R.003675

----------

Name: GHW - Borrower accounts with staff interface access
Created by: George Williams

----------

Group: -
     -

Created on: 2022-11-04 11:17:50
Modified on: 2025-01-24 11:06:44
Date last run: 2025-09-06 10:12:19

----------

Public: 0
Expiry: 300

----------

 
  Displays accounts with "Staff" permissions
  
    Shows current accounts
    at the library you choose
    grouped by borrower number
    sorted by Superlibrarian status followed by branchcode, userid, and borrower category
  
  Notes:
  
  Replaces reports 2743, 2459, and 2213.
  
  #permissions
  


----------
*/



SELECT 
  Concat( 
    'Go to borrower' 
  ) AS LINK_TO_BORROWER, 
  borrowers.userid, 
  If( 
    categories.category_type LIKE 'S%', 
    categories.description, 
    Concat('', categories.description, '') 
  ) AS BORROWER_CATEGORY, 
  branches.branchname AS HOME_LIBRARY, 
  borrowers.lastseen AS DATE_LAST_LOGGED_IN, 
  If( 
    borrowers.flags MOD 2, 
    'Superlibrarian', 
    CONCAT_WS('', 
      '-----Library staff-----', 
      char(10), 
      If( 
        MOD(borrowers.flags DIV 2, 2), 
        Concat('circulate - All parameters -', char(10)), 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 1, 
              CONCAT(char(10), '-----circulate: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 1, 
                CONCAT(char(10), '-----circulate: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4, 2), 
        Concat(char(10), 'catalogue - All parameters -', char(10)),
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 2, 
              CONCAT(char(10), '-----catalogue: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 2, 
                CONCAT('-----catalogue: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8, 2), 
        "parameters - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 3, 
              CONCAT('-----parameters: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 3, 
                CONCAT('-----parameters: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 16, 2), 
        "borrowers - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 4, 
              CONCAT('-----borrowers: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 4, 
                CONCAT('-----borrowers: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 32, 2), 
        "permissions - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 5, 
              CONCAT('-----permissions: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 5, 
                CONCAT('-----permissions: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 64, 2), 
        "reserveforothers - All parameters -", 
        IF( 
          GROUP_CONCAT(DISTINCT If(user_permissions.module_bit = 6, CONCAT('-----reserveforothers: ', permissions.code, '-'), '') ORDER BY permissions.code SEPARATOR '') = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 6, 
                CONCAT('-----reserveforothers: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 128, 2), 
        'FLAG7 Uh-oh', 
        '' 
      ), 
      If( 
        MOD(borrowers.flags DIV 256, 2), 
        'FLAG8 Uh-oheditcatalogue - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 9, 
              CONCAT('-----editcatalogue: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT If( 
                user_permissions.module_bit = 9, 
                CONCAT('-----editcatalogue: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 1024, 2), 
        "updatecharges - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 10, 
              CONCAT('-----updatecharges: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 10, 
                CONCAT('-----updatecharges: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 2048, 2), 
        "acquisition - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 11, 
              CONCAT('-----acquisition: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 11, 
                CONCAT('-----acquisition: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4096, 2), 
        "suggestions - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 12, 
              CONCAT('-----suggestions: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 12, 
                CONCAT('-----suggestions: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8192, 2), 
        "tools - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 13, 
              CONCAT('-----tools: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 13, 
                CONCAT('-----tools: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 16384, 2), 
        "editauthorities - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 14, 
              CONCAT('-----editauthorities: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 14, 
                CONCAT('-----editauthorities: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 32768, 2), 
        "serials - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 15, 
              CONCAT('-----serials: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 15, 
                CONCAT('-----serials: ', 
                  permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 65536, 2), 
        "reports - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 16, 
              CONCAT('-----reports: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 16, 
                CONCAT('-----reports: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 131072, 2), 
        "staffaccess - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 17, 
              CONCAT('-----staffaccess: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 17, 
                CONCAT('-----staffaccess: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 262144, 2), 
        "coursereserves - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 18, 
              CONCAT('-----coursereserves: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 18, 
                CONCAT('-----coursereserves: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 524288, 2), 
        "plugins - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 19, 
              CONCAT('-----plugins: ', 
                permissions.code 
              ), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 19, 
                CONCAT('-----plugins: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 1048576, 2), 
        "lists - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 20, 
              CONCAT('-----lists: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 20, 
                CONCAT('-----lists: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 2097152, 2), 
        "clubs - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 21, 
              CONCAT('-----clubs: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 21, 
                CONCAT('-----clubs: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4194304, 2), 
        "ill - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 22, 
              CONCAT('-----ill: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 22, 
                CONCAT('-----ill: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY 
              permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8388608, 2), 
        "self_check - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 23, 
              CONCAT('-----self_check: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 23, 
                CONCAT('-----self_check: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 16777216, 2), 
        "stockrotation - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 24, 
              CONCAT('-----stockrotation: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 24, 
                CONCAT('-----stockrotation: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR ''), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 33554432, 2), 
        "cash_management - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 25, 
              CONCAT('-----cash_management: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 25, 
                CONCAT('-----cash_management: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 67108864, 2), 
        "problem_reports - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 26, 
              CONCAT('-----problem_reports: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 26, 
                CONCAT('-----problem_reports: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 134217728, 2), 
        "recalls - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 27, 
              CONCAT('-----recalls: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 27, 
                CONCAT('-----recalls: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 268435456, 2), 
        "erm - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 28, 
              CONCAT('-----erm: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 28, 
                CONCAT('-----erm: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 536870912, 2), 
        "loggedinlibrary - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 29, 
              CONCAT('-----loggedinlibrary: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 29, 
                CONCAT('-----loggedinlibrary: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 1073741824, 2), 
        "preservation - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 30, 
              CONCAT('-----preservation: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 30, 
                CONCAT('-----preservation: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 2147483648, 2), 
        "undefined in  in 24.11 - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 31, 
              CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 31, 
                CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4294967296, 2), 
        "undefined in  in 24.11 - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 32, 
              CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 32, 
                CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8589934592, 2), 
        "undefined in  in 24.11 - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 33, 
              CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 33, 
                CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 17179869184, 2), 
        "undefined in  in 24.11 - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 34, 
              CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 34, 
                CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 34359738368, 2), 
        "undefined in  in 24.11 - All parameters -", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 35, 
              CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
              '' 
            ) 
            ORDER BY permissions.code 
            SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 35, 
                CONCAT('-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '' 
          ) 
        ) 
      ) 
    ) 
  ) AS PERMISSIONS, 
  attributes.ATTRIBUTE 
FROM 
  borrowers 
  LEFT JOIN user_permissions 
    ON borrowers.borrowernumber = user_permissions.borrowernumber 
  LEFT JOIN permissions 
    ON user_permissions.code = permissions.code 
  JOIN categories 
    ON borrowers.categorycode = categories.categorycode 
  JOIN branches 
    ON borrowers.branchcode = branches.branchcode 
 
  LEFT JOIN ( 
    SELECT 
      borrower_attributes.borrowernumber, 
      GROUP_CONCAT( 
        Concat_WS('', 
          borrower_attribute_types.description, 
          ' - ',
          authorised_values.lib,
          '',
          char(10),
          char(10)
        ) 
        ORDER BY borrower_attribute_types.description, authorised_values.lib 
      

||AAAAA||

  SEPARATOR ''
      ) AS ATTRIBUTE 
    FROM 
      borrower_attribute_types 
      JOIN authorised_values 
        ON authorised_values.category = borrower_attribute_types.authorised_value_category 
      JOIN borrower_attributes 
        ON borrower_attributes.code = borrower_attribute_types.code 
        AND authorised_values.authorised_value = borrower_attributes.attribute 
    WHERE 
      borrower_attribute_types.class = 'STAFF' 
    GROUP BY 
      borrower_attributes.borrowernumber 
  ) attributes 
    ON attributes.borrowernumber = borrowers.borrowernumber 
WHERE 
  ((borrowers.flags &gt; 0) OR 
    (user_permissions.module_bit &gt; 0)) AND 
  borrowers.branchcode LIKE "%" 
GROUP BY 
  borrowers.borrowernumber 
ORDER BY 
  borrowers.flags MOD 2 DESC, 
  borrowers.branchcode, 
  borrowers.userid 
LIMIT 1000





















