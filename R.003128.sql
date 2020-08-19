/*
R.003128

----------

Name: GHW - Checkout and renewal count by item type and shelving location - previous calendar month
Created by: George H Williams

----------

Group: Statistics
     Monthly Statistics

Created on: 2018-10-09 17:27:16
Modified on: 2020-02-05 17:36:30
Date last run: 2020-08-17 16:34:48

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Last month's checkouts by library, item type, and location</p>
<ul><li>Shows check-outs and renewals in the previous month by item type and shelving location</li>
<li>at the library you specify</li>
<li>grouped and sorted by checkout branch and shelving location</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Checkouts without a checkout branch location will show as being checked out at NEKLS</p>
<p>Checkouts without an item type will be counted as BOOK</p>
<p></p>
<p>Partially replaces report 1930</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3128&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

Select
  branch_itype.branchname,
  branch_itype.description,
  Coalesce(statisticsall.CKO_REN, 0) As CKO_REN_ALL,
  Coalesce(statisticsadult.CKO_REN, 0) As CKO_REN_ADULT,
  Coalesce(statisticsya.CKO_REN, 0) As CKO_REN_YA,
  Coalesce(statisticschildren.CKO_REN, 0) As CKO_CHILDRENS,
  Coalesce(statisticsother.CKO_REN, 0) As CKO_REN_OTHER
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
     branches.branchcode Like <<Choose check-out library|LBRANCH>>) branch_itype Left Join
  (Select
     Coalesce(statistics.branch, "NEKLS") As branch,
     Coalesce(statistics.itemtype, "BOOK") As itemtype,
     Count(*) As CKO_REN
   From
     statistics
   Where
     (statistics.type = 'issue' Or
         statistics.type = 'renew') And
     Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
     Month(statistics.datetime) = Month(Now() - Interval 1 Month)
   Group By
     Coalesce(statistics.branch, "NEKLS"),
     Coalesce(statistics.itemtype, "BOOK")
   Order By
     branch,
     itemtype) statisticsall On branch_itype.branchcode = statisticsall.branch And
      branch_itype.itemtype = statisticsall.itemtype Left Join
  (Select
     Coalesce(statistics.branch, "NEKLS") As branch,
     Coalesce(statistics.itemtype, "BOOK") As itemtype,
     Count(*) As CKO_REN
   From
     statistics
   Where
     (statistics.type = 'issue' Or
         statistics.type = 'renew') And
     Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
     Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
     (Coalesce(statistics.location, "CART") = 'ADULT' Or
         Coalesce(statistics.location, "CART") = 'LVPLADULT' Or
         Coalesce(statistics.location, "CART") = 'PAOLAADULT')
   Group By
     Coalesce(statistics.branch, "NEKLS"),
     Coalesce(statistics.itemtype, "BOOK")
   Order By
     branch,
     itemtype) statisticsadult On branch_itype.branchcode = statisticsadult.branch And
      branch_itype.itemtype = statisticsadult.itemtype Left Join
  (Select
     Coalesce(statistics.branch, "NEKLS") As branch,
     Coalesce(statistics.itemtype, "BOOK") As itemtype,
     Count(*) As CKO_REN
   From
     statistics
   Where
     (statistics.type = 'issue' Or
         statistics.type = 'renew') And
     Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
     Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
     Coalesce(statistics.location, "CART") <> 'ADULT' And
     Coalesce(statistics.location, "CART") <> 'LVPLADULT' And
     Coalesce(statistics.location, "CART") <> 'PAOLAADULT' And
     Coalesce(statistics.location, "CART") <> 'YOUNGADULT' And
     Coalesce(statistics.location, "CART") <> 'LVPLYA' And
     Coalesce(statistics.location, "CART") <> 'PAOLAYA' And
     Coalesce(statistics.location, "CART") <> 'CHILDRENS' And
     Coalesce(statistics.location, "CART") <> 'LVPLCHILD' And
     Coalesce(statistics.location, "CART") <> 'PAOLACHILD'
   Group By
     Coalesce(statistics.branch, "NEKLS"),
     Coalesce(statistics.itemtype, "BOOK")
   Order By
     branch,
     itemtype) statisticsother On branch_itype.branchcode = statisticsother.branch And
      branch_itype.itemtype = statisticsother.itemtype Left Join
  (Select
     Coalesce(statistics.branch, "NEKLS") As branch,
     Coalesce(statistics.itemtype, "BOOK") As itemtype,
     Count(*) As CKO_REN
   From
     statistics
   Where
     (statistics.type = 'issue' Or
         statistics.type = 'renew') And
     Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
     Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
     (Coalesce(statistics.location, "CART") = 'YOUNGADULT' Or
         Coalesce(statistics.location, "CART") = 'LVPLYA' Or
         Coalesce(statistics.location, "CART") = 'PAOLAYA')
   Group By
     Coalesce(statistics.branch, "NEKLS"),
     Coalesce(statistics.itemtype, "BOOK")
   Order By
     branch,
     itemtype) statisticsya On statisticsya.itemtype = branch_itype.itemtype And
      statisticsya.branch = branch_itype.branchcode Left Join
  (Select
     Coalesce(statistics.branch, "NEKLS") As branch,
     Coalesce(statistics.itemtype, "BOOK") As itemtype,
     Count(*) As CKO_REN
   From
     statistics
   Where
     (statistics.type = 'issue' Or
         statistics.type = 'renew') And
     Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
     Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
     (Coalesce(statistics.location, "CART") = 'CHILDRENS' Or
         Coalesce(statistics.location, "CART") = 'LVPLCHILD' Or
         Coalesce(statistics.location, "CART") = 'PAOLACHILD')
   Group By
     Coalesce(statistics.branch, "NEKLS"),
     Coalesce(statistics.itemtype, "BOOK")
   Order By
     branch,
     itemtype) statisticschildren On statisticschildren.itemtype = branch_itype.itemtype And
      statisticschildren.branch = branch_itype.branchcode
Group By
  branch_itype.branchname,
  branch_itype.description
Order By
  branch_itype.branchname,
  branch_itype.description



