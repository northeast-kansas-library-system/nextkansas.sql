/*
R.003714

----------

Name: Test x 1
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-22 22:14:25
Modified on: 2023-02-27 16:28:24
Date last run: 2023-02-27 16:28:29

----------

Public: 0
Expiry: 300

----------



----------
*/



Select 
  biblio.biblionumber,
  items.itemnumber,
  items.barcode,
  If(
    items.homebranch = items.holdingbranch,
    homebranches.branchname,
    Concat(
      homebranches.branchname,
      ' (Currently at: ',
      holdingbranches.branchname,
      ')'
    )
  ) As LIBRARY,
  If(
    items.permanent_location = items.location,
    permanent_locs.lib,
    Concat(permanent_locs.lib, ' (', locs.lib, ')')
  ) As SHELVING_LOCATION,
  itemtypes.description As ITEM_TYPE,
  ccodes.lib As COLLECTION_CODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(
    " ",
    biblio.title,
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="h"]'
    ),
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="b"]'
    ),
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="p"]'
    ),
    ExtractValue(
      biblio_metadata.metadata,
      '//datafield[@tag="245"]/subfield[@code="n"]'
    )
  ) As FULL_TITLE,
  items.onloan As DUE_DATE,
  not_loans.lib As NOT_FOR_LOAN,
  damages.lib As DAMAGED,
  items.damaged_on,
  losts.lib As LOST,
  items.itemlost_on,
  withdrawns.lib As WITHDRAWN,
  items.withdrawn_on
From items
  Join biblio On items.biblionumber = biblio.biblionumber
  Join biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber
  Left Join branches homebranches On homebranches.branchcode = items.homebranch
  Left Join branches holdingbranches On holdingbranches.branchcode = items.holdingbranch
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'LOC'
    ) permanent_locs On permanent_locs.authorised_value = items.permanent_location
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'LOC'
    ) locs On locs.authorised_value = items.location
  Left Join itemtypes On itemtypes.itemtype = items.itype
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'CCODE'
    ) ccodes On ccodes.authorised_value = items.ccode
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'NOT_LOAN'
    ) not_loans On not_loans.authorised_value = items.notforloan
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'DAMAGED'
    ) damages On damages.authorised_value = items.damaged
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'LOST'
    ) losts On losts.authorised_value = items.itemlost
  Left Join 
    (
      Select authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib,
        authorised_values.lib_opac
      From authorised_values
      Where authorised_values.category = 'WITHDRAWN'
    ) withdrawns On withdrawns.authorised_value = items.withdrawn
Where items.homebranch Like <<Home library|branches:all>>
  And items.holdingbranch Like <<Current library|branches:all>>
  And items.permanent_location Like <<Permanent shelving location|LOC:all>>
  And items.location Like <<Current shelving location|LOC:all>>
  And items.itype Like <<Item type|itemtypes:all>>
  And items.ccode Like <<Item collection code|CCODE:all>>
  And items.notforloan Like <<Not for loan status|NOT_LOAN:all>>
  And items.damaged Like <<Damaged status|DAMAGED:all>>
  And items.itemlost Like <<Lost status|LOST:all>>
  And items.withdrawn Like <<Withdrawn status|WITHDRAWN:all>>
ORDER BY 
  homebranches.branchname,
  permanent_locs.lib,
  itemtypes.description,
  ccodes.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.barcode
  

























