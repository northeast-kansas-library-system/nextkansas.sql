/*
R.003390

----------

Name: GHW - Get Koha version
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-12-08 17:29:42
Modified on: 2021-08-19 08:40:11
Date last run: 2021-10-20 06:55:31

----------

Public: 0
Expiry: 21600

----------

<div id=reportinfo class=noprint>
<p>Gets the Koha version from the system preferences table and formats it for printing on the staff client home page as a part of the breadcrumbs</p>
<ul><li>Shows the version right now</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report grabs the Koha version then formats it in a way that's readable in the breadcrumbs on the home page in the staff client.  This report requires separate jQuery to work properly.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3390&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">jQuery required, json report, Koha enhancement</p>
</div>

----------
*/



SELECT
  Concat(
    '<span style="font-weight: bold; text-decoration: underline;',
    If(
      systempreferences.value = '20.0514000', 
      '', 
      ' color: red;'
    ),
    '">Koha version ', 
    SubString(systempreferences.value FROM 1 FOR 5 ),
    '.', 
    SubString(systempreferences.value FROM 6 FOR 2 ), 
    '.',  
    SubString(systempreferences.value FROM 8 FOR 10 ),
    IF(
      systempreferences.value = '20.0514000', 
      '', 
      Concat(' (Updated ', Curdate(), ')')
    ),
    '</span>'
  ) AS KVERS
FROM
  systempreferences
WHERE
  systempreferences.variable = 'Version'

























