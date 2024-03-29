/*
R.002760

----------

Name: GHW - Branch Contact Information
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-09-06 01:02:47
Modified on: 2016-10-05 10:54:41
Date last run: 2019-02-05 18:45:02

----------

Public: 0
Expiry: 0

----------

Report for GHW to create mail merge contact information sheet and for cleaning up problems with branch information in Koha (data is inconsistent - some address1 fields are street addresses and some are PO boxes - some address2 fields are street addresses and some are PO boxes - etc.  Lots of cleanup to do.

investigate putting Director's contact info as address line 3 and ILL contact as country - or find a way to do both in country or something.

----------
*/



SELECT
  branches.branchcode,
  branches.branchname,
  branches.branchaddress1 AS MAILING_ADDRESS,
  branches.branchaddress2 AS STREET_ADDRESS_1,
  branches.branchaddress3 AS OTHER_ADDRESS,
  branches.branchcity,
  branches.branchstate,
  branches.branchzip,
  branches.branchphone,
  branches.branchfax,
  branches.branchemail,
  Count(items.itemnumber) AS TOTAL_ITEMS
FROM
  branches JOIN
  items
    ON items.homebranch = branches.branchcode
GROUP BY
  branches.branchcode
ORDER BY
  branches.branchname
    ASC

























