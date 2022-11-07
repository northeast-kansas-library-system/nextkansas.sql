/*
R.003675

----------

Name: Test 57
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-11-04 11:17:50
Modified on: 2022-11-04 15:59:56
Date last run: 2022-11-04 16:00:06

----------

Public: 0
Expiry: 300

----------



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
        '<br />circulate - All parameters', 
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 1, CONCAT('<br />---->circulate: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 4, 2), 
        '<br />catalogue - All parameters', 
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 2, CONCAT('<br />---->catalogue: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 8, 2),
        "<br />parameters - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 3, CONCAT('<br />---->parameters: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 16, 2),
        "<br />borrowers - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 4, CONCAT('<br />---->borrowers: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 32, 2),
        "<br />permissions - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 5, CONCAT('<br />---->permissions: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 64, 2),
        "<br />reserveforothers - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 6, CONCAT('<br />---->reserveforothers: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 128, 2), 
        '<br />FLAG7 Uh-oh', 
        ''
      ),
      If(
        MOD(borrowers.flags DIV 256, 2), 
        '<br />FLAG8 Uh-oh', 
        ''
      ),
      If(
        MOD(borrowers.flags DIV 512, 2),
        "<br />editcatalogue - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 9, CONCAT('<br />---->editcatalogue: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 1024, 2),
        "<br />updatecharges - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 10, CONCAT('<br />---->updatecharges: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 2048, 2),
        "<br />acquisition - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 11, CONCAT('<br />---->acquisition: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 4096, 2),
        "<br />suggestions - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 12, CONCAT('<br />---->suggestions: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 8192, 2),
        "<br />tools - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 13, CONCAT('<br />---->tools: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 16384, 2),
        "<br />editauthorities - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 14, CONCAT('<br />---->editauthorities: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 32768, 2),
        "<br />serials - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 15, CONCAT('<br />---->serials: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 65536, 2),
        "<br />reports - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 16, CONCAT('<br />---->reports: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 131072, 2),
        "<br />staffaccess - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 17, CONCAT('<br />---->staffaccess: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 262144, 2),
        "<br />coursereserves - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 18, CONCAT('<br />---->coursereserves: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 524288, 2),
        "<br />plugins - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 19, CONCAT('<br />---->plugins: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 1048576, 2),
        "<br />lists - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 20, CONCAT('<br />---->lists: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 2097152, 2),
        "<br />clubs - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 21, CONCAT('<br />---->clubs: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 4194304, 2),
        "<br />ill - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 22, CONCAT('<br />---->ill: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 8388608, 2),
        "<br />self_check - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 23, CONCAT('<br />---->self_check: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 16777216, 2),
        "<br />stockrotation - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 24, CONCAT('<br />---->stockrotation: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
      ),
      If(
        MOD(borrowers.flags DIV 33554432, 2),
        "<br />cash_management - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 25, CONCAT('<br />---->cash_management: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
        )
          ),
      If(
        MOD(borrowers.flags DIV 67108864, 2),
          "<br />problem_reports - All parameters",
        GROUP_CONCAT(
          DISTINCT
          If(user_permissions.module_bit = 26, CONCAT('<br />---->problem_reports: ', permissions.code), '')
          ORDER BY permissions.code
          SEPARATOR ' / '
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
  borrowers.branchcode LIKE <<Choose a library|LBRANCH>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.flags MOD 2 DESC,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.categorycode

























