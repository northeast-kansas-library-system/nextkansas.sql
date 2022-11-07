/*
R.002459

----------

Name: Which accounts have which staff permissions?
Created by: Heather Braum

----------

Group: Administrative Reports
     System-admin

Created on: 2015-02-10 14:41:41
Modified on: 2022-11-04 14:16:36
Date last run: 2022-11-04 14:16:42

----------

Public: 0
Expiry: 0

----------

From VOKAL/CIN.

----------
*/



SELECT
  Concat(
    '<a class="btn btn-default btn-xs noprint" ',
    'href=\"/cgi-bin/koha/members/member-flags.pl?member=', 
    borrowers.borrowernumber, 
    '\" target="_blank">edit permissions</a>'
  ) AS EDIT_PERMISSIONS,
  Concat_WS('<br />',
    Concat(borrowers.surname, IF(borrowers.firstname like '', '', CONCAT(' / ', borrowers.firstname))),
    IF(borrowers.othernames like '', '', CONCAT(' (', borrowers.othernames, ')'))
  ) AS NAME,
  borrowers.email,
  borrowers.cardnumber,
  borrowers.categorycode,
  borrowers.branchcode,
  borrowers.lastseen,
  If(borrowers.flags MOD 2, 'Superlibrarian', '') AS superlibrarian,
  If(MOD(borrowers.flags DIV 2, 2), 'All parameters', GROUP_CONCAT(If(user_permissions.module_bit = 1, permissions.code, '') SEPARATOR ' ')) AS circulate,
  If(MOD(borrowers.flags DIV 4, 2), 'All parameters', GROUP_CONCAT(If(user_permissions.module_bit = 2, permissions.code, '') SEPARATOR ' ')) AS catalogue,
  If(MOD(borrowers.flags DIV 8, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 3, permissions.code, '') SEPARATOR ' ')) AS parameters,
  If(MOD(borrowers.flags DIV 16, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 4, permissions.code, '') SEPARATOR ' ')) AS borrowers,
  If(MOD(borrowers.flags DIV 32, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 5, permissions.code, '') SEPARATOR ' ')) AS permissions,
  If(MOD(borrowers.flags DIV 64, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 6, permissions.code, '') SEPARATOR ' ')) AS reserveforothers,
  If(MOD(borrowers.flags DIV 128, 2), 'Uh-oh', 'Not used') AS FLAG7,
  If(MOD(borrowers.flags DIV 256, 2), 'Uh-oh', 'Not used') AS FLAG8,
  If(MOD(borrowers.flags DIV 512, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 9, permissions.code, '') SEPARATOR ' ')) AS editcatalogue,
  If(MOD(borrowers.flags DIV 1024, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 10, permissions.code, '') SEPARATOR ' ')) AS updatecharges,
  If(MOD(borrowers.flags DIV 2048, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 11, permissions.code, '') SEPARATOR ' ')) AS acquisition,
  If(MOD(borrowers.flags DIV 4096, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 12, permissions.code, '') SEPARATOR ' ')) AS suggestions,
  If(MOD(borrowers.flags DIV 8192, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 13, permissions.code, '') SEPARATOR ' ')) AS tools,
  If(MOD(borrowers.flags DIV 16384, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 14, permissions.code, '') SEPARATOR ' ')) AS editauthorities,
  If(MOD(borrowers.flags DIV 32768, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 15, permissions.code, '') SEPARATOR ' ')) AS serials,
  If(MOD(borrowers.flags DIV 65536, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 16, permissions.code, '') SEPARATOR ' ')) AS reports,
  If(MOD(borrowers.flags DIV 131072, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 17, permissions.code, '') SEPARATOR ' ')) AS staffaccess,
  If(MOD(borrowers.flags DIV 262144, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 18, permissions.code, '') SEPARATOR ' ')) AS coursereserves,
  If(MOD(borrowers.flags DIV 524288, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 19, permissions.code, '') SEPARATOR ' ')) AS plugins,
  If(MOD(borrowers.flags DIV 1048576, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 20, permissions.code, '') SEPARATOR ' ')) AS lists,
  If(MOD(borrowers.flags DIV 2097152, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 21, permissions.code, '') SEPARATOR ' ')) AS clubs,
  If(MOD(borrowers.flags DIV 4194304, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 22, permissions.code, '') SEPARATOR ' ')) AS ill,
  If(MOD(borrowers.flags DIV 8388608, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 23, permissions.code, '') SEPARATOR ' ')) AS self_check,
  If(MOD(borrowers.flags DIV 16777216, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 24, permissions.code, '') SEPARATOR ' ')) AS stockrotation,
  If(MOD(borrowers.flags DIV 33554432, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 25, permissions.code, '') SEPARATOR ' ')) AS cash_management,
  If(MOD(borrowers.flags DIV 67108864, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 26, permissions.code, '') SEPARATOR ' ')) AS problem_reports
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
  superlibrarian DESC,
  borrowers.branchcode,
  borrowers.surname,
  borrowers.firstname,
  borrowers.categorycode

























