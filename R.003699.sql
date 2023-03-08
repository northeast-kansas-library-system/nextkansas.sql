/*
R.003699

----------

Name: GHW - Statistics - Local use by library and item type
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2023-02-01 10:38:58
Modified on: 2023-02-01 12:37:12
Date last run: 2023-02-02 12:27:44

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
  <p>Counts local use by item type</p>
  <ul>
    <li>during the previous calendar month</li>
    <li>at the library you specify</li>
    <li>grouped and sorted by library and item type</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Notes go here.</p>
  <p></p>
  <p>Collecting local use data requires the use of a "Staff - statistical purposes" library card.</p>
  <p></p>
  <p>Local use does not collect an item's shelving location.</p>
  <p class= "notetags" style="display: none;">#local use; #statistics #itype</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



Select
    branch_itype.branchname AS LIBRARY,
    branch_itype.description AS ITEM_TYPE,
    Coalesce(Sum(statistics_all.CKO_REN), 0) As LOCAL_USE_COUNT
From
    (Select
          branches.branchname,
          itemtypes.description,
          branches.branchcode,
          itemtypes.itemtype
      From
          branches,
          itemtypes
      Where
          branches.branchcode Like <<Choose your library|ZBRAN>>) branch_itype Left Join
    (Select
          Coalesce(statistics.branch, "NEKLS") As branch,
          Coalesce(statistics.itemtype, "BOOK") As itemtype,
          Count(*) As CKO_REN
      From
          statistics
      Where
          statistics.type = 'localuse' And
          Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
          Month(statistics.datetime) = Month(Now() - Interval 1 Month)
      Group By
          Coalesce(statistics.branch, "NEKLS"),
          Coalesce(statistics.itemtype, "BOOK")
      Order By
          branch,
          itemtype) statistics_all On statistics_all.branch = branch_itype.branchcode And
            statistics_all.itemtype = branch_itype.itemtype
Group By
    branch_itype.branchname,
    branch_itype.description 
ORDER BY
    LIBRARY,
    ITEM_TYPE

























