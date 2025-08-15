/*
R.003787

----------

Name: GHW - 942 $h empty
Created by: George Williams

----------

Group: -
     -

Created on: 2023-12-06 21:58:23
Modified on: 2023-12-11 11:51:27
Date last run: 2024-03-07 13:21:49

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  biblioitems.biblionumber,
  biblioitems.cn_class,
  Group_Concat(ccodes.Counter) As Group_Concat_Counter
From
  biblioitems Join
  (Select
      items.biblionumber,
      items.ccode,
      Concat_Ws(' / ', items.ccode, LPAD(Count(Distinct items.itemnumber), 3, '0')) As Counter
    From
      items Join
      biblioitems On items.biblioitemnumber = biblioitems.biblioitemnumber
    Where
      biblioitems.cn_class IS NULL
    Group By
      items.biblionumber,
      items.ccode
    Order By
      items.biblionumber) ccodes On ccodes.biblionumber = biblioitems.biblionumber
Where
  biblioitems.cn_class IS NULL
Group By
  biblioitems.biblionumber,
  biblioitems.cn_class
Order By
  Group_Concat_Counter

























