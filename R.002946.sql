/*
R.002946

----------

Name: GHW - Library information for contact list
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-05-12 01:07:13
Modified on: 2020-02-24 15:21:01
Date last run: 2021-02-06 12:43:54

----------

Public: 0
Expiry: 300

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
<p>Instructions:<br />Run the report, then view the source.  When looking at the source, copy all of the data from the results table into the same table in the IntranetCirculationHomeHTML system preference.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2946&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
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
    CONCAT('<br /><span style="background: wheat; text-decoration: underline;">Total titles:</span> ',Count(DISTINCT items.biblionumber)),
        ' ',
        CONCAT('<span style="background: wheat; text-decoration: underline;">Total items:</span> ',Count(DISTINCT items.itemnumber))
   ) AS "Staff contacts / holdings"
FROM branches
LEFT JOIN items ON items.homebranch = branches.branchcode
WHERE branches.branchcode LIKE <<Select library|ZBRAN>>
GROUP BY branches.branchcode
LIMIT 500



