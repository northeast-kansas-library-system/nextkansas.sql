/*
R.003350

----------

Name: GHW - Special reopening holds queue report for LEAVENWRTH
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-27 16:12:40
Modified on: 2020-08-27 16:23:23
Date last run: 2021-02-04 14:24:49

----------

Public: 0
Expiry: 300

----------

Run on Friday - Set items aside till Monday - check items in after 2:15 a.m. Monday morning

----------
*/

Select
    Concat_Ws('<br />',
      Concat('Current: ', items.holdingbranch), 
      Concat('Home: ', items.homebranch), 
      Concat('Last seen: ', items.datelastseen), 
      Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber, '\" target="_blank">Go to biblio</a>')
    ) As INFO,
    Concat_Ws('<br />', 
      If(items.location = 'CART', 'Recently returned', items.location), 
      ccodes.lib,
      items.itemcallnumber, items.copynumber
    ) As CALL_NUMBER,
    Concat_Ws('<br />', 
      biblio.author, 
      (Concat_Ws('<br />', 
        biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'))
      )
    ) As AUTHOR_TITLE,
    Concat_Ws('<br />', 
      (Concat('<img src="/cgi-bin/koha/svc/barcode?barcode=', '*', Upper(items.barcode), '*', '&type=Code39"></img>')), 
      items.barcode
    ) AS BARCODE,
    CONCAT_WS('<br />',
    If(reserves.suspend_until > 1, Concat('Suspended until ', Date_Format(reserves.suspend_until, "%m/%d/%Y")), If(reserves.suspend = '', 'Active', 'Suspended indefinitely')),
    Concat_Ws('', 
      If(items.damaged_on > 0, Concat('Damaged on ', items.damaged_on, '<br />'), ''), 
      If(items.itemlost_on > 0, Concat('Lost on ', items.itemlost_on, '<br />'), ''), 
      If(items.withdrawn_on > 0, Concat('Withdrawn on ', items.withdrawn_on, '<br />'), '')
    )
  ) As STATUS_ISSUES
From
    reserves Join
    biblio On reserves.biblionumber = biblio.biblionumber Inner Join
    items On items.biblionumber = biblio.biblionumber Left Join
    (Select
         authorised_values.category,
         authorised_values.authorised_value,
         authorised_values.lib
     From
         authorised_values
     Where
         authorised_values.category = 'ccode') ccodes On ccodes.authorised_value = items.ccode Inner Join
    biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber
Where
    reserves.branchcode Like 'LEAVENWRTH' And
    If(reserves.suspend > 0, 'Yes', 'No') Like '%' And
    If(reserves.suspend_until > 1, Concat('Suspended until ', Date_Format(reserves.suspend_until, "%m/%d/%Y")),
    If(reserves.suspend = '', 'Active', 'Suspended indefinitely')) = 'Suspended until 08/31/2020' And
    items.homebranch = 'LEAVENWRTH' And
    items.notforloan = 0 And
    items.onloan Is Null And
    items.holdingbranch = 'LEAVENWRTH'
Group By
    biblio.biblionumber
Order By
    items.homebranch,
    If(items.location = 'CART', 'Z', items.location),
    items.itype,
    items.ccode,
    items.itemcallnumber,
    biblio.author,
    biblio.title



