/*
R.003707

----------

Name: Test report for training
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-02-13 12:24:02
Modified on: 2023-02-13 12:24:41
Date last run: 2023-02-15 14:34:18

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws('', 
    '<a ', 
    'class="btn btn-success noprint" ', 
    'style="color: white;" ', 
    'href="/cgi-bin/koha/catalogue/moredetail.pl?itemnumber=', 
    items.itemnumber, 
    '" target="_blank">Item link</a>' 
  ) AS ITEM, 
  items.itemnumber,
  items.biblionumber,
  items.biblioitemnumber,
  items.barcode,
  items.dateaccessioned,
  items.booksellerid,
  items.homebranch,
  items.price,
  items.replacementprice,
  items.replacementpricedate,
  items.datelastborrowed,
  items.datelastseen,
  items.stack,
  items.notforloan,
  items.damaged,
  items.damaged_on,
  items.itemlost,
  items.itemlost_on,
  items.withdrawn,
  items.withdrawn_on,
  items.itemcallnumber,
  items.coded_location_qualifier,
  items.issues,
  items.renewals,
  items.reserves,
  items.restricted,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.holdingbranch,
  items.paidfor,
  items.timestamp,
  items.location,
  items.permanent_location,
  items.onloan,
  items.cn_source,
  items.cn_sort,
  items.ccode,
  items.materials,
  items.uri,
  items.itype,
  items.more_subfields_xml,
  items.enumchron,
  items.copynumber,
  items.stocknumber,
  items.new_status,
  items.exclude_from_local_holds_priority
FROM
  items 
LIMIT
  100

























