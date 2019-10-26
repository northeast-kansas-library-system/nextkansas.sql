/*
R.002685

----------

Name: ER call number project
Created by: Heather Braum

----------

Group: Library-Specific
     Burlingame

Created on: 2016-04-15 16:18:09
Modified on: 2016-04-15 16:18:39
Date last run: 2018-03-12 12:22:11

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT "LEVEL 0 FILE" as Level, ccode, itemcallnumber, barcode FROM items WHERE homebranch='burlingame' AND barcode IN ('0003038001087','31220000185816','31220000185774','31220000218716','31220000215522','0003038001051','31220000228798','31220000153475','31220000197324','31220000208659','0003038000169','31220000197969','0003038005113','0003038003659','31220000115367','0003038003286','31220000149184','0003038005118','0003038005114','31220000105145','31220000100443','0003038005109','0003038002051')
UNION 
SELECT "LEVEL 1 FILE", ccode, itemcallnumber, barcode FROM items WHERE homebranch='burlingame' AND barcode IN ('31220000204278','31220000210085','0003038000112','0003038000885','0003038000889','0003038002127','0003038001391','0003038001388','31220000167616','31220000202447','31220000167806','31220000167657','31220000151354','31220000196599','31220000196557','31220000167640','31220000167681','31220000151453','31220000151305','31220000151495','31220000167608','31220000167723','31220000151313','31220000151412','0003038000914','0003038000909','0003038001036','31220000090164','0003038000897','31220000196664','0003038001179','0003038000542','0003038001316','31220000216033','31220000153137','31220000153160','31220000142916','31220000173952','31220000153145','31220000153186','0003038002128','31220000167699','31220000216090','0003038001084','31220000196698','31220000196714','31220000228335','31220000218799','0003038001086','31220000210184','31220000151487','31220000151446','31220000151404','0003038001169','0003038000122','0003038007180','31220000153582','31220000219342','31220000215480','31220000201597','31220000151321','31220000167764','31220000151396','31220000151511','31220000151420','31220000151347','31220000151461','31220000151503','31220000151438','31220000202660','0003038003614','31220000100633','0003038005116','31220000064599','0003038005111','0003038005112','0003038003619','0003038005117','0003038003619','0003038006513','0003038005597','0003038005115','0003038005110','31220000105152','31220000230182','0003038000905','0003038000893','0003038000901','0003038001170','31220000153079','31220000153129','31220000153103','31220000153046','31220000153004','31220000153061','31220000153087','31220000153038','31220000153178','31220000153012','31220000153053','31220000157708','0003038001203','0003038001930','31220000090909','31220000090388','31220000148145','31220000148103','31220000148061','31220000147949','31220000148020','31220000147980','31220000148111','31220000148152','0003038002333','0003038003362','0003038002329','31220000166782','31220000210564','31220000151289','31220000151362','31220000221355','31220000221397','31220000221314','31220000176419','31220000230224','31220000202405','31220000231628','31220000231669','31220000215563','31220000201670','0003038003661','0003038005566','0003038001383','31220000201639')
UNION 
SELECT "LEVEL 2 FILE", ccode, itemcallnumber, barcode FROM items WHERE homebranch='burlingame' AND barcode IN ('31220000116738','31220000173911','0003038007176','0003038001032','31220000174448','0003038000908','31220000187382','31220000234739','31220000231743','0003038001092','31220000151263','31220000151271','31220000151180','31220000151149','31220000151222','31220000208584','31220000231370','0003038001325','31220000217346','31220000217197','31220000212289','31220000217262','31220000202256','31220000156270','31220000155504','31220000151065','31220000204575','31220000156312','31220000196623','31220000151230','0003038000120','31220000151198','31220000151297','0003038002827','31220000231321','0003038001219','0003038001174','31220000215951','31220000212131','0003038003897','31220000217361','31220000217155','0003038003665','31220000151131','31220000141355','31220000214400','31220000175700','31220000093036','31220000151255','0003038001782','31220000151214','31220000199981','0003038002147','0003038002120','0003038000911','31220000118452','31220000151107','31220000203262','31220000203221','31220000196540','31220000221272','31220000126356','31220000093010','0003038000910','0003038000906','31220000151172','31220000151057','31220000155603','0003038003852','31220000155645','31220000156197','0003038002826','0003038002822','0003038002817','31220000201530','31220000201571','31220000201613','31220000201696','31220000201654','31220000201738','31220000201548','31220000195690','31220000189966','31220000155686','31220000151115','31220000155470','31220000202363','31220000187572','31220000169968','31220000169885','31220000169802','31220000169927','0003038000241','31220000160413','0003038000104','31220000196631','31220000231701','31220000210044','31220000204567','0003038007877','31220000155553','31220000156239','31220000155801','31220000155769','31220000155728','31220000200029','31220000155652','31220000155512') 
UNION 
SELECT "LEVEL 3 FILE", ccode, itemcallnumber, barcode FROM items WHERE homebranch='burlingame' AND barcode IN ('31220000168317','31220000167624','31220000167889','31220000168077','31220000168150','31220000167996','31220000167772','31220000168069','31220000167822','31220000167632','31220000167913','31220000208501','31220000208691','31220000210002','0003038001353','31220000155660','31220000167954','31220000168036','31220000167707','31220000167814','31220000167665','31220000167731','31220000186129','31220000167749','31220000167921','31220000208618','31220000200003','31220000155629','31220000155736','31220000155819','0003038000103','31220000151479','31220000204450','31220000093028','31220000123841','31220000121522','0003038000121','0003038001088','31220000167871','31220000105616','0003038001097','0003038003844','31220000168234','31220000151388','31220000151370','0003038001074','0003038003846','31220000218625','31220000217189','0003038000492','31220000234697','31220000232154','31220000092954','31220000230638','31220000137791','31220000231552','31220000231594','0003038001202','31220000199890','31220000204534','31220000151339','0003038005563','0003038001178','31220000228830','31220000167798','31220000167673','31220000168275','0003038001387','31220000167756','31220000167848','31220000215449','31220000199858','31220000167715')
UNION 
SELECT "LEVEL 4 FILE", ccode, itemcallnumber, barcode FROM items WHERE homebranch='burlingame' AND barcode IN ('0003038000840','31220000212172','31220000216140','0003038003845','31220000216066','31220000228269','0003038007217','31220000217536','31220000232535','31220000199940','0003038001089','31220000167962','31220000167939','0003038001171','31220000168002','31220000167970','31220000168010','0003038001738','31220000167905','31220000167897','31220000168051','31220000167863')
ORDER BY Level, ccode, itemcallnumber
LIMIT 1000


