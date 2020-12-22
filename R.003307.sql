/*
R.003307

----------

Name: GHW - Authorised Values Synchronization - Item types
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-28 13:36:58
Modified on: 2020-01-28 14:07:19
Date last run: 2020-11-11 16:57:20

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', ltypes.category, '" target="_blank">Link to AV</a>') As LINK,
  If(itypes.itemtype Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", itypes.itemtype) As ITYPE,
  If(ltypes.authorised_value Is Null, "<span style='background-color: red; color: yellow'>Errror</span>", ltypes.authorised_value) As authorised_value,
  If(itypes.description Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", itypes.description) As description,
  ltypes.lib
From
  (Select
     itemtypes.itemtype,
     itemtypes.description
   From
     itemtypes) itypes Left Join
  (Select
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     authorised_values
   Where
     authorised_values.category = 'LITYPES'
   Group By
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib) ltypes On ltypes.authorised_value = itypes.itemtype
Union
Select
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', ltypes.category, '" target="_blank">Link to AV</a>') As LINK,
  If(itypes.itemtype Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", itypes.itemtype) As ITYPE,
  If(ltypes.authorised_value Is Null, "<span style='background-color: red; color: yellow'>Errror</span>", ltypes.authorised_value) As authorised_value,
  If(itypes.description Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", itypes.description) As description,
  ltypes.lib
From
  (Select
     itemtypes.itemtype,
     itemtypes.description
   From
     itemtypes) itypes Right Join
  (Select
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     authorised_values
   Where
     authorised_values.category = 'LITYPES'
   Group By
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib) ltypes On ltypes.authorised_value = itypes.itemtype
ORDER BY
  ITYPE,
  authorised_value
LIMIT 1000



