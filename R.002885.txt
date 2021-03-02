/*
R.002885

----------

Name: GHW Courier Accident
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-01-18 15:46:09
Modified on: 2017-01-18 15:57:27
Date last run: 2021-01-28 09:25:52

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  items.itemnumber,
  items.barcode,
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.replacementprice,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.itemlost,
  items.itemlost_on,
  items.withdrawn,
  items.withdrawn_on,
  items.damaged
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber
WHERE
  (items.barcode = "0003029007988") OR
  (items.barcode = "0003029001669") OR
  (items.barcode = "0003010023156") OR
  (items.barcode = "0003010023803") OR
  (items.barcode = "0003010023164") OR
  (items.barcode = "0003010023145") OR
  (items.barcode = "0003042021081") OR
  (items.barcode = "0003029037053") OR
  (items.barcode = "1BERN000080299") OR
  (items.barcode = "0003044002704") OR
  (items.barcode = "SAB1000000650") OR
  (items.barcode = "0003029028293") OR
  (items.barcode = "0003029028295") OR
  (items.barcode = "0003029028294") OR
  (items.barcode = "0003029028296") OR
  (items.barcode = "0003033001085") OR
  (items.barcode = "00107000084270") OR
  (items.barcode = "0003029037642") OR
  (items.barcode = "0003014007043") OR
  (items.barcode = "0003012047032") OR
  (items.barcode = "3FN9000035583V") OR
  (items.barcode = "0003041000774") OR
  (items.barcode = "0003005010525") OR
  (items.barcode = "33080001238586") OR
  (items.barcode = "0003029005267") OR
  (items.barcode = "3HFPL36006621") OR
  (items.barcode = "0003004022749") OR
  (items.barcode = "1BERN000119618") OR
  (items.barcode = "1BERN00013748D") OR
  (items.barcode = "00107000185580") OR
  (items.barcode = "3HFPL36001064") OR
  (items.barcode = "3HFPL36004855") OR
  (items.barcode = "0003046001536") OR
  (items.barcode = "0003000037519") OR
  (items.barcode = "0003026023246") OR
  (items.barcode = "0003009015297") OR
  (items.barcode = "0003004019053") OR
  (items.barcode = "0003029007445") OR
  (items.barcode = "00107000080450") OR
  (items.barcode = "3HFPL36002484") OR
  (items.barcode = "1BERN000142412") OR
  (items.barcode = "3CY6000015020K") OR
  (items.barcode = "3FN9000034443P") OR
  (items.barcode = "0003034003739") OR
  (items.barcode = "0003044009764") OR
  (items.barcode = "0003045005375") OR
  (items.barcode = "0003042005596") OR
  (items.barcode = "0003042005591") OR
  (items.barcode = "0003042005594") OR
  (items.barcode = "0003042006408") OR
  (items.barcode = "0003044005087") OR
  (items.barcode = "0003042000080") OR
  (items.barcode = "0003034003404") OR
  (items.barcode = "0003042007332") OR
  (items.barcode = "0003034004575") OR
  (items.barcode = "0003029040699") OR
  (items.barcode = "0003034007063") OR
  (items.barcode = "0003029003886") OR
  (items.barcode = "0003042012495") OR
  (items.barcode = "0003034008922") OR
  (items.barcode = "0003016004908") OR
  (items.barcode = "0003045000815") OR
  (items.barcode = "0003042020027") OR
  (items.barcode = "3HFPL00022466F") OR
  (items.barcode = "3 FI900201637G") OR
  (items.barcode = "33080001327728") OR
  (items.barcode = "0003029015944") OR
  (items.barcode = "0003029018212") OR
  (items.barcode = "0003029012110") OR
  (items.barcode = "3HFPL00017942I") OR
  (items.barcode = "0003028012846") OR
  (items.barcode = "0003035006178") OR
  (items.barcode = "0003009047210") OR
  (items.barcode = "1BERN000129417") OR
  (items.barcode = "3 FI900217269O") OR
  (items.barcode = "0003029027520") OR
  (items.barcode = "0003035011786") OR
  (items.barcode = "3HFPL00027835K") OR
  (items.barcode = "0003009032627") OR
  (items.barcode = "0003035006883") OR
  (items.barcode = "0003018024553") OR
  (items.barcode = "ILEA000300116V") OR
  (items.barcode = "ILEA000300115U") OR
  (items.barcode = "ILEA000300113S") OR
  (items.barcode = "ILEA000300111Q") OR
  (items.barcode = "ILEA000300110P") OR
  (items.barcode = "0003035010983") OR
  (items.barcode = "0003035010376") OR
  (items.barcode = "1BERN000026064") OR
  (items.barcode = "1BERN00015826") OR
  (items.barcode = "0003045000129") OR
  (items.barcode = "WAC405802") OR
  (items.barcode = "ilea0003742070") OR
  (items.barcode = "0003029009687") OR
  (items.barcode = "1BERN00012279B") OR
  (items.barcode = "0003028010123") OR
  (items.barcode = "00105000735933") OR
  (items.barcode = "0003000032383") OR
  (items.barcode = "0003029042480") OR
  (items.barcode = "0003022016024") OR
  (items.barcode = "0003023012994") OR
  (items.barcode = "0003012056239") OR
  (items.barcode = "0003035004018") OR
  (items.barcode = "0003035001280") OR
  (items.barcode = "0003035007844") OR
  (items.barcode = "0003028033554") OR
  (items.barcode = "0003004019516") OR
  (items.barcode = "0003035000315") OR
  (items.barcode = "0003023018839") OR
  (items.barcode = "00106000069919") OR
  (items.barcode = "0003019013629") OR
  (items.barcode = "0003018024438") OR
  (items.barcode = "SAB1000000107") OR
  (items.barcode = "3HFPL000021097") OR
  (items.barcode = "0003035010738") OR
  (items.barcode = "00107000294382") OR
  (items.barcode = "3 FI900205553H") OR
  (items.barcode = "0003035007420") OR
  (items.barcode = "0003027017088") OR
  (items.barcode = "0003035007699") OR
  (items.barcode = "0003029040826") OR
  (items.barcode = "3HFPL000032000") OR
  (items.barcode = "0003012056898") OR
  (items.barcode = "3ZC3032004664") OR
  (items.barcode = "0003029040094") OR
  (items.barcode = "0003029040091") OR
  (items.barcode = "3 FI900201674H") OR
  (items.barcode = "00107000378151") OR
  (items.barcode = "0003027025370") OR
  (items.barcode = "3HFPL36001100") OR
  (items.barcode = "0003027024003") OR
  (items.barcode = "0003012044800") OR
  (items.barcode = "0003012050683") OR
  (items.barcode = "0003009023777") OR
  (items.barcode = "0003024013975") OR
  (items.barcode = "0003014005533") OR
  (items.barcode = "3ZC3032007933") OR
  (items.barcode = "0003005009535") OR
  (items.barcode = "0003010014398") OR
  (items.barcode = "0003016005894") OR
  (items.barcode = "0003043004572") OR
  (items.barcode = "0003009041987") OR
  (items.barcode = "0003029022567") OR
  (items.barcode = "3HFPL36000403") OR
  (items.barcode = "0003009007777") OR
  (items.barcode = "0003004023660") OR
  (items.barcode = "3HFPL36005698") OR
  (items.barcode = "0003026026947") OR
  (items.barcode = "0003029041631") OR
  (items.barcode = "0003004021173") OR
  (items.barcode = "0003031004738") OR
  (items.barcode = "3HFPL36003154") OR
  (items.barcode = "0003029036615") OR
  (items.barcode = "3 FI900209878V") OR
  (items.barcode = "3 FI900206401A") OR
  (items.barcode = "0003027019303") OR
  (items.barcode = "ILEA0003028280") OR
  (items.barcode = "0003029026959") OR
  (items.barcode = "0003029026956") OR
  (items.barcode = "0003041003213") OR
  (items.barcode = "3HFPL36001701") OR
  (items.barcode = "3HFPL36004843") OR
  (items.barcode = "0003042000836") OR
  (items.barcode = "0003042005600") OR
  (items.barcode = "0003000046049") OR
  (items.barcode = "3HFPL36006812") OR
  (items.barcode = "0003003011243") OR
  (items.barcode = "3HFPL000232169") OR
  (items.barcode = "0003026022884") OR
  (items.barcode = "0003026023200") OR
  (items.barcode = "0003026022978") OR
  (items.barcode = "0003026022722") OR
  (items.barcode = "0003015022912") OR
  (items.barcode = "0003041004243") OR
  (items.barcode = "0003000024669") OR
  (items.barcode = "0003000024513") OR
  (items.barcode = "0003000020558") OR
  (items.barcode = "0003000020983") OR
  (items.barcode = "0003041000096") OR
  (items.barcode = "0003029038742") OR
  (items.barcode = "3HFPL36005744") OR
  (items.barcode = "0003027015214") OR
  (items.barcode = "3HFPL36006775") OR
  (items.barcode = "3ZC3032004050") OR
  (items.barcode = "0003028031935") OR
  (items.barcode = "0003038007759") OR
  (items.barcode = "3ZC9000131147X") OR
  (items.barcode = "3ZC9000026400S") OR
  (items.barcode = "0003015024311") OR
  (items.barcode = "0003021007665") OR
  (items.barcode = "0003028031261") OR
  (items.barcode = "3HFPL000220144") OR
  (items.barcode = "0003009002863") OR
  (items.barcode = "0003004024238") OR
  (items.barcode = "0003019008000") OR
  (items.barcode = "0003004021996") OR
  (items.barcode = "0003043000490") OR
  (items.barcode = "0003045005506") OR
  (items.barcode = "0003029038203") OR
  (items.barcode = "0003004022848") OR
  (items.barcode = "3 FI9002114229") OR
  (items.barcode = "00107000256472") OR
  (items.barcode = "0003006027821") OR
  (items.barcode = "0003012040722") OR
  (items.barcode = "0003009052498") OR
  (items.barcode = "0003006040772") OR
  (items.barcode = "00107000246598") OR
  (items.barcode = "0003029038933") OR
  (items.barcode = "3HFPL00021349E") OR
  (items.barcode = "0003027024328") OR
  (items.barcode = "ILEA0003192675") OR
  (items.barcode = "0003024008237") OR
  (items.barcode = "1003007103619") OR
  (items.barcode = "0003013007454") OR
  (items.barcode = "0003013005175") OR
  (items.barcode = "0003024012493") OR
  (items.barcode = "0003004024995") OR
  (items.barcode = "0003004022383") OR
  (items.barcode = "0003034008879") OR
  (items.barcode = "0003024006193") OR
  (items.barcode = "0003024006136") OR
  (items.barcode = "0003034000613") OR
  (items.barcode = "0003034001037") OR
  (items.barcode = "0003013019953") OR
  (items.barcode = "0003003001852") OR
  (items.barcode = "0003024000003") OR
  (items.barcode = "0003034008694") OR
  (items.barcode = "0003018011490") OR
  (items.barcode = "0003013022325") OR
  (items.barcode = "0003015016005") OR
  (items.barcode = "0003015001202") OR
  (items.barcode = "0003024002018") OR
  (items.barcode = "ilea000365299b") OR
  (items.barcode = "00105000106309") OR
  (items.barcode = "0003034002992") OR
  (items.barcode = "0003005001486") OR
  (items.barcode = "00105000175940") OR
  (items.barcode = "0003017003989") OR
  (items.barcode = "0003034005525") OR
  (items.barcode = "0003034008556") OR
  (items.barcode = "0003024007758") OR
  (items.barcode = "0003004009051") OR
  (items.barcode = "0003000046306") OR
  (items.barcode = "0003024001358") OR
  (items.barcode = "0003024001362") OR
  (items.barcode = "3CX4000005702N") OR
  (items.barcode = "1BERN000020721") OR
  (items.barcode = "1003004102281") OR
  (items.barcode = "0003034009055") OR
  (items.barcode = "0003033009849") OR
  (items.barcode = "0003033011325") OR
  (items.barcode = "0003033010153") OR
  (items.barcode = "0003004003388") OR
  (items.barcode = "0003012049732") OR
  (items.barcode = "0003000044241") OR
  (items.barcode = "0003000032550") OR
  (items.barcode = "0003012052579") OR
  (items.barcode = "0003029044032") OR
  (items.barcode = "3HFPL36005894") OR
  (items.barcode = "0003040017651") OR
  (items.barcode = "33080000892151") OR
  (items.barcode = "0003029033892") OR
  (items.barcode = "ILEA0002837726") OR
  (items.barcode = "ILEA000313861%") OR
  (items.barcode = "ILEA0002550874") OR
  (items.barcode = "3HFPL36001868") OR
  (items.barcode = "0003010012151") OR
  (items.barcode = "0003010023090") OR
  (items.barcode = "3ZC3032012018") OR
  (items.barcode = "0003010022979") OR
  (items.barcode = "33080000916976") OR
  (items.barcode = "3HFPL36002523") OR
  (items.barcode = "0003010022881") OR
  (items.barcode = "0003031004068") OR
  (items.barcode = "0003010023054") OR
  (items.barcode = "0003010023467") OR
  (items.barcode = "0003035011196") OR
  (items.barcode = "0003035010130") OR
  (items.barcode = "ilea000344599b") OR
  (items.barcode = "ilea0003426631") OR
  (items.barcode = "ilea0003346092") OR
  (items.barcode = "33080001303950") OR
  (items.barcode = "0003010024400") OR
  (items.barcode = "ilea000362081/") OR
  (items.barcode = "0003016006007") OR
  (items.barcode = "0003004022198") OR
  (items.barcode = "3ZC3032010945") OR
  (items.barcode = "ilea0003659325") OR
  (items.barcode = "0003010024902") OR
  (items.barcode = "ilea0003534811") OR
  (items.barcode = "0003000028933") OR
  (items.barcode = "0003040018149") OR
  (items.barcode = "33080001199309") OR
  (items.barcode = "3ZC3032005981") OR
  (items.barcode = "0003033010708")
ORDER BY
  items.homebranch,
  items.location,
  items.itype,
  items.ccode,
  items.itemcallnumber,
  biblio.author,
  biblio.title



