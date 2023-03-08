/*
R.003700

----------

Name: GHW - Statistics - Local use by library and collection code
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2023-02-01 12:28:31
Modified on: 2023-02-01 12:37:05
Date last run: 2023-02-02 12:24:48

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Counts local use by collection code</p>
  <ul>
    <li>during the previous calendar month</li>
    <li>at the library you specify</li>
    <li>grouped and sorted by library and collection code</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Notes go here.</p>
  <p></p>
  <p>Collecting local use data requires the use of a "Staff - statistical purposes" library card.</p>
  <p></p>
  <p>Local use does not collect an item's shelving location.</p>
  <p class= "notetags" style="display: none;">#local use; #statistics #ccode</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



Select
    branchccodes.branchname As LIBRARY,
    branchccodes.lib As COLLECTION_CODE,
    Coalesce(Sum(all_lm.CKO_RENEW), "0") As LOCAL_USE_COUNT
From
    (Select
          branches.branchcode,
          authorised_values.authorised_value,
          authorised_values.lib,
          branches.branchname
      From
          branches,
          authorised_values
      Where
          authorised_values.category = 'CCODE' And
          branches.branchcode Like <<Choose your library|ZBRAN>>
      Order By
          branches.branchcode,
          authorised_values.lib) branchccodes Left Join
    (Select
          If(statistics.branch Is Null, "NEKLS", statistics.branch) As branch,
          If(statistics.ccode Is Null, "XXX", statistics.ccode) As CCODE,
          Count(*) As CKO_RENEW
      From
          statistics
      Where
          Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
          Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
          statistics.type = 'localuse'
      Group By
          If(statistics.branch Is Null, "NEKLS", statistics.branch),
          If(statistics.ccode Is Null, "XXX", statistics.ccode)) all_lm On all_lm.branch = branchccodes.branchcode And
            all_lm.CCODE = branchccodes.authorised_value
Group By
    branchccodes.branchname,
    branchccodes.lib
Order By
    LIBRARY,
    COLLECTION_CODE

























