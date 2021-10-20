/*
R.003167

----------

Name: GHW - Insightly groups from library information
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2019-02-09 17:12:02
Modified on: 2019-02-09 17:21:22
Date last run: 2019-02-09 17:21:25

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat("") AS RecordId,
  branches.branchname AS OrganizationName,
  branches.branchaddress1 AS BillingAddressStreet,
  branches.branchcity AS BillingAddressCity,
  branches.branchstate AS BillingAddressState,
  LEFT(branches.branchzip, 5) AS BillingAddressPostalCode,
  Concat("United States") AS BillingAddressCountry,
  branches.branchaddress2 AS ShippingAddressStreet,
  If(branches.branchaddress2 = "", "", branches.branchcity) AS ShippingAddressCity,
  If(branches.branchaddress2 = "", "", branches.branchstate) AS ShippingAddressState,
  If(branches.branchaddress2 = "", "", Concat("United States")) AS ShippingAddressCountry,
  If(branches.branchaddress2 = "", "", LEFT(branches.branchzip, 5)) AS ShippingAddressPostalCode,
  branches.branchphone AS Phone,
  branches.branchfax AS Fax,
  branches.branchurl AS Website,
  Concat("") AS EmailDomain,
  Concat("") AS ImportantDate1Name,
  Concat("") AS ImportantDate1,
  Concat("") AS ImportantDate2Name,
  Concat("") AS ImportantDate2,
  Concat("") AS ImportantDate3Name,
  Concat("") AS ImportantDate3,
  Concat("NextSearchCatalog") AS Tag1,
  Concat("") AS Tag2,
  Concat("") AS Tag3,
  Concat("") AS Tag4,
  Concat("") AS Tag5,
  Concat("") AS Tag6,
  Concat("") AS Tag7,
  Concat("") AS Tag8,
  Concat("") AS Tag9,
  Concat("") AS DateOfLastActivity,
  Concat("") AS DateOfNextActivity,
  Concat("") AS "KLOW Member",
  Concat("") AS Library,
  Concat("") AS Type,
  Concat("") AS Vendor,
  Concat("") AS Government,
  Concat("") AS Agency
FROM
  branches

























