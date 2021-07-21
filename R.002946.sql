/*
R.002946

----------

Name: GHW - Library information for contact list
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-05-12 01:07:13
Modified on: 2021-07-21 12:05:14
Date last run: 2021-07-21 12:05:16

----------

Public: 0
Expiry: 43200

----------

<div id=reportinfo>
<p>Generates the table that gets used for the contacts tab on the "Library contact information" tab on the circulation home page</p>
<ul><li>Shows current contact information</li>
<li>For all libraries</li>
<li>grouped and sorted by library location code</li>
<li>contains links to each branch's home page that open in a new window/tab</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p></p>
<p></p>
</div>

----------
*/

SELECT
  Concat(
    Concat(
      Replace(branches.branchname, ' - ', '<br />     '), 
      '<p><ins>Mailing address:</ins><br />', 
      Concat_Ws('<br />', 
        branches.branchaddress1, 
        Concat(branches.branchcity, ', ', branches.branchstate, ' ', branches.branchzip)), 
        '</p>'),
        Concat('<ins>Street address:</ins><br />', Concat_Ws('<br />', If(branches.branchaddress2 = ' ', branches.branchaddress1, branches.branchaddress2), 
        Concat(branches.branchcity, ', ', branches.branchstate, '<br />')
      )
    )
  ) AS Library,
  Concat_Ws(
    '<p>', 
    Concat('<p>Phone: ', branches.branchphone, '</p>'), 
    Concat('Fax: ', branches.branchfax, '</p>'), 
    Concat('e-mail: ', branches.branchemail, '</p>'), 
    Concat('Website: <a href="', branches.branchurl, '" target="_blank">Click here</a></p>'), 
    Concat('Courier route #: ', branches.branchcountry, '</p>')
  ) AS "Contact information",
  Concat_Ws(
    '<br />', 
    Replace(
      Replace(
        Replace(branches.branchaddress3, '|', '<br /><br />'),
        'Director:', '<span style="background: yellow; text-decoration: underline; font-size: 120%;">Director:</span><br />'), 
        'Accreditation:', '<span style="background: aqua; text-decoration: underline; font-size: 120%;">Type:</span><br />'),
    CONCAT(
      '<br /><span style="background: wheat; text-decoration: underline;">Total titles:</span> ',Count(DISTINCT items.biblionumber)),
      ' ',
      CONCAT('<span style="background: wheat; text-decoration: underline;">Total items:</span> ',Count(DISTINCT items.itemnumber)),
      CONCAT("<br />Last updated: ", NOW())
    ) AS "Staff contacts / holdings"
FROM branches
LEFT JOIN items ON items.homebranch = branches.branchcode
WHERE branches.branchcode LIKE "%"
GROUP BY branches.branchcode
LIMIT 500



