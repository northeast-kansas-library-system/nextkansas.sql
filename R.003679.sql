/*
R.003679

----------

Name: GHW - Borrower accounts with staff interface access (for Koha SQL library and Mana)
Created by: George Williams

----------

Group: -
     -

Created on: 2022-11-21 14:27:56
Modified on: 2024-01-17 11:29:45
Date last run: 2025-05-12 10:27:02

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
  <p>Displays accounts with "Staff" permissions</p>
  <ul>
    <li>Shows current accounts that have staff permission</li>
    <li>at the library you choose</li>
    <li>grouped by borrower number</li>
    <li>sorted by Superlibrarian status followed by branchcode, userid, and borrower category</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Replaces Next Search Catalog reports 2743, 2459, and 2213.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#permissions</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

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
              CONCAT('---->circulate: ', permissions.code), 
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
                CONCAT('---->circulate: ', permissions.code), 
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
              CONCAT('---->catalogue: ', permissions.code), 
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
                CONCAT('---->catalogue: ', permissions.code), 
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
              CONCAT('---->parameters: ', permissions.code), 
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
                CONCAT('---->parameters: ', permissions.code), 
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
              CONCAT('---->borrowers: ', permissions.code), 
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
                CONCAT('---->borrowers: ', permissions.code), 
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
              CONCAT('---->permissions: ', permissions.code), 
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
                CONCAT('---->permissions: ', permissions.code), 
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
              CONCAT('---->reserveforothers: ', permissions.code), 
              '' 
            ) ORDER BY permissions.code SEPARATOR '' 
          ) = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 6, 
                CONCAT('---->reserveforothers: ', permissions.code), 
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
              CONCAT('---->editcatalogue: ', permissions.code), 
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
                CONCAT('---->editcatalogue: ', permissions.code), 
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
              CONCAT('---->updatecharges: ', permissions.code), 
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
                CONCAT('---->updatecharges: ', permissions.code), 
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
              CONCAT('---->acquisition: ', permissions.code), 
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
                CONCAT('---->acquisition: ', permissions.code), 
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
              CONCAT('---->suggestions: ', permissions.code), 
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
                CONCAT('---->suggestions: ', permissions.code), 
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
              CONCAT('---->tools: ', permissions.code), 
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
                CONCAT('---->tools: ', permissions.code), 
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
              CONCAT('---->editauthorities: ', permissions.code), 
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
                CONCAT('---->editauthorities: ', permissions.code), 
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
              CONCAT('---->serials: ', permissions.code), 
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
                CONCAT('---->serials: ', 
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
              CONCAT('---->reports: ', permissions.code), 
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
                CONCAT('---->reports: ', permissions.code), 
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
              CONCAT('---->staffaccess: ', permissions.code), 
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
                CONCAT('---->staffaccess: ', permissions.code), 
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
              CONCAT('---->coursereserves: ', permissions.code), 
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
                CONCAT('---->coursereserves: ', permissions.code), 
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
              CONCAT('---->plugins: ', 
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
                CONCAT('---->plugins: ', permissions.code), 
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
              CONCAT('---->lists: ', permissions.code), 
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
                CONCAT('---->lists: ', permissions.code), 
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
              CONCAT('---->clubs: ', permissions.code), 
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
                CONCAT('---->clubs: ', permissions.code), 
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
              CONCAT('---->ill: ', permissions.code), 
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
                CONCAT('---->ill: ', permissions.code), 
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
              CONCAT('---->self_check: ', permissions.code), 
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
                CONCAT('---->self_check: ', permissions.code), 
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
              CONCAT('---->stockrotation: ', permissions.code), 
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
                CONCAT('---->stockrotation: ', permissions.code), 
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
              CONCAT('---->cash_management: ', permissions.code), 
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
                CONCAT('---->cash_management: ', permissions.code), 
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
              CONCAT('---->problem_reports: ', permissions.code), 
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
                CONCAT('---->problem_reports: ', permissions.code), 
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
        "recalls - All parameters", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 27, 
              CONCAT('---->recalls: ', permissions.code), 
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
                CONCAT('---->recalls: ', permissions.code), 
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
  ((borrowers.flags > 0) OR 
    (user_permissions.module_bit > 0)) AND 
  borrowers.branchcode LIKE <> 
GROUP BY 
  borrowers.borrowernumber 
ORDER BY 
  borrowers.flags MOD 2 DESC, 
  borrowers.branchcode, 
  borrowers.userid, 
  borrowers.categorycode 

























