/*
R.003308

----------

Name: GHW - Authorised Values Synchronization - Collection Codes
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-28 14:21:20
Modified on: 2020-03-11 15:40:51
Date last run: 2021-06-04 15:34:10

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', ccodes.category, '" target="_blank">Link to CCODE</a>') As LINK_TO_CCODE,
  If(ccodes.category Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", ccodes.category) As CATEGORY,
  ccodes.authorised_value As CCODE,
  If(lccodes.category Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", lccodes.category) As ALT_CATEGORY,
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', lccodes.category, '" target="_blank">Link to LCCODE</a>') As LINK_TO_LCCODE,
  lccodes.authorised_value As LCCODE
From
  (Select
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     authorised_values
   Where
     authorised_values.category = 'CCODE') ccodes Left Join
  (Select
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     authorised_values
   Where
     authorised_values.category = 'LCCODE') lccodes On lccodes.authorised_value = ccodes.authorised_value
Union
Select
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', ccodesx.category, '" target="_blank">Link to CCODE</a>') As LINK,
  If(ccodesx.category Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", ccodesx.category) As category,
  ccodesx.authorised_value,
  If(lccodesx.category Is Null, "<span style='background-color: red; color: yellow'>Possible errror</span>", lccodesx.category) As category1,
  Concat('<a href="/cgi-bin/koha/admin/authorised_values.pl?searchfield=', lccodesx.category, '" target="_blank">Link to LCCODE</a>') As LINK1,
  lccodesx.authorised_value As authorised_value1
From
  (Select
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     authorised_values
   Where
     authorised_values.category = 'CCODE') ccodesx Right Join
  (Select
     authorised_values.category,
     authorised_values.authorised_value,
     authorised_values.lib
   From
     authorised_values
   Where
     authorised_values.category = 'LCCODE') lccodesx On lccodesx.authorised_value = ccodesx.authorised_value
Order By
  CCODE,
  LCCODE
LIMIT
  1000



