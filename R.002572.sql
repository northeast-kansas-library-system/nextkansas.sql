/*
R.002572

----------

Name: Dewey number circulation at your library in a given month
Created by: Heather Braum

----------

Group: Circulation
     Circ Stats

Created on: 2015-07-28 17:39:50
Modified on: 2015-09-10 15:10:13
Date last run: 2022-05-31 13:39:19

----------

Public: 0
Expiry: 0

----------

Circulation of Dewey numbers (grouped by Dewey numbers and location) during a set month at your library (items from any collection). From the dropdown menus, choose month, year, and your library. 

----------
*/



SELECT 
	CASE
WHEN i.itemcallnumber REGEXP '^.*00[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*01[0-9] .*$' THEN '000 Generalities'
WHEN i.itemcallnumber REGEXP '^.*01[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*01[0-9] .*$' THEN '010 Bibliographies'
WHEN i.itemcallnumber REGEXP '^.*02[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*02[0-9] .*$' THEN '020 Library and Information Science'
WHEN i.itemcallnumber REGEXP '^.*03[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*03[0-9] .*$' THEN '030 General Encyclopedias'
WHEN i.itemcallnumber REGEXP '^.*04[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*04[0-9] .*$' THEN '040 Not used'
WHEN i.itemcallnumber REGEXP '^.*05[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*05[0-9] .*$' THEN '050 General Periodicals'
WHEN i.itemcallnumber REGEXP '^.*06[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*06[0-9] .*$' THEN '060 General Organizations and Museums'
WHEN i.itemcallnumber REGEXP '^.*07[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*07[0-9] .*$' THEN '070 Journalism and Publishing'
WHEN i.itemcallnumber REGEXP '^.*08[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*08[0-9] .*$' THEN '080 Collections'
WHEN i.itemcallnumber REGEXP '^.*09[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*09[0-9] .*$' THEN '090 Manuscripts and Rare Books'
WHEN i.itemcallnumber REGEXP '^.*10[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*10[0-9] .*$' THEN '100 Philosophy'
WHEN i.itemcallnumber REGEXP '^.*11[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*11[0-9] .*$' THEN '110 Metaphysics'
WHEN i.itemcallnumber REGEXP '^.*12[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*12[0-9] .*$' THEN '120 Epistemology'
WHEN i.itemcallnumber REGEXP '^.*13[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*13[0-9] .*$' THEN '130 Paranormal Phenomena and Occult'
WHEN i.itemcallnumber REGEXP '^.*14[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*14[0-9] .*$' THEN '140 Specific Philosophies'
WHEN i.itemcallnumber REGEXP '^.*15[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*15[0-9] .*$' THEN '150 Psychology'
WHEN i.itemcallnumber REGEXP '^.*16[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*16[0-9] .*$' THEN '160 Logic'
WHEN i.itemcallnumber REGEXP '^.*17[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*17[0-9] .*$' THEN '170 Ethics'
WHEN i.itemcallnumber REGEXP '^.*18[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*18[0-9] .*$' THEN '180 Ancient Medieval and Oriental Philosophy'
WHEN i.itemcallnumber REGEXP '^.*19[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*19[0-9] .*$' THEN '190 Modern Western Philosophy'
WHEN i.itemcallnumber REGEXP '^.*20[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*20[0-9] .*$' THEN '200 Religion'
WHEN i.itemcallnumber REGEXP '^.*21[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*21[0-9] .*$' THEN '210 Natural Religion'
WHEN i.itemcallnumber REGEXP '^.*22[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*22[0-9] .*$' THEN '220 Bible'
WHEN i.itemcallnumber REGEXP '^.*23[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*23[0-9] .*$' THEN '230 Christian Theology'
WHEN i.itemcallnumber REGEXP '^.*24[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*24[0-9] .*$' THEN '240 Christian Moral Theology'
WHEN i.itemcallnumber REGEXP '^.*25[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*25[0-9] .*$' THEN '250 Local Church and Religious Orders'
WHEN i.itemcallnumber REGEXP '^.*26[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*26[0-9] .*$' THEN '260 Social and Ecclesiastical Theology'
WHEN i.itemcallnumber REGEXP '^.*27[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*27[0-9] .*$' THEN '270 History and Geography of Church'
WHEN i.itemcallnumber REGEXP '^.*28[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*28[0-9] .*$' THEN '280 Christian Denominations and Sects'
WHEN i.itemcallnumber REGEXP '^.*29[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*29[0-9] .*$' THEN '290 Nonchristian and Comparative Religion'
WHEN i.itemcallnumber REGEXP '^.*30[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*30[0-9] .*$' THEN '300 Social Sciences'
WHEN i.itemcallnumber REGEXP '^.*31[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*31[0-9] .*$' THEN '310 Statistics'
WHEN i.itemcallnumber REGEXP '^.*32[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*32[0-9] .*$' THEN '320 Political Science'
WHEN i.itemcallnumber REGEXP '^.*33[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*33[0-9] .*$' THEN '330 Economics'
WHEN i.itemcallnumber REGEXP '^.*34[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*34[0-9] .*$' THEN '340 Law'
WHEN i.itemcallnumber REGEXP '^.*35[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*35[0-9] .*$' THEN '350 Public Administration'
WHEN i.itemcallnumber REGEXP '^.*36[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*36[0-9] .*$' THEN '360 Social Concerns and Services'
WHEN i.itemcallnumber REGEXP '^.*37[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*37[0-9] .*$' THEN '370 Education'
WHEN i.itemcallnumber REGEXP '^.*38[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*38[0-9] .*$' THEN '380 Trade and Commerce'
WHEN i.itemcallnumber REGEXP '^.*39[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*39[0-9] .*$' THEN '390 Customs, Etiquette, Folklore'
WHEN i.itemcallnumber REGEXP '^.*40[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*40[0-9] .*$' THEN '400 Languages'
WHEN i.itemcallnumber REGEXP '^.*41[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*41[0-9] .*$' THEN '410 Linguistics'
WHEN i.itemcallnumber REGEXP '^.*42[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*42[0-9] .*$' THEN '420 English Language'
WHEN i.itemcallnumber REGEXP '^.*43[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*43[0-9] .*$' THEN '430 Germanic and Scandinavian Languages'
WHEN i.itemcallnumber REGEXP '^.*44[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*44[0-9] .*$' THEN '440 French'
WHEN i.itemcallnumber REGEXP '^.*45[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*45[0-9] .*$' THEN '450 Italian'
WHEN i.itemcallnumber REGEXP '^.*46[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*46[0-9] .*$' THEN '460 Spanish'
WHEN i.itemcallnumber REGEXP '^.*47[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*47[0-9] .*$' THEN '470 Latin'
WHEN i.itemcallnumber REGEXP '^.*48[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*48[0-9] .*$' THEN '480 Classical Greek'
WHEN i.itemcallnumber REGEXP '^.*49[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*49[0-9] .*$' THEN '490 Other Languages'
WHEN i.itemcallnumber REGEXP '^.*50[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*50[0-9] .*$' THEN '500 Pure Sciences'
WHEN i.itemcallnumber REGEXP '^.*51[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*51[0-9] .*$' THEN '510 Math'
WHEN i.itemcallnumber REGEXP '^.*52[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*52[0-9] .*$' THEN '520 Astronomy'
WHEN i.itemcallnumber REGEXP '^.*53[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*53[0-9] .*$' THEN '530 Physics'
WHEN i.itemcallnumber REGEXP '^.*54[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*54[0-9] .*$' THEN '540 Chemistry'
WHEN i.itemcallnumber REGEXP '^.*55[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*55[0-9] .*$' THEN '550 Earth Science'
WHEN i.itemcallnumber REGEXP '^.*56[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*56[0-9] .*$' THEN '560 Paleontology'
WHEN i.itemcallnumber REGEXP '^.*57[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*57[0-9] .*$' THEN '570 Life Sciences'
WHEN i.itemcallnumber REGEXP '^.*58[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*58[0-9] .*$' THEN '580 Botany'
WHEN i.itemcallnumber REGEXP '^.*59[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*59[0-9] .*$' THEN '590 Zoology'
WHEN i.itemcallnumber REGEXP '^.*60[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*60[0-9] .*$' THEN '600 Applied Sciences and Technology'
WHEN i.itemcallnumber REGEXP '^.*61[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*61[0-9] .*$' THEN '610 Medicine'
WHEN i.itemcallnumber REGEXP '^.*62[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*62[0-9] .*$' THEN '620 Engineering'
WHEN i.itemcallnumber REGEXP '^.*63[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*63[0-9] .*$' THEN '630 Agriculture'
WHEN i.itemcallnumber REGEXP '^.*64[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*64[0-9] .*$' THEN '640 Home Economics'
WHEN i.itemcallnumber REGEXP '^.*65[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*65[0-9] .*$' THEN '650 Management'
WHEN i.itemcallnumber REGEXP '^.*66[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*66[0-9] .*$' THEN '660 Chemical Technologies'
WHEN i.itemcallnumber REGEXP '^.*67[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*67[0-9] .*$' THEN '670 Manufacturing'
WHEN i.itemcallnumber REGEXP '^.*68[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*68[0-9] .*$' THEN '680 Application Specific Manufacturing'
WHEN i.itemcallnumber REGEXP '^.*69[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*69[0-9] .*$' THEN '690 Building'
WHEN i.itemcallnumber REGEXP '^.*70[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*70[0-9] .*$' THEN '700 Arts'
WHEN i.itemcallnumber REGEXP '^.*71[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*71[0-9] .*$' THEN '710 Civic and Landscape Art'
WHEN i.itemcallnumber REGEXP '^.*72[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*72[0-9] .*$' THEN '720 Architecture'
WHEN i.itemcallnumber REGEXP '^.*73[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*73[0-9] .*$' THEN '730 Sculpture'
WHEN i.itemcallnumber REGEXP '^.*74[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*74[0-9] .*$' THEN '740 Drawing'
WHEN i.itemcallnumber REGEXP '^.*75[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*75[0-9] .*$' THEN '750 Painting'
WHEN i.itemcallnumber REGEXP '^.*76[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*76[0-9] .*$' THEN '760 Graphic and Printed Art'
WHEN i.itemcallnumber REGEXP '^.*77[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*77[0-9] .*$' THEN '770 Photography'
WHEN i.itemcallnumber REGEXP '^.*78[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*78[0-9] .*$' THEN '780 Music'
WHEN i.itemcallnumber REGEXP '^.*79[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*79[0-9] .*$' THEN '790 Sports and Recreation'
WHEN i.itemcallnumber REGEXP '^.*80[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*80[0-9] .*$' THEN '800 Literature'
WHEN i.itemcallnumber REGEXP '^.*81[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*81[0-9] .*$' THEN '810 American Literature'
WHEN i.itemcallnumber REGEXP '^.*82[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*82[0-9] .*$' THEN '820 English Literature'
WHEN i.itemcallnumber REGEXP '^.*83[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*83[0-9] .*$' THEN '830 Germanic Literature'
WHEN i.itemcallnumber REGEXP '^.*84[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*84[0-9] .*$' THEN '840 French Literature'
WHEN i.itemcallnumber REGEXP '^.*85[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*85[0-9] .*$' THEN '850 Italian Literature'
WHEN i.itemcallnumber REGEXP '^.*86[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*86[0-9] .*$' THEN '860 Spanish and Portuguese Literature'
WHEN i.itemcallnumber REGEXP '^.*87[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*87[0-9] .*$' THEN '870 Latin Literature'
WHEN i.itemcallnumber REGEXP '^.*88[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*88[0-9] .*$' THEN '880 Classical Greek Literature'
WHEN i.itemcallnumber REGEXP '^.*89[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*89[0-9] .*$' THEN '890 Literature of Other Languages'
WHEN i.itemcallnumber REGEXP '^.*90[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*90[0-9] .*$' THEN '900 History and Geography'
WHEN i.itemcallnumber REGEXP '^.*91[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*91[0-9] .*$' THEN '910 Travel and Geography'
WHEN i.itemcallnumber REGEXP '^.*92[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*92[0-9] .*$' THEN '920 Genealogy and Geography'
WHEN i.itemcallnumber REGEXP '^.*93[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*93[0-9] .*$' THEN '930 Ancient History'
WHEN i.itemcallnumber REGEXP '^.*94[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*94[0-9] .*$' THEN '940 European History'
WHEN i.itemcallnumber REGEXP '^.*95[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*95[0-9] .*$' THEN '950 Asian History'
WHEN i.itemcallnumber REGEXP '^.*96[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*96[0-9] .*$' THEN '960 African History'
WHEN i.itemcallnumber REGEXP '^.*97[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*97[0-9] .*$' THEN '970 North American History'
WHEN i.itemcallnumber REGEXP '^.*98[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*98[0-9] .*$' THEN '980 South American History'
WHEN i.itemcallnumber REGEXP '^.*99[0-9]\..*$' OR i.itemcallnumber REGEXP '^.*99[0-9] .*$' THEN '990 History of Other Areas'
		ELSE 'all others'
	END dewey_number, location, COUNT(s.datetime) as total_circ, COUNT(DISTINCT s.itemnumber) as unique_circed
FROM items i LEFT OUTER JOIN statistics s USING(itemnumber)
WHERE month(s.datetime)=<<Choose Month|Month>> AND year(s.datetime)=<<Choose Year|Year>> AND s.type IN ('issue','renew') AND s.branch=<<choose your library|branches>>
GROUP BY dewey_number, location

























