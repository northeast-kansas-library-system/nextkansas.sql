/*
R.002438

----------

Name: 9.5 – All other materials , including videogames
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2015-01-08 17:13:04
Modified on: 2017-02-06 10:08:42
Date last run: 2019-03-01 09:26:49

----------

Public: 0
Expiry: 0

----------

ready for 2016.

----------
*/

SELECT homebranch, count(*) FROM items WHERE (itype IN ('COMPUTER','EQUIPMENT','GAME','ILL','KITS','MICROFORM','MIFI','MUSIC')) OR (itype IN ('LOCALHOLD','REFERENCE','WALKIN') AND ccode IN ('GADGET','COMPUTER','GAMECUBE','MAP','MISC','NINTNDO3DS','PS3','PUZZLESBDG','SOFTWARE','WII','XBOX360')) GROUP BY homebranch LIMIT 100



