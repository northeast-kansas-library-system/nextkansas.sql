/*
R.002711

----------

Name: GHW - Hoopla Query
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2016-07-13 13:43:12
Modified on: 2017-03-02 15:11:09
Date last run: 2025-04-17 18:16:14

----------

Public: 0
Expiry: 0

----------

Hoopla Report

----------
*/



SELECT biblionumber FROM biblioitems WHERE biblionumber IN (SELECT biblionumber FROM items WHERE itype = 'DIGITAL' AND homebranch='DIGITAL' AND itemcallnumber='HOOPLA' AND ccode IN ('DLAUDIO','DLVIDEO','DLMUSIC','DLBOOK')) AND date(timestamp) < '2017-03-01' limit 200000



























