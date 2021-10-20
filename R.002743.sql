/*
R.002743

----------

Name: Directors permissions
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-08-25 16:11:02
Modified on: 2017-10-20 17:31:59
Date last run: 2017-10-20 17:35:49

----------

Public: 0
Expiry: 0

----------

From VOKAL/CIN.

----------
*/



SELECT
  Concat('<a href=\"/cgi-bin/koha/members/member-flags.pl?member=', borrowers.borrowernumber, '\" target="_blank">"edit permissions"</a>') AS "edit permissions",
  borrowers.surname,
  borrowers.firstname,
  borrowers.cardnumber,
  borrowers.categorycode,
  borrowers.branchcode,
  If(borrowers.flags MOD 2, 'Set', '') AS SuperLib,
  If(MOD(borrowers.flags DIV 2, 2), 'All parameters', GROUP_CONCAT(If(user_permissions.module_bit = 1, permissions.code, '') SEPARATOR ' ')) AS "CircPermissions",
  If(MOD(borrowers.flags DIV 4, 2), 'Set', '') AS 'View staff interface',
  If(MOD(borrowers.flags DIV 8, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 3, permissions.code, '') SEPARATOR ' ')) AS ManParams,
  If(MOD(borrowers.flags DIV 16, 2), 'Set', '') AS 'Add/modify patrons',
  If(MOD(borrowers.flags DIV 32, 2), 'Set', '') AS 'Modify permissions',
  If(MOD(borrowers.flags DIV 64, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 6, permissions.code, '') SEPARATOR ' ')) AS ReservePermissions,
  If(MOD(borrowers.flags DIV 128, 2), 'Set', '') AS BorrowBooks,
  If(MOD(borrowers.flags DIV 512, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 9, permissions.code, '') SEPARATOR ' ')) AS EditCatalogue,
  If(MOD(borrowers.flags DIV 1024, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 10, permissions.code, '') SEPARATOR ' ')) AS UpdateCharges,
  If(MOD(borrowers.flags DIV 2048, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 11, permissions.code, '') SEPARATOR ' ')) AS Acquisition,
  If(MOD(borrowers.flags DIV 4096, 2), 'Set', '') AS Management,
  If(MOD(borrowers.flags DIV 8192, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 13, permissions.code, '') SEPARATOR ' ')) AS Tools,
  If(MOD(borrowers.flags DIV 16384, 2), 'Set', '') AS EditAuthories,
  If(MOD(borrowers.flags DIV 32768, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 15, permissions.code, '') SEPARATOR ' ')) AS Series,
  If(MOD(borrowers.flags DIV 65536, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 16, permissions.code, '') SEPARATOR ' ')) AS Reports,
  If(MOD(borrowers.flags DIV 131072, 2), 'Set', '') AS StaffAccess,
  If(MOD(borrowers.flags DIV 262144, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 18, permissions.code, '') SEPARATOR ' ')) AS CourseReserves,
  If(MOD(borrowers.flags DIV 524288, 2), "All parameters", GROUP_CONCAT(If(user_permissions.module_bit = 19, permissions.code, '') SEPARATOR ' ')) AS Plugins
FROM
  borrowers
  LEFT JOIN user_permissions ON borrowers.borrowernumber = user_permissions.borrowernumber
  LEFT JOIN permissions ON user_permissions.code = permissions.code
WHERE
  (borrowers.flags > 0 OR
    user_permissions.module_bit > 0) AND
  borrowers.surname LIKE CONCAT('%', <<Choose staff member type|ZSTAFF>>, '%')
GROUP BY
  borrowers.borrowernumber
ORDER BY
  SuperLib DESC,
  borrowers.surname,
  borrowers.categorycode,
  borrowers.branchcode,
  borrowers.firstname

























