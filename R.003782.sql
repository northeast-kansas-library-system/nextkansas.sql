/*
R.003782

----------

Name: GHW - Circulation at Bonner Springs by borrower's home school district
Created by: George Williams

----------

Group:  BONNERSPGS
     -

Created on: 2023-10-27 11:26:43
Modified on: 2023-10-27 12:23:43
Date last run: 2023-10-30 12:23:11

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  branches_usd.branchname AS CKO_RENEW_AT,
  Concat_WS('-', <<Choose year|Year>>, <<Choose month|Month>>) AS DURING,
  branches_usd.lib AS BORROWER_RESIDES_IN,
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
    WHERE authorised_values.category = 'USD'
      AND branches.branchcode = 'BONNERSPGS'
  ) branches_usd
  LEFT JOIN (
    SELECT 
      statistics.branch,
      Coalesce(usds.attribute, '-') AS attribute,
      Count(*) AS cko_renew_count
    FROM statistics
      LEFT JOIN (
        SELECT borrower_attributes.borrowernumber,
          borrower_attributes.code,
          borrower_attributes.attribute
        FROM borrower_attributes
        WHERE borrower_attributes.code = 'usd'
      ) usds ON usds.borrowernumber = statistics.borrowernumber
    WHERE (
        statistics.type = 'issue'
        OR statistics.type = 'renew'
      )
      AND Year(statistics.datetime) = <<Choose year|Year>>
      AND Month(statistics.datetime) = <<Choose month|Month>>
    GROUP BY statistics.branch,
      Coalesce(usds.attribute, '-')
  ) statisticss 
    ON statisticss.branch = branches_usd.branchcode
    AND statisticss.attribute = branches_usd.authorised_value
GROUP BY 
  branches_usd.branchname,
  branches_usd.lib
ORDER BY 
  branches_usd.branchname,
  branches_usd.lib

























