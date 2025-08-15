/*
R.003750

----------

Name: CKLS Sample 4
Created by: George Williams

----------

Group: -
     -

Created on: 2023-08-04 15:40:26
Modified on: 2023-08-04 15:44:32
Date last run: 2023-08-11 11:10:17

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branchtypes.branchname,
  branchtypes.lib As `"COLLECTION CODE"`,
  Sum(itemss.Count_itemnumber) As "TOTAL ITEMS",
  Sum(items_added.Count_itemnumber) As "TOTAL ADDED LM",
  Sum(items_deleted.Count_itemnumber) As "TOTAL DELETED LM"
From
  (Select
      branches.branchcode,
      branches.branchname,
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      branches,
      authorised_values
    Where
      branches.branchcode Like &lt;&gt; And
      authorised_values.category = 'CCODE') branchtypes Left Join
  (Select
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From
      items
    Group By
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)) itemss On itemss.homebranch = branchtypes.branchcode And
      itemss.ccode = branchtypes.authorised_value Left Join
  (Select
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode) As ccode,
      Count(items.itemnumber) As Count_itemnumber
    From
      items
    Where
      Month(items.dateaccessioned) = Month(Now() - Interval 1 Month) And
      Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
    Group By
      items.homebranch,
      If(items.ccode Is Null, "XXX", items.ccode)) items_added On items_added.homebranch = branchtypes.branchcode And
      items_added.ccode = branchtypes.authorised_value Left Join
  (Select
      deleteditems.homebranch,
      If(deleteditems.ccode Is Null, "XXX", If(deleteditems.ccode = "", "XXX", deleteditems.ccode)) As ccode,
      Count(deleteditems.itemnumber) As Count_itemnumber
    From
      deleteditems
    Where
      Month(deleteditems.timestamp) = Month(Now() - Interval 1 Month) And
      Year(deleteditems.timestamp) = Year(Now() - Interval 1 Month)
    Group By
      deleteditems.homebranch,
      If(deleteditems.ccode Is Null, "XXX", If(deleteditems.ccode = "", "XXX", deleteditems.ccode))) items_deleted On
      items_deleted.homebranch = branchtypes.branchcode And
      items_deleted.ccode = branchtypes.authorised_value
Group By
  branchtypes.branchname,
  branchtypes.lib
Order By
  branchtypes.branchname

























