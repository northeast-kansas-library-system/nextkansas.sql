/*
R.003556

----------

Name: SANDBOX
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-09-07 12:04:47
Modified on: 2023-01-25 15:07:44
Date last run: 2023-01-25 15:08:22

----------

Public: 0
Expiry: 300

----------



----------
*/



Select 
  branchesscodess.branchname,
  branchesscodess.branchcode,
  branchesscodess.LOCATION,
  branchesscodess.LOCATION_CODE,
  branchesscodess.ITEM_TYPE,
  branchesscodess.ITEM_TYPE_CODE,
  branchesscodess.COLLECTION_CODE_DESCRIPTION,
  branchesscodess.COLLECTION_CODE_CODE,
  statistics.type,
  Count(statistics.datetime) As COUNT
From (
    Select 
      branches.branchcode,
      branches.branchname,
      locss.lib As LOCATION,
      locss.authorised_value As LOCATION_CODE,
      itemtypes.description As ITEM_TYPE,
      itemtypes.itemtype As ITEM_TYPE_CODE,
      ccodess.lib As COLLECTION_CODE_DESCRIPTION,
      ccodess.authorised_value As COLLECTION_CODE_CODE
    From branches,
      (
        Select authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib,
          authorised_values.lib_opac
        From authorised_values
        Where authorised_values.category = 'LOC'
      ) locss,
      itemtypes,
      (
        Select authorised_values.category,
          authorised_values.authorised_value,
          authorised_values.lib,
          authorised_values.lib_opac
        From authorised_values
        Where authorised_values.category = 'CCODE'
      ) ccodess
    Where branches.branchcode Like <<Choose your library|ZBRAN>>
  ) branchesscodess
  Join statistics On statistics.branch = branchesscodess.branchcode
  And statistics.location = branchesscodess.LOCATION_CODE
  And statistics.itemtype = branchesscodess.ITEM_TYPE_CODE
  And statistics.ccode = branchesscodess.COLLECTION_CODE_CODE
Where (
    statistics.type = 'issue'
    Or statistics.type = 'renew'
  )
  And statistics.datetime Between <<The beginning of the day on|date>> And (<<the end of the day on|date>> + Interval 1 Day)
Group By 
  branchesscodess.branchname,
  branchesscodess.branchcode,
  branchesscodess.LOCATION,
  branchesscodess.LOCATION_CODE,
  branchesscodess.ITEM_TYPE,
  branchesscodess.ITEM_TYPE_CODE,
  branchesscodess.COLLECTION_CODE_DESCRIPTION,
  branchesscodess.COLLECTION_CODE_CODE,
  statistics.type
Order By 
  branchesscodess.branchname,
  branchesscodess.branchcode,
  branchesscodess.LOCATION,
  branchesscodess.LOCATION_CODE,
  branchesscodess.ITEM_TYPE,
  branchesscodess.ITEM_TYPE_CODE,
  branchesscodess.COLLECTION_CODE_DESCRIPTION,
  branchesscodess.COLLECTION_CODE_CODE

























