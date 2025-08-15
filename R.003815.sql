/*
R.003815

----------

Name: ADMINREPORT blank 942 shelving location
Created by: George Williams

----------

Group: -
     -

Created on: 2024-03-27 23:02:25
Modified on: 2024-03-27 23:02:25
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  biblioitems.biblionumber,
  biblioitems.agerestriction,
  Group_Concat(Concat_Ws(' - ', item_locations.Count_itemnumber, item_locations.permanent_location)) As BRICK
From
  biblioitems Join
  (Select
      items.biblionumber,
      items.permanent_location,
      Count(items.itemnumber) As Count_itemnumber
    From
      items
    Group By
      items.biblionumber,
      items.permanent_location
    Order By
      items.biblionumber,
      Count_itemnumber Desc,
      items.permanent_location) item_locations On item_locations.biblionumber = biblioitems.biblionumber
Where
  biblioitems.agerestriction Is Null
Group By
  biblioitems.biblionumber,
  biblioitems.agerestriction

























