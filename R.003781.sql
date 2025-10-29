/*
R.003781

----------

Name: GHW - Circulation at Bonner Springs by borrower's home county sub-division
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2023-10-27 11:20:00
Modified on: 2023-10-27 12:35:22
Date last run: 2023-10-30 10:08:56

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  branches_cnty_sub.branchname AS CKO_RENEW_AT,
  Concat_WS('-', <>, <>) AS DURING,
  branches_cnty_sub.lib AS BORROWER_RESIDES_IN,
  statisticss.cko_renew_count AS CKO_RENEW_COUNT
FROM (
    SELECT 
      branches.branchcode,
      branches.branchname,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM branches,
      authorised_values
    WHERE authorised_values.category = 'CNTY_SUB'
      AND branches.branchcode = 'BONNERSPGS'
  ) branches_cnty_sub
  LEFT JOIN (
    SELECT 
      statistics.branch,
      Coalesce(cnty_subs.attribute, '-') AS attribute,
      Count(*) AS cko_renew_count
    FROM statistics
      LEFT JOIN (
        SELECT borrower_attributes.borrowernumber,
          borrower_attributes.code,
          borrower_attributes.attribute
        FROM borrower_attributes
        WHERE borrower_attributes.code = 'cnty_sub'
      ) cnty_subs ON cnty_subs.borrowernumber = statistics.borrowernumber
    WHERE (
        statistics.type = 'issue'
        OR statistics.type = 'renew'
      )
      AND Year(statistics.datetime) = <>
      AND Month(statistics.datetime) = <>
    GROUP BY statistics.branch,
      Coalesce(cnty_subs.attribute, '-')
  ) statisticss 
    ON statisticss.branch = branches_cnty_sub.branchcode
    AND statisticss.attribute = branches_cnty_sub.authorised_value
GROUP BY 
  branches_cnty_sub.branchname,
  branches_cnty_sub.lib
ORDER BY branches_cnty_sub.branchname,
  branches_cnty_sub.lib 

























