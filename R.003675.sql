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
Date last run: 2026-02-11 23:52:56

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
  <p>Displays accounts with "Staff" permissions</p>
  <ul>
    <li>Shows current accounts</li>
    <li>at the library you choose</li>
    <li>grouped by borrower number</li>
    <li>sorted by Superlibrarian status followed by branchcode, userid, and borrower category</li>
  </ul><br>
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Replaces reports 2743, 2459, and 2213.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#permissions</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT 
  Concat( 
    '<a class="next_btn next_light noprint" ', 
    'href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '\" target="_blank">Go to borrower</a>' 
  ) AS LINK_TO_BORROWER, 
  borrowers.userid, 
  If( 
    categories.category_type LIKE 'S%', 
    categories.description, 
    Concat('<span style="color: white; background-color: red">', categories.description, '</span>') 
  ) AS BORROWER_CATEGORY, 
  branches.branchname AS HOME_LIBRARY, 
  borrowers.lastseen AS DATE_LAST_LOGGED_IN, 
  If( 
    borrowers.flags MOD 2, 
    'Superlibrarian', 
    CONCAT_WS('', 
      '-----Library staff-----<br>', 
      char(10), 
      If( 
        MOD(borrowers.flags DIV 2, 2), 
        Concat('<br>circulate - All parameters -<br>', char(10)), 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 1, 
              CONCAT(char(10), '<br>-----circulate: ', permissions.code, '-'), 
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
                CONCAT(char(10), '<br>-----circulate: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4, 2), 
        Concat(char(10), '<br>catalogue - All parameters -<br>', char(10)),
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 2, 
              CONCAT(char(10), '<br>-----catalogue: ', permissions.code, '-'), 
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
                CONCAT('<br>-----catalogue: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8, 2), 
        "<br>parameters - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 3, 
              CONCAT('<br>-----parameters: ', permissions.code, '-'), 
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
                CONCAT('<br>-----parameters: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 16, 2), 
        "<br>borrowers - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 4, 
              CONCAT('<br>-----borrowers: ', permissions.code, '-'), 
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
                CONCAT('<br>-----borrowers: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 32, 2), 
        "<br>permissions - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 5, 
              CONCAT('<br>-----permissions: ', permissions.code, '-'), 
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
                CONCAT('<br>-----permissions: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 64, 2), 
        "<br>reserveforothers - All parameters -<br>", 
        IF( 
          GROUP_CONCAT(DISTINCT If(user_permissions.module_bit = 6, CONCAT('<br>-----reserveforothers: ', permissions.code, '-'), '') ORDER BY permissions.code SEPARATOR '') = '', 
          '', 
          CONCAT( 
            GROUP_CONCAT( 
              DISTINCT 
              If( 
                user_permissions.module_bit = 6, 
                CONCAT('<br>-----reserveforothers: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 128, 2), 
        '<br>FLAG7 Uh-oh<br>', 
        '' 
      ), 
      If( 
        MOD(borrowers.flags DIV 256, 2), 
        '<br>FLAG8 Uh-oh<br /', 
        '' 
      ), 
      If( 
        MOD(borrowers.flags DIV 512, 2), 
        "<br>editcatalogue - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 9, 
              CONCAT('<br>-----editcatalogue: ', permissions.code, '-'), 
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
                CONCAT('<br>-----editcatalogue: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 1024, 2), 
        "<br>updatecharges - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 10, 
              CONCAT('<br>-----updatecharges: ', permissions.code, '-'), 
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
                CONCAT('<br>-----updatecharges: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 2048, 2), 
        "<br>acquisition - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 11, 
              CONCAT('<br>-----acquisition: ', permissions.code, '-'), 
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
                CONCAT('<br>-----acquisition: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4096, 2), 
        "<br>suggestions - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 12, 
              CONCAT('<br>-----suggestions: ', permissions.code, '-'), 
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
                CONCAT('<br>-----suggestions: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8192, 2), 
        "<br>tools - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 13, 
              CONCAT('<br>-----tools: ', permissions.code, '-'), 
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
                CONCAT('<br>-----tools: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 16384, 2), 
        "<br>editauthorities - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 14, 
              CONCAT('<br>-----editauthorities: ', permissions.code, '-'), 
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
                CONCAT('<br>-----editauthorities: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 32768, 2), 
        "<br>serials - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 15, 
              CONCAT('<br>-----serials: ', permissions.code, '-'), 
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
                CONCAT('<br>-----serials: ', 
                  permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 65536, 2), 
        "<br>reports - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 16, 
              CONCAT('<br>-----reports: ', permissions.code, '-'), 
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
                CONCAT('<br>-----reports: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 131072, 2), 
        "<br>staffaccess - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 17, 
              CONCAT('<br>-----staffaccess: ', permissions.code, '-'), 
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
                CONCAT('<br>-----staffaccess: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 262144, 2), 
        "<br>coursereserves - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 18, 
              CONCAT('<br>-----coursereserves: ', permissions.code, '-'), 
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
                CONCAT('<br>-----coursereserves: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 524288, 2), 
        "<br>plugins - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 19, 
              CONCAT('<br>-----plugins: ', 
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
                CONCAT('<br>-----plugins: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 1048576, 2), 
        "<br>lists - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 20, 
              CONCAT('<br>-----lists: ', permissions.code, '-'), 
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
                CONCAT('<br>-----lists: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 2097152, 2), 
        "<br>clubs - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 21, 
              CONCAT('<br>-----clubs: ', permissions.code, '-'), 
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
                CONCAT('<br>-----clubs: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4194304, 2), 
        "<br>ill - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 22, 
              CONCAT('<br>-----ill: ', permissions.code, '-'), 
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
                CONCAT('<br>-----ill: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY 
              permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8388608, 2), 
        "<br>self_check - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 23, 
              CONCAT('<br>-----self_check: ', permissions.code, '-'), 
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
                CONCAT('<br>-----self_check: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 16777216, 2), 
        "<br>stockrotation - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 24, 
              CONCAT('<br>-----stockrotation: ', permissions.code, '-'), 
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
                CONCAT('<br>-----stockrotation: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR ''), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 33554432, 2), 
        "<br>cash_management - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 25, 
              CONCAT('<br>-----cash_management: ', permissions.code, '-'), 
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
                CONCAT('<br>-----cash_management: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 67108864, 2), 
        "<br>problem_reports - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 26, 
              CONCAT('<br>-----problem_reports: ', permissions.code, '-'), 
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
                CONCAT('<br>-----problem_reports: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 134217728, 2), 
        "<br>recalls - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 27, 
              CONCAT('<br>-----recalls: ', permissions.code, '-'), 
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
                CONCAT('<br>-----recalls: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 268435456, 2), 
        "<br>erm - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 28, 
              CONCAT('<br>-----erm: ', permissions.code, '-'), 
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
                CONCAT('<br>-----erm: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 536870912, 2), 
        "<br>loggedinlibrary - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 29, 
              CONCAT('<br>-----loggedinlibrary: ', permissions.code, '-'), 
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
                CONCAT('<br>-----loggedinlibrary: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 1073741824, 2), 
        "<br>preservation - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 30, 
              CONCAT('<br>-----preservation: ', permissions.code, '-'), 
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
                CONCAT('<br>-----preservation: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 2147483648, 2), 
        "<br>undefined in  in 24.11 - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 31, 
              CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
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
                CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 4294967296, 2), 
        "<br>undefined in  in 24.11 - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 32, 
              CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
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
                CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 8589934592, 2), 
        "<br>undefined in  in 24.11 - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 33, 
              CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
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
                CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 17179869184, 2), 
        "<br>undefined in  in 24.11 - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 34, 
              CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
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
                CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
          ) 
        ) 
      ), 
      If( 
        MOD(borrowers.flags DIV 34359738368, 2), 
        "<br>undefined in  in 24.11 - All parameters -<br>", 
        IF( 
          GROUP_CONCAT( 
            DISTINCT 
            If( 
              user_permissions.module_bit = 35, 
              CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
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
                CONCAT('<br>-----undefined in 24.11: ', permissions.code, '-'), 
                '' 
              ) 
              ORDER BY permissions.code 
              SEPARATOR '' 
            ), 
            '<br>' 
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
  JOIN cate

||AAAAA||

gories 
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
          '<br><br>',
          char(10),
          char(10)
        ) 
        ORDER BY borrower_attribute_types.description, authorised_values.lib 
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
  ((borrowers.flags > 0) OR 
    (user_permissions.module_bit > 0)) AND 
  borrowers.branchcode LIKE "%" 
GROUP BY 
  borrowers.borrowernumber 
ORDER BY 
  borrowers.flags MOD 2 DESC, 
  borrowers.branchcode, 
  borrowers.userid 
LIMIT 1000





















