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
Date last run: 2025-05-13 09:33:15

----------

Public: 0
Expiry: 0

----------

Circulation of Dewey numbers (grouped by Dewey numbers and location) during a set month at your library (items from any collection). From the dropdown menus, choose month, year, and your library. 

----------
*/



SELECT 
	CASE
WHEN i.itemcallnumber REGEXP '^.&ast;00[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;01[0-9] .&ast;$' THEN '000 Generalities'
WHEN i.itemcallnumber REGEXP '^.&ast;01[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;01[0-9] .&ast;$' THEN '010 Bibliographies'
WHEN i.itemcallnumber REGEXP '^.&ast;02[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;02[0-9] .&ast;$' THEN '020 Library and Information Science'
WHEN i.itemcallnumber REGEXP '^.&ast;03[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;03[0-9] .&ast;$' THEN '030 General Encyclopedias'
WHEN i.itemcallnumber REGEXP '^.&ast;04[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;04[0-9] .&ast;$' THEN '040 Not used'
WHEN i.itemcallnumber REGEXP '^.&ast;05[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;05[0-9] .&ast;$' THEN '050 General Periodicals'
WHEN i.itemcallnumber REGEXP '^.&ast;06[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;06[0-9] .&ast;$' THEN '060 General Organizations and Museums'
WHEN i.itemcallnumber REGEXP '^.&ast;07[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;07[0-9] .&ast;$' THEN '070 Journalism and Publishing'
WHEN i.itemcallnumber REGEXP '^.&ast;08[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;08[0-9] .&ast;$' THEN '080 Collections'
WHEN i.itemcallnumber REGEXP '^.&ast;09[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;09[0-9] .&ast;$' THEN '090 Manuscripts and Rare Books'
WHEN i.itemcallnumber REGEXP '^.&ast;10[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;10[0-9] .&ast;$' THEN '100 Philosophy'
WHEN i.itemcallnumber REGEXP '^.&ast;11[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;11[0-9] .&ast;$' THEN '110 Metaphysics'
WHEN i.itemcallnumber REGEXP '^.&ast;12[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;12[0-9] .&ast;$' THEN '120 Epistemology'
WHEN i.itemcallnumber REGEXP '^.&ast;13[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;13[0-9] .&ast;$' THEN '130 Paranormal Phenomena and Occult'
WHEN i.itemcallnumber REGEXP '^.&ast;14[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;14[0-9] .&ast;$' THEN '140 Specific Philosophies'
WHEN i.itemcallnumber REGEXP '^.&ast;15[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;15[0-9] .&ast;$' THEN '150 Psychology'
WHEN i.itemcallnumber REGEXP '^.&ast;16[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;16[0-9] .&ast;$' THEN '160 Logic'
WHEN i.itemcallnumber REGEXP '^.&ast;17[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;17[0-9] .&ast;$' THEN '170 Ethics'
WHEN i.itemcallnumber REGEXP '^.&ast;18[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;18[0-9] .&ast;$' THEN '180 Ancient Medieval and Oriental Philosophy'
WHEN i.itemcallnumber REGEXP '^.&ast;19[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;19[0-9] .&ast;$' THEN '190 Modern Western Philosophy'
WHEN i.itemcallnumber REGEXP '^.&ast;20[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;20[0-9] .&ast;$' THEN '200 Religion'
WHEN i.itemcallnumber REGEXP '^.&ast;21[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;21[0-9] .&ast;$' THEN '210 Natural Religion'
WHEN i.itemcallnumber REGEXP '^.&ast;22[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;22[0-9] .&ast;$' THEN '220 Bible'
WHEN i.itemcallnumber REGEXP '^.&ast;23[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;23[0-9] .&ast;$' THEN '230 Christian Theology'
WHEN i.itemcallnumber REGEXP '^.&ast;24[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;24[0-9] .&ast;$' THEN '240 Christian Moral Theology'
WHEN i.itemcallnumber REGEXP '^.&ast;25[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;25[0-9] .&ast;$' THEN '250 Local Church and Religious Orders'
WHEN i.itemcallnumber REGEXP '^.&ast;26[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;26[0-9] .&ast;$' THEN '260 Social and Ecclesiastical Theology'
WHEN i.itemcallnumber REGEXP '^.&ast;27[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;27[0-9] .&ast;$' THEN '270 History and Geography of Church'
WHEN i.itemcallnumber REGEXP '^.&ast;28[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;28[0-9] .&ast;$' THEN '280 Christian Denominations and Sects'
WHEN i.itemcallnumber REGEXP '^.&ast;29[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;29[0-9] .&ast;$' THEN '290 Nonchristian and Comparative Religion'
WHEN i.itemcallnumber REGEXP '^.&ast;30[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;30[0-9] .&ast;$' THEN '300 Social Sciences'
WHEN i.itemcallnumber REGEXP '^.&ast;31[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;31[0-9] .&ast;$' THEN '310 Statistics'
WHEN i.itemcallnumber REGEXP '^.&ast;32[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;32[0-9] .&ast;$' THEN '320 Political Science'
WHEN i.itemcallnumber REGEXP '^.&ast;33[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;33[0-9] .&ast;$' THEN '330 Economics'
WHEN i.itemcallnumber REGEXP '^.&ast;34[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;34[0-9] .&ast;$' THEN '340 Law'
WHEN i.itemcallnumber REGEXP '^.&ast;35[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;35[0-9] .&ast;$' THEN '350 Public Administration'
WHEN i.itemcallnumber REGEXP '^.&ast;36[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;36[0-9] .&ast;$' THEN '360 Social Concerns and Services'
WHEN i.itemcallnumber REGEXP '^.&ast;37[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;37[0-9] .&ast;$' THEN '370 Education'
WHEN i.itemcallnumber REGEXP '^.&ast;38[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;38[0-9] .&ast;$' THEN '380 Trade and Commerce'
WHEN i.itemcallnumber REGEXP '^.&ast;39[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;39[0-9] .&ast;$' THEN '390 Customs, Etiquette, Folklore'
WHEN i.itemcallnumber REGEXP '^.&ast;40[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;40[0-9] .&ast;$' THEN '400 Languages'
WHEN i.itemcallnumber REGEXP '^.&ast;41[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;41[0-9] .&ast;$' THEN '410 Linguistics'
WHEN i.itemcallnumber REGEXP '^.&ast;42[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;42[0-9] .&ast;$' THEN '420 English Language'
WHEN i.itemcallnumber REGEXP '^.&ast;43[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;43[0-9] .&ast;$' THEN '430 Germanic and Scandinavian Languages'
WHEN i.itemcallnumber REGEXP '^.&ast;44[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;44[0-9] .&ast;$' THEN '440 French'
WHEN i.itemcallnumber REGEXP '^.&ast;45[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;45[0-9] .&ast;$' THEN '450 Italian'
WHEN i.itemcallnumber REGEXP '^.&ast;46[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;46[0-9] .&ast;$' THEN '460 Spanish'
WHEN i.itemcallnumber REGEXP '^.&ast;47[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;47[0-9] .&ast;$' THEN '470 Latin'
WHEN i.itemcallnumber REGEXP '^.&ast;48[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;48[0-9] .&ast;$' THEN '480 Classical Greek'
WHEN i.itemcallnumber REGEXP '^.&ast;49[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;49[0-9] .&ast;$' THEN '490 Other Languages'
WHEN i.itemcallnumber REGEXP '^.&ast;50[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;50[0-9] .&ast;$' THEN '500 Pure Sciences'
WHEN i.itemcallnumber REGEXP '^.&ast;51[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;51[0-9] .&ast;$' THEN '510 Math'
WHEN i.itemcallnumber REGEXP '^.&ast;52[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;52[0-9] .&ast;$' THEN '520 Astronomy'
WHEN i.itemcallnumber REGEXP '^.&ast;53[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;53[0-9] .&ast;$' THEN '530 Physics'
WHEN i.itemcallnumber REGEXP '^.&ast;54[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;54[0-9] .&ast;$' THEN '540 Chemistry'
WHEN i.itemcallnumber REGEXP '^.&ast;55[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;55[0-9] .&ast;$' THEN '550 Earth Science'
WHEN i.itemcallnumber REGEXP '^.&ast;56[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;56[0-9] .&ast;$' THEN '560 Paleontology'
WHEN i.itemcallnumber REGEXP '^.&ast;57[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;57[0-9] .&ast;$' THEN '570 Life Sciences'
WHEN i.itemcallnumber REGEXP '^.&ast;58[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;58[0-9] .&ast;$' THEN '580 Botany'
WHEN i.itemcallnumber REGEXP '^.&ast;59[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;59[0-9] .&ast;$' THEN '590 Zoology'
WHEN i.itemcallnumber REGEXP '^.&ast;60[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;60[0-9] .&ast;$' THEN '600 Applied Sciences and Technology'
WHEN i.itemcallnumber REGEXP '^.&ast;61[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;61[0-9] .&ast;$' THEN '610 Medicine'
WHEN i.itemcallnumber REGEXP '^.&ast;62[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;62[0-9] .&ast;$' THEN '620 Engineering'
WHEN i.itemcallnumber REGEXP '^.&ast;63[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;63[0-9] .&ast;$' THEN '630 Agriculture'
WHEN i.itemcallnumber REGEXP '^.&ast;64[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;64[0-9] .&ast;$' THEN '640 Home Economics'
WHEN i.itemcallnumber REGEXP '^.&ast;65[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;65[0-9] .&ast;$' THEN '650 Management'
WHEN i.itemcallnumber REGEXP '^.&ast;66[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;66[0-9] .&ast;$' THEN '660 Chemical Technologies'
WHEN i.itemcallnumber REGEXP '^.&ast;67[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;67[0-9] .&ast;$' THEN '670 Manufacturing'
WHEN i.itemcallnumber REGEXP '^.&ast;68[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;68[0-9] .&ast;$' THEN '680 Application Specific Manufacturing'
WHEN i.itemcallnumber REGEXP '^.&ast;69[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;69[0-9] .&ast;$' THEN '690 Building'
WHEN i.itemcallnumber REGEXP '^.&ast;70[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;70[0-9] .&ast;$' THEN '700 Arts'
WHEN i.itemcallnumber REGEXP '^.&ast;71[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;71[0-9] .&ast;$' THEN '710 Civic and Landscape Art'
WHEN i.itemcallnumber REGEXP '^.&ast;72[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;72[0-9] .&ast;$' THEN '720 Architecture'
WHEN i.itemcallnumber REGEXP '^.&ast;73[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;73[0-9] .&ast;$' THEN '730 Sculpture'
WHEN i.itemcallnumber REGEXP '^.&ast;74[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;74[0-9] .&ast;$' THEN '740 Drawing'
WHEN i.itemcallnumber REGEXP '^.&ast;75[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;75[0-9] .&ast;$' THEN '750 Painting'
WHEN i.itemcallnumber REGEXP '^.&ast;76[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;76[0-9] .&ast;$' THEN '760 Graphic and Printed Art'
WHEN i.itemcallnumber REGEXP '^.&ast;77[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;77[0-9] .&ast;$' THEN '770 Photography'
WHEN i.itemcallnumber REGEXP '^.&ast;78[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;78[0-9] .&ast;$' THEN '780 Music'
WHEN i.itemcallnumber REGEXP '^.&ast;79[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;79[0-9] .&ast;$' THEN '790 Sports and Recreation'
WHEN i.itemcallnumber REGEXP '^.&ast;80[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;80[0-9] .&ast;$' THEN '800 Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;81[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;81[0-9] .&ast;$' THEN '810 American Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;82[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;82[0-9] .&ast;$' THEN '820 English Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;83[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;83[0-9] .&ast;$' THEN '830 Germanic Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;84[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;84[0-9] .&ast;$' THEN '840 French Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;85[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;85[0-9] .&ast;$' THEN '850 Italian Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;86[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;86[0-9] .&ast;$' THEN '860 Spanish and Portuguese Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;87[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;87[0-9] .&ast;$' THEN '870 Latin Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;88[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;88[0-9] .&ast;$' THEN '880 Classical Greek Literature'
WHEN i.itemcallnumber REGEXP '^.&ast;89[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;89[0-9] .&ast;$' THEN '890 Literature of Other Languages'
WHEN i.itemcallnumber REGEXP '^.&ast;90[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;90[0-9] .&ast;$' THEN '900 History and Geography'
WHEN i.itemcallnumber REGEXP '^.&ast;91[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;91[0-9] .&ast;$' THEN '910 Travel and Geography'
WHEN i.itemcallnumber REGEXP '^.&ast;92[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;92[0-9] .&ast;$' THEN '920 Genealogy and Geography'
WHEN i.itemcallnumber REGEXP '^.&ast;93[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;93[0-9] .&ast;$' THEN '930 Ancient History'
WHEN i.itemcallnumber REGEXP '^.&ast;94[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;94[0-9] .&ast;$' THEN '940 European History'
WHEN i.itemcallnumber REGEXP '^.&ast;95[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;95[0-9] .&ast;$' THEN '950 Asian History'
WHEN i.itemcallnumber REGEXP '^.&ast;96[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;96[0-9] .&ast;$' THEN '960 African History'
WHEN i.itemcallnumber REGEXP '^.&ast;97[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;97[0-9] .&ast;$' THEN '970 North American History'
WHEN i.itemcallnumber REGEXP '^.&ast;98[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;98[0-9] .&ast;$' THEN '980 South American History'
WHEN i.itemcallnumber REGEXP '^.&ast;99[0-9]\..&ast;$' OR i.itemcallnumber REGEXP '^.&ast;99[0-9] .&ast;$' THEN '990 History of Other Areas'
		ELSE 'all others'
	END dewey_number, location, COUNT(s.datetime) as total_circ, COUNT(DISTINCT s.itemnumber) as unique_circed
FROM items i LEFT OUTER JOIN statistics s USING(itemnumber)
WHERE month(s.datetime)=&lt;&gt; AND year(s.datetime)=&lt;&gt; AND s.type IN ('issue','renew') AND s.branch=&lt;&gt;
GROUP BY dewey_number, location

























