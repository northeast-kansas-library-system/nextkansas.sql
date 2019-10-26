/*
R.002946

----------

Name: GHW - Library information for contact list
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2017-05-12 01:07:13
Modified on: 2019-06-06 15:53:50
Date last run: 2019-10-15 10:54:08

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

  CONCAT(
    CONCAT(
      REPLACE(branches.branchname, ' - ', '<br />     '),
      '<p><ins>Mailing address:</ins><br />',
      Concat_Ws('<br />', branches.branchaddress1, Concat(branches.branchcity,', ', branches.branchstate, ' ', branches.branchzip)),
      '</p>'
    ),
    CONCAT(
      '<ins>Street address:</ins><br />',
      Concat_Ws(
        '<br />',
        If(
          branches.branchaddress2 = ' ',
          branches.branchaddress1,
          branches.branchaddress2
        ),
        Concat(
          branches.branchcity,
          ', ',
          branches.branchstate,
          '<br />'
        )
      )
    )
  ) AS Library,

  Concat_Ws(
    '<p>',
    Concat('<p>Phone: ', branches.branchphone,'</p>'),
    Concat('Fax: ', branches.branchfax,'</p>'),
    Concat('e-mail: ', branches.branchemail,'</p>'),
    Concat('Website: <a href="', branches.branchurl,'" target="_blank">Click here</a></p>'),
    Concat('Courier route #: ', branches.branchcountry,'</p>')
  ) AS "Contact information",

  CONCAT_WS(
    '<br />',
   '<span style="background: yellow; text-decoration: underline; font-size: 120%;">',
    (REPLACE(REPLACE(branches.branchaddress3, ' | ', '<br /><br />'), ' - ', '</span><br />     - ') ),
    CONCAT('<br />Total titles: ',Count(DISTINCT items.biblionumber)),
    ' ',
    CONCAT('Total items: ',Count(DISTINCT items.itemnumber))
  ) AS "Staff contacts / holdings"

FROM
  branches LEFT JOIN
  items
    ON items.homebranch = branches.branchcode
WHERE branches.branchcode LIKE <<Select library|ZBRAN>>
GROUP BY
  branches.branchcode
LIMIT
  500


