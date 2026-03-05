/*
R.003887

----------

Name: permissions sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2025-06-04 10:11:01
Modified on: 2025-06-05 12:37:36
Date last run: 2025-06-10 15:39:50

----------

Public: 0
Expiry: 300

----------

ADMINREPORT

----------
*/



SELECT 
    borrowers.borrowernumber, 
    borrowers.userid, 
    borrowers.categorycode, 
    borrowers.branchcode, 
    borrowers.lastseen, 
    If( 
      borrowers.flags MOD 2, 
      'Superlibrarian', 
      CONCAT_WS('', 
        '-----Library staff-----', 
        If( 
          MOD(borrowers.flags DIV 2, 2), 
          'circulate - All parameters', 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 1, 
                CONCAT('----&gt;circulate: ', permissions.code), 
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
                  CONCAT('----&gt;circulate: ', permissions.code), 
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
          'catalogue - All parameters', 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 2, 
                CONCAT('----&gt;catalogue: ', permissions.code), 
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
                  CONCAT('----&gt;catalogue: ', permissions.code), 
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
          "parameters - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 3, 
                CONCAT('----&gt;parameters: ', permissions.code), 
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
                  CONCAT('----&gt;parameters: ', permissions.code), 
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
          "borrowers - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 4, 
                CONCAT('----&gt;borrowers: ', permissions.code), 
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
                  CONCAT('----&gt;borrowers: ', permissions.code), 
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
          "permissions - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 5, 
                CONCAT('----&gt;permissions: ', permissions.code), 
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
                  CONCAT('----&gt;permissions: ', permissions.code), 
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
          "reserveforothers - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 6, 
                CONCAT('----&gt;reserveforothers: ', permissions.code), 
                '' 
              ) ORDER BY permissions.code SEPARATOR '' 
            ) = '', 
            '', 
            CONCAT( 
              GROUP_CONCAT( 
                DISTINCT 
                If( 
                  user_permissions.module_bit = 6, 
                  CONCAT('----&gt;reserveforothers: ', permissions.code), 
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
          'FLAG8 Uh-oheditcatalogue - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 9, 
                CONCAT('----&gt;editcatalogue: ', permissions.code), 
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
                  CONCAT('----&gt;editcatalogue: ', permissions.code), 
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
          "updatecharges - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 10, 
                CONCAT('----&gt;updatecharges: ', permissions.code), 
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
                  CONCAT('----&gt;updatecharges: ', permissions.code), 
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
          "acquisition - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 11, 
                CONCAT('----&gt;acquisition: ', permissions.code), 
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
                  CONCAT('----&gt;acquisition: ', permissions.code), 
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
          "suggestions - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 12, 
                CONCAT('----&gt;suggestions: ', permissions.code), 
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
                  CONCAT('----&gt;suggestions: ', permissions.code), 
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
          "tools - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 13, 
                CONCAT('----&gt;tools: ', permissions.code), 
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
                  CONCAT('----&gt;tools: ', permissions.code), 
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
          "editauthorities - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 14, 
                CONCAT('----&gt;editauthorities: ', permissions.code), 
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
                  CONCAT('----&gt;editauthorities: ', permissions.code), 
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
          "serials - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 15, 
                CONCAT('----&gt;serials: ', permissions.code), 
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
                  CONCAT('----&gt;serials: ', 
                    permissions.code), 
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
          "reports - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 16, 
                CONCAT('----&gt;reports: ', permissions.code), 
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
                  CONCAT('----&gt;reports: ', permissions.code), 
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
          "staffaccess - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 17, 
                CONCAT('----&gt;staffaccess: ', permissions.code), 
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
                  CONCAT('----&gt;staffaccess: ', permissions.code), 
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
          "coursereserves - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 18, 
                CONCAT('----&gt;coursereserves: ', permissions.code), 
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
                  CONCAT('----&gt;coursereserves: ', permissions.code), 
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
          "plugins - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 19, 
                CONCAT('----&gt;plugins: ', 
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
                  CONCAT('----&gt;plugins: ', permissions.code), 
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
          "lists - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 20, 
                CONCAT('----&gt;lists: ', permissions.code), 
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
                  CONCAT('----&gt;lists: ', permissions.code), 
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
          "clubs - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 21, 
                CONCAT('----&gt;clubs: ', permissions.code), 
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
                  CONCAT('----&gt;clubs: ', permissions.code), 
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
          "ill - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 22, 
                CONCAT('----&gt;ill: ', permissions.code), 
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
                  CONCAT('----&gt;ill: ', permissions.code), 
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
          "self_check - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 23, 
                CONCAT('----&gt;self_check: ', permissions.code), 
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
                  CONCAT('----&gt;self_check: ', permissions.code), 
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
          "stockrotation - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 24, 
                CONCAT('----&gt;stockrotation: ', permissions.code), 
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
                  CONCAT('----&gt;stockrotation: ', permissions.code), 
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
          "cash_management - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 25, 
                CONCAT('----&gt;cash_management: ', permissions.code), 
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
                  CONCAT('----&gt;cash_management: ', permissions.code), 
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
          "problem_reports - All parameters", 
          IF( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 26, 
                CONCAT('----&gt;problem_reports: ', permissions.code), 
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
                  CONCAT('----&gt;problem_reports: ', permissions.code), 
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
    ) AS PERMISSIONS 
  FROM 
    borrowers 
    LEFT JOIN user_permissions 
      ON borrowers.borrowernumber = user_permissions.borrowernumber 
    LEFT JOIN permissions 
      ON user_permissions.code = permissions.code 
  WHERE 
    ((borrowers.flags &gt; 0) OR 
      (user_permissions.module_bit &gt; 0)) AND 
    borrowers.branchcode LIKE &lt;&gt; 
  GROUP BY 
    borrowers.borrowernumber 
  ORDER BY 
    borrowers.flags MOD 2 DESC, 
    borrowers.branchcode, 
    borrowers.userid, 
    borrowers.categorycode

























