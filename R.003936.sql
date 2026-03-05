/*
R.003936

----------

Name: GHW - Statistics test for executive board
Created by: George Williams

----------

Group: -
     -

Created on: 2026-01-07 00:13:37
Modified on: 2026-01-07 00:13:53
Date last run: 2026-01-07 00:15:32

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  'Next statistics' As 'Library',
  Concat('- ', Date_Format(AddDate(Last_Day(SubDate(Now(), Interval 2 Month)), 1), '%M %d, %Y'), ' -') As 'Circulation',
  'through' As 'ILL loans',
  Concat('- ', Date_Format(Last_Day(Current_Date() - Interval 1 Month), '%M %d, %Y'), ' -') As 'ILL borrows'
UNION
Select
  'Library' As 'Library',
  'Circulation' As 'Circulation',
  'ILL loans' As 'ILL loans',
  'ILL borrows' As 'ILL borrows'
UNION
(
  Select
    branches.branchname As 'Library',
    Coalesce(circ_renew.count, 0) As 'Circulation',
    Coalesce(ill_loaned.count, 0) As 'ILL loans',
    Coalesce(ill_borrowed.count, 0) As 'ILL borrows'
  From
    branches Left Join
    (
      Select
        statistics.branch,
        Count(&ast;) As count
      From
        statistics
      Where
        Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
        Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
        (
          statistics.type = 'issue' Or
          statistics.type = 'renew'
        )
      Group By
        statistics.branch
    ) circ_renew On circ_renew.branch = branches.branchcode Left Join
    (
      Select
        items.homebranch,
        COUNT(&ast;) As count
      From
        branchtransfers Left Join
        items On branchtransfers.itemnumber = items.itemnumber
      Where
        items.homebranch &lt;&gt; branchtransfers.tobranch And
        Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
        Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
        branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch And
        branchtransfers.comments Is Null And
        branchtransfers.reason = 'reserve'
      Group By
        items.homebranch
    ) ill_loaned On ill_loaned.homebranch = branches.branchcode Left Join
    (
      Select
        branchtransfers.tobranch,
        COUNT(&ast;) As count
      From
        branchtransfers Left Join
        items On branchtransfers.itemnumber = items.itemnumber
      Where
        branchtransfers.tobranch &lt;&gt; items.homebranch And
        Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
        Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
        branchtransfers.frombranch &lt;&gt; branchtransfers.tobranch And
        branchtransfers.comments Is Null And
        branchtransfers.reason = 'reserve'
      Group By
        branchtransfers.tobranch
    ) ill_borrowed On ill_borrowed.tobranch = branches.branchcode
  Group By
    branches.branchcode
  Order By
    branches.branchname
)
Union
Select
  doni_circ_renew.Library As 'Library',
  doni_circ_renew.count As 'Circulation',
  doni_ill_loaned.count As 'ILL loans',
  doni_ill_borrowed.count As 'ILL borrows'
From
  (
    Select
      'Doniphan County Total' As 'Library',
      Count(&ast;) As count
    From
      statistics
    Where
      Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
      Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
      (
        statistics.type = 'issue' Or
        statistics.type = 'renew'
      ) And
      statistics.branch Like 'DONI%'
  ) doni_circ_renew,
  (
    Select
      items.homebranch,
      COUNT(&ast;) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      items.homebranch Like 'DONI%' And
      items.homebranch &lt;&gt; branchtransfers.tobranch And
      branchtransfers.tobranch Not Like 'DONI%' And
      branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch And
      Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
      Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) doni_ill_loaned,
  (
    Select
      branchtransfers.tobranch,
      COUNT(&ast;) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      branchtransfers.tobranch Like 'DONI%' And
      branchtransfers.tobranch &lt;&gt; items.homebranch And
      items.homebranch Not Like 'DONI%' And
      Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
      Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
      branchtransfers.frombranch &lt;&gt; branchtransfers.tobranch And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) doni_ill_borrowed
Union
Select
  ph_circ_renew.Library As 'Library',
  ph_circ_renew.count As 'Circulation',
  ph_ill_loaned.count As 'ILL loans',
  ph_ill_borrowed.count As 'ILL borrows'
From
  (
    Select
      'Prairie Hills total' As 'Library',
      Count(&ast;) As count
    From
      statistics
    Where
      Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
      Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
      (
        statistics.type = 'issue' Or
        statistics.type = 'renew'
      ) And
      statistics.branch Like 'PH%'
  ) ph_circ_renew,
  (
    Select
      items.homebranch,
      COUNT(&ast;) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      items.homebranch Like 'PH%' And
      items.homebranch &lt;&gt; branchtransfers.tobranch And
      branchtransfers.tobranch Not Like 'PH%' And
      branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch And
      Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
      Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) ph_ill_loaned,
  (
    Select
      branchtransfers.tobranch,
      COUNT(&ast;) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      branchtransfers.tobranch Like 'PH%' And
      branchtransfers.tobranch &lt;&gt; items.homebranch And
      items.homebranch Not Like 'PH%' And
      Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
      Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
      branchtransfers.frombranch &lt;&gt; branchtransfers.tobranch And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) ph_ill_borrowed
Union
Select
  total_circ_renew.Library As 'Library',
  total_circ_renew.count As 'Circulation',
  total_ill_loaned.count As 'ILL loans',
  total_ill_borrowed.count As 'ILL borrows'
From
  (Select
      'Total' As 'Library',
      Count(&ast;) As count
    From
      statistics
    Where
      Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
      Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
      (
        statistics.type = 'issue' Or
        statistics.type = 'renew'
      )
  ) total_circ_renew,
  (
    Select
      items.homebranch,
      COUNT(&ast;) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      items.homebranch &lt;&gt; branchtransfers.tobranch And
      branchtransfers.tobranch &lt;&gt; branchtransfers.frombranch And
      Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
      Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) total_ill_loaned,
  (
    Select
      branchtransfers.tobranch,
      COUNT(&ast;) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      branchtransfers.tobranch &lt;&gt; items.homebranch And
      Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
      Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
      branchtransfers.frombranch &lt;&gt; branchtransfers.tobranch And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) total_ill_borrowed
LIMIT 1000

























