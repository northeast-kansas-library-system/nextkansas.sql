/*
R.002847

----------

Name: GHW - Library Contact Information
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-12-06 14:43:22
Modified on: 2018-04-16 11:05:18
Date last run: 2019-05-16 17:09:24

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of contact information for all NExpress libraries</p>
<ul><li>Shows the data currently in NExpress</li>
<li>At the branch or group of branches you specify</li>
<li>grouped by branch code</li>
<li>sorted by branch code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2847&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branches.branchcode AS BRANCH_CODE,
  CONCAT(CONCAT(branches.branchname,'<p><ins>Mailing address:</ins><br />',Concat_Ws('<br />', branches.branchaddress1, Concat(branches.branchcity,', ', branches.branchstate, ' ', branches.branchzip)),'</p>'),
  CONCAT('<ins>Street address:</ins><br />',Concat_Ws('<br />', If(branches.branchaddress2 = ' ', branches.branchaddress1, branches.branchaddress2), Concat(branches.branchcity,', ', branches.branchstate)))) AS ADDRESS,
  Concat_Ws('<p>', Concat('Phone: ', branches.branchphone,'</p>'), Concat('Fax: ', branches.branchfax,'</p>'), Concat('e-mail: ', branches.branchemail,'</p>'), Concat('Website: ', branches.branchurl,'</p>'),Concat('Courier route #: ', branches.branchcountry,'</p>')) AS PHONE_EMAIL_COURIER,
  REPLACE(branches.branchaddress3, ' | ', '<br />') AS DIRECTOR_ILL_CONTACTS,
  CONCAT_WS('<br />',CONCAT('Total titles: ',Count(DISTINCT items.biblionumber)), CONCAT('Total items: ',Count(DISTINCT items.itemnumber))) AS HOLDINGS
FROM
  branches LEFT JOIN
  items
    ON items.homebranch = branches.branchcode
WHERE
  branches.branchcode LIKE <<Choose your branch|LBRANCH>>
GROUP BY
  branches.branchcode



