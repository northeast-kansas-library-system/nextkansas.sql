/*
R.003307

----------

Name: GHW - Authorised Values Synchronization - Item types
Created by: George Williams

----------

Group: -
     -

Created on: 2020-01-28 13:36:58
Modified on: 2023-11-15 17:17:43
Date last run: 2024-04-11 15:11:35

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  Concat('Link to AV') As LINK,
  If(itypes.itemtype Is Null, "Possible errror", itypes.itemtype) As ITYPE,
  If(ltypes.authorised_value Is Null, "Errror", ltypes.authorised_value) As authorised_value,
  If(itypes.description Is Null, "Possible errror", itypes.description) As description,
  If(itypes.description <> authorised_values.lib, 'Error', '') AS DESC_MATCH,
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
  Concat('Link to AV') As LINK,
  If(itypes.itemtype Is Null, "Possible errror", itypes.itemtype) As ITYPE,
  If(ltypes.authorised_value Is Null, "Errror", ltypes.authorised_value) As authorised_value,
  If(itypes.description Is Null, "Possible errror", itypes.description) As description,
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

























