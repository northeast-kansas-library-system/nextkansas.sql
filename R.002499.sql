/*
R.002499

----------

Name: Call Number Monthly Circ Report for Basehor items, checked out anywhere
Created by: Heather Braum

----------

Group: Library-Specific
     Basehor

Created on: 2015-05-15 16:43:16
Modified on: 2015-05-26 10:27:13
Date last run: -

----------

Public: 0
Expiry: 0

----------

Returns total circ for any given month, based on call number breakdown (Basehor items checked out anywhere). You'll need to plug in the month (ex. 02) and year (ex. 2015) for the month you want to look at circulations; you'll also need to plug in that month's last day (ex. 2015-04-30) so the report only looks at items added through that month. 

<b><a href="https://staff.nexpresslibrary.org/cgi-bin/koha/reports/guided_reports.pl?reports=2500&phase=Run%20this%20report" target="_blank">Run report #2500</a></b> to get total items for this grouping of call numbers.

----------
*/

SELECT 
	CASE
		WHEN itemcallnumber LIKE 'F %' THEN '001 Adult Fiction (F %)'
		WHEN itemcallnumber LIKE '0%' THEN '002 Adult Nonfiction 000s (0%)'
		WHEN itemcallnumber LIKE '1%' THEN '003 Adult Nonfiction 100s (1%)'
		WHEN itemcallnumber LIKE '2%' THEN '004 Adult Nonfiction 200s (2%)'
		WHEN itemcallnumber LIKE '3%' THEN '005 Adult Nonfiction 300s (3%)'
		WHEN itemcallnumber LIKE '4%' THEN '006 Adult Nonfiction 400s (4%)'
		WHEN itemcallnumber LIKE '5%' THEN '007 Adult Nonfiction 500s (5%)'
		WHEN itemcallnumber LIKE '6%' THEN '008 Adult Nonfiction 600s (6%)'
		WHEN itemcallnumber LIKE '7%' THEN '009 Adult Nonfiction 700s (7%)'
		WHEN itemcallnumber LIKE '8%' THEN '010 Adult Nonfiction 800s (8%)'
		WHEN itemcallnumber LIKE '9%'  THEN '011 Adult Nonfiction 900s (9%)'
		WHEN itemcallnumber LIKE 'B%' THEN '012 Adult Biography (B%)'
		WHEN itemcallnumber LIKE 'LP F%' THEN '013 Adult Large Print Fiction (LP F%)'
		WHEN itemcallnumber LIKE 'GN F%' THEN '014 Adult Graphic Novel Fiction (GN F%)'
		WHEN itemcallnumber LIKE 'GN 0%' THEN '015 Adult Graphic Novel Nonfiction 000s (GN 0%)'
		WHEN itemcallnumber LIKE 'GN 1%' THEN '016 Adult Graphic Novel Nonfiction 100s (GN 1%)'
		WHEN itemcallnumber LIKE 'GN 2%' THEN '017 Adult Graphic Novel Nonfiction 200s (GN 2%)'
		WHEN itemcallnumber LIKE 'GN 3%' THEN '018 Adult Graphic Novel Nonfiction 300s (GN 3%)'
		WHEN itemcallnumber LIKE 'GN 4%' THEN '019 Adult Graphic Novel Nonfiction 400s (GN 4%)'
		WHEN itemcallnumber LIKE 'GN 5%' THEN '020 Adult Graphic Novel Nonfiction 500s (GN 5%)'
		WHEN itemcallnumber LIKE 'GN 6%' THEN '021 Adult Graphic Novel Nonfiction 600s (GN 6%)'
		WHEN itemcallnumber LIKE 'GN 7%' THEN '022 Adult Graphic Novel Nonfiction 700s (GN 7%)'
		WHEN itemcallnumber LIKE 'GN 8%' THEN '023 Adult Graphic Novel Nonfiction 800s (GN 8%)'
		WHEN itemcallnumber LIKE 'GN 9%' THEN '024 Adult Graphic Novel Nonfiction 900s (GN 9%)'
		WHEN itemcallnumber LIKE 'pbk %' THEN '025 Adult Paperbacks (pbk %)'
		WHEN itemcallnumber LIKE 'CDF %' THEN '026 Adult CD Fiction (CDF %)'
		WHEN itemcallnumber LIKE 'CD0%' THEN '027 Adult CD Nonfiction 000s (CD0%)'
		WHEN itemcallnumber LIKE 'CD1%' THEN '028 Adult CD Nonfiction 100s (CD1%)'
		WHEN itemcallnumber LIKE 'CD2%' THEN '029 Adult CD Nonfiction 200s (CD2%)'
		WHEN itemcallnumber LIKE 'CD3%' THEN '030 Adult CD Nonfiction 300s (CD3%)'
		WHEN itemcallnumber LIKE 'CD4%' THEN '031 Adult CD Nonfiction 400s (CD4%)'
		WHEN itemcallnumber LIKE 'CD5%' THEN '032 Adult CD Nonfiction 500s (CD5%)'
		WHEN itemcallnumber LIKE 'CD6%' THEN '033 Adult CD Nonfiction 600s (CD6%)'
		WHEN itemcallnumber LIKE 'CD7%' THEN '034 Adult CD Nonfiction 700s (CD7%)'
		WHEN itemcallnumber LIKE 'CD8%' THEN '035 Adult CD Nonfiction 800s (CD8%)'
		WHEN itemcallnumber LIKE 'CD9%' THEN '036 Adult CD Nonfiction 900s (CD9%)'
		WHEN itemcallnumber LIKE 'CD BIO %' THEN '037 Adult CD Biography (CD BIO %)'
		WHEN itemcallnumber LIKE 'DV0%' THEN '038 Adult DVD Nonfiction 000s (DV0%)'
		WHEN itemcallnumber LIKE 'DV1%' THEN '039 Adult DVD Nonfiction 100s (DV1%)'
		WHEN itemcallnumber LIKE 'DV2%' THEN '040 Adult DVD Nonfiction 200s (DV2%)'
		WHEN itemcallnumber LIKE 'DV3%' THEN '041 Adult DVD Nonfiction 300s (DV3%)'
		WHEN itemcallnumber LIKE 'DV4%' THEN '042 Adult DVD Nonfiction 400s (DV4%)'
		WHEN itemcallnumber LIKE 'DV5%' THEN '043 Adult DVD Nonfiction 500s (DV5%)'
		WHEN itemcallnumber LIKE 'DV6%' THEN '044 Adult DVD Nonfiction 600s (DV6%)'
		WHEN itemcallnumber LIKE 'DV7%' THEN '045 Adult DVD Nonfiction 700s (DV7%)'
		WHEN itemcallnumber LIKE 'DV8%' THEN '046 Adult DVD Nonfiction 800s (DV8%)'
		WHEN itemcallnumber LIKE 'DV9%' THEN '047 Adult DVD Nonfiction 900s (DV9%)'
		WHEN itemcallnumber LIKE 'DVBIO%' THEN '048 Adult DVD Biography (DVBIO%)'
		WHEN itemcallnumber LIKE 'DVF%' THEN '049 Adult DVD Fiction (DVF%)'
		WHEN itemcallnumber LIKE 'EB %' THEN '050 Board Books (EB %)'
		WHEN itemcallnumber LIKE 'E %' AND itemcallnumber NOT LIKE 'E KIT %' THEN '051 Easy Fiction (E %)'
		WHEN itemcallnumber LIKE 'E0%' THEN '052 Easy Nonfiction 000s (E0%)'
		WHEN itemcallnumber LIKE 'E1%' THEN '053 Easy Nonfiction 100s (E1%)'
		WHEN itemcallnumber LIKE 'E2%' THEN '054 Easy Nonfiction 200s (E2%)'
		WHEN itemcallnumber LIKE 'E3%' THEN '055 Easy Nonfiction 300s (E3%)'
		WHEN itemcallnumber LIKE 'E4%' THEN '056 Easy Nonfiction 400s (E4%)'
		WHEN itemcallnumber LIKE 'E5%' THEN '057 Easy Nonfiction 500s (E5%)'
		WHEN itemcallnumber LIKE 'E6%' THEN '058 Easy Nonfiction 600s (E6%)'
		WHEN itemcallnumber LIKE 'E7%' THEN '059 Easy Nonfiction 700s (E7%)'
		WHEN itemcallnumber LIKE 'E8%' THEN '060 Easy Nonfiction 800s (E8%)'
		WHEN itemcallnumber LIKE 'E9%' THEN '061 Easy Nonfiction 900s (E9%)'
		WHEN itemcallnumber LIKE 'EBIO %' THEN '062 Easy Biography (EBIO %)'
		WHEN itemcallnumber LIKE 'ER %' THEN '063 Easy Reader Fiction (ER %)'
		WHEN itemcallnumber LIKE 'ER0%' THEN '064 Easy Reader Nonfiction 000s (ER0%)'
		WHEN itemcallnumber LIKE 'ER1%' THEN '065 Easy Reader Nonfiction 100s (ER1%)'
		WHEN itemcallnumber LIKE 'ER2%' THEN '066 Easy Reader Nonfiction 200s (ER2%)'
		WHEN itemcallnumber LIKE 'ER3%' THEN '067 Easy Reader Nonfiction 300s (ER3%)'
		WHEN itemcallnumber LIKE 'ER4%' THEN '068 Easy Reader Nonfiction 400s (ER4%)'
		WHEN itemcallnumber LIKE 'ER5%' THEN '069 Easy Reader Nonfiction 500s (ER5%)'
		WHEN itemcallnumber LIKE 'ER6%' THEN '070 Easy Reader Nonfiction 600s (ER6%)'
		WHEN itemcallnumber LIKE 'ER7%' THEN '071 Easy Reader Nonfiction 700s (ER7%)'
		WHEN itemcallnumber LIKE 'ER8%' THEN '072 Easy Reader Nonfiction 800s (ER8%)'
		WHEN itemcallnumber LIKE 'ER9%' THEN '073 Easy Reader Nonfiction 900s (ER9%)'
		WHEN itemcallnumber LIKE 'ERBIO %' THEN '074 Easy Reader Biography (ERBIO %)'
		WHEN itemcallnumber LIKE 'JF %' THEN '075 Juvenile Fiction (JF %)'
		WHEN itemcallnumber LIKE 'J0%' THEN '076 Juvenile Nonfiction 000s (J0%)'
		WHEN itemcallnumber LIKE 'J1%' THEN '077 Juvenile Nonfiction 100s (J1%)'
		WHEN itemcallnumber LIKE 'J2%' THEN '078 Juvenile Nonfiction 200s (J2%)'
		WHEN itemcallnumber LIKE 'J3%' THEN '079 Juvenile Nonfiction 300s (J3%)'
		WHEN itemcallnumber LIKE 'J4%' THEN '080 Juvenile Nonfiction 400s (J4%)'
		WHEN itemcallnumber LIKE 'J5%' THEN '081 Juvenile Nonfiction 500s (J5%)'
		WHEN itemcallnumber LIKE 'J6%' THEN '082 Juvenile Nonfiction 600s (J6%)'
		WHEN itemcallnumber LIKE 'J7%' THEN '083 Juvenile Nonfiction 700s (J7%)'
		WHEN itemcallnumber LIKE 'J8%' THEN '084 Juvenile Nonfiction 800s (J8%)'
		WHEN itemcallnumber LIKE 'J9%' THEN '085 Juvenile Nonfiction 900s (J9%)'
		WHEN itemcallnumber LIKE 'JBIO %' THEN '086 Juvenile Biography (JBIO %)'
		WHEN itemcallnumber LIKE 'JGN %' THEN '087 Juvenile Graphic Novel Fiction (JGN %)'
		WHEN itemcallnumber LIKE 'JGN0%' THEN '088 Juvenile Graphic Novel Nonfiction 000s (JGN0%)'
		WHEN itemcallnumber LIKE 'JGN1%' THEN '089 Juvenile Graphic Novel Nonfiction 100s (JGN1%)'
		WHEN itemcallnumber LIKE 'JGN2%' THEN '090 Juvenile Graphic Novel Nonfiction 200s (JGN2%)'
		WHEN itemcallnumber LIKE 'JGN3%' THEN '091 Juvenile Graphic Novel Nonfiction 300s (JGN3%)'
		WHEN itemcallnumber LIKE 'JGN4%' THEN '092 Juvenile Graphic Novel Nonfiction 400s (JGN4%)'
		WHEN itemcallnumber LIKE 'JGN5%' THEN '093 Juvenile Graphic Novel Nonfiction 500s (JGN5%)'
		WHEN itemcallnumber LIKE 'JGN6%' THEN '094 Juvenile Graphic Novel Nonfiction 600s (JGN6%)'
		WHEN itemcallnumber LIKE 'JGN7%' THEN '095 Juvenile Graphic Novel Nonfiction 700s (JGN7%)'
		WHEN itemcallnumber LIKE 'JGN8%' THEN '096 Juvenile Graphic Novel Nonfiction 800s (JGN8%)'
		WHEN itemcallnumber LIKE 'JGN9%' THEN '097 Juvenile Graphic Novel Nonfiction 900s (JGN9%)'
		WHEN itemcallnumber LIKE 'DVJ %' THEN '098 Juvenile Fiction DVDs (DVJ %)'
		WHEN itemcallnumber LIKE 'DJ0%' THEN '099 Juvenile Nonfiction DVD 000s (DJ0%)'
		WHEN itemcallnumber LIKE 'DJ1%' THEN '100 Juvenile Nonfiction DVD 100s (DJ1%)'
		WHEN itemcallnumber LIKE 'DJ2%' THEN '101 Juvenile Nonfiction DVD 200s (DJ2%)'
		WHEN itemcallnumber LIKE 'DJ3%' THEN '102 Juvenile Nonfiction DVD 300s (DJ3%)'
		WHEN itemcallnumber LIKE 'DJ4%' THEN '103 Juvenile Nonfiction DVD 400s (DJ4%)'
		WHEN itemcallnumber LIKE 'DJ5%' THEN '104 Juvenile Nonfiction DVD 500s (DJ5%)'
		WHEN itemcallnumber LIKE 'DJ6%' THEN '105 Juvenile Nonfiction DVD 600s (DJ6%)'
		WHEN itemcallnumber LIKE 'DJ7%' THEN '106 Juvenile Nonfiction DVD 700s (DJ7%)'
		WHEN itemcallnumber LIKE 'DJ8%' THEN '107 Juvenile Nonfiction DVD 800s (DJ8%)'
		WHEN itemcallnumber LIKE 'DJ9%' THEN '108 Juvenile Nonfiction DVD 900s (DJ9%)'
		WHEN itemcallnumber LIKE 'E KIT %' THEN '109 Easy Kits (E KIT %)'
		WHEN itemcallnumber LIKE 'CDE %' THEN '110 Easy Audiobooks (CDE %)'
		WHEN itemcallnumber LIKE 'CDJ %' AND itemcallnumber NOT LIKE 'CDJ MUSIC%' THEN '111 Juvenile Fiction Audiobooks (CDJ %)'
		WHEN itemcallnumber LIKE 'CDJ0%' THEN '112 Juvenile Nonfiction Audiobooks 000s (CDJ0%)'
		WHEN itemcallnumber LIKE 'CDJ1%' THEN '113 Juvenile Nonfiction Audiobooks 100s (CDJ1%)'
		WHEN itemcallnumber LIKE 'CDJ2%' THEN '114 Juvenile Nonfiction Audiobooks 200s (CDJ2%)'
		WHEN itemcallnumber LIKE 'CDJ3%' THEN '115 Juvenile Nonfiction Audiobooks 300s (CDJ3%)'
		WHEN itemcallnumber LIKE 'CDJ4%' THEN '116 Juvenile Nonfiction Audiobooks 400s (CDJ4%)'
		WHEN itemcallnumber LIKE 'CDJ5%' THEN '117 Juvenile Nonfiction Audiobooks 500s (CDJ5%)'
		WHEN itemcallnumber LIKE 'CDJ6%' THEN '118 Juvenile Nonfiction Audiobooks 600s (CDJ6%)'
		WHEN itemcallnumber LIKE 'CDJ7%' THEN '119 Juvenile Nonfiction Audiobooks 700s (CDJ7%)'
		WHEN itemcallnumber LIKE 'CDJ8%' THEN '120 Juvenile Nonfiction Audiobooks 800s (CDJ8%)'
		WHEN itemcallnumber LIKE 'CDJ9%' THEN '121 Juvenile Nonfiction Audiobooks 900s (CDJ9%)'
		WHEN itemcallnumber LIKE 'CDJ MUSIC%' THEN '122 Juvenile Music (CDJ MUSIC%)'
		WHEN itemcallnumber LIKE 'VGJ PS%' THEN '123 Juvenile PlayStation Videogames (VGJ PS%)'
		WHEN itemcallnumber LIKE 'VGJ Wii %' THEN '124 Juvenile Wii Videogames (VGJ Wii %)'
		WHEN itemcallnumber LIKE 'VGJ XB%' THEN '125 Juvenile XBox Videogames (VGJ XB%)'
		WHEN itemcallnumber LIKE 'YF %' THEN '126 Young Adult Fiction (YF %)'
		WHEN itemcallnumber LIKE 'Y0%' THEN '127 Young Adult Nonfiction 000s (Y0%)'
		WHEN itemcallnumber LIKE 'Y1%' THEN '128 Young Adult Nonfiction 100s (Y1%)'
		WHEN itemcallnumber LIKE 'Y2%' THEN '129 Young Adult Nonfiction 200s (Y2%)'
		WHEN itemcallnumber LIKE 'Y3%' THEN '130 Young Adult Nonfiction 300s (Y3%)'
		WHEN itemcallnumber LIKE 'Y4%' THEN '131 Young Adult Nonfiction 400s (Y4%)'
		WHEN itemcallnumber LIKE 'Y5%' THEN '132 Young Adult Nonfiction 500s (Y5%)'
		WHEN itemcallnumber LIKE 'Y6%' THEN '133 Young Adult Nonfiction 600s (Y6%)'
		WHEN itemcallnumber LIKE 'Y7%' THEN '134 Young Adult Nonfiction 700s (Y7%)'
		WHEN itemcallnumber LIKE 'Y8%' THEN '135 Young Adult Nonfiction 800s (Y8%)'
		WHEN itemcallnumber LIKE 'Y9%' THEN '136 Young Adult Nonfiction 900s (Y9%)'
		WHEN itemcallnumber LIKE 'YBIO %' THEN '137 Young Adult Biography (YBIO %)'
		WHEN itemcallnumber LIKE 'LP YF %' THEN '138 Young Adult Large Print (LP YF %)'
		WHEN itemcallnumber LIKE 'YGN %' THEN '139 Young Adult Graphic Novel Fiction (YGN %)'
		WHEN itemcallnumber LIKE 'YGN0%' THEN '140 Young Adult Graphic Nonfiction 000s (YGN0%)'
		WHEN itemcallnumber LIKE 'YGN1%' THEN '141 Young Adult Graphic Nonfiction 100s (YGN1%)'
		WHEN itemcallnumber LIKE 'YGN2%' THEN '142 Young Adult Graphic Nonfiction 200s (YGN2%)'
		WHEN itemcallnumber LIKE 'YGN3%' THEN '143 Young Adult Graphic Nonfiction 300s (YGN3%)'
		WHEN itemcallnumber LIKE 'YGN4%' THEN '144 Young Adult Graphic Nonfiction 400s (YGN4%)'
		WHEN itemcallnumber LIKE 'YGN5%' THEN '145 Young Adult Graphic Nonfiction 500s (YGN5%)'
		WHEN itemcallnumber LIKE 'YGN6%' THEN '146 Young Adult Graphic Nonfiction 600s (YGN6%)'
		WHEN itemcallnumber LIKE 'YGN7%' THEN '147 Young Adult Graphic Nonfiction 700s (YGN7%)'
		WHEN itemcallnumber LIKE 'YGN8%' THEN '148 Young Adult Graphic Nonfiction 800s (YGN8%)'
		WHEN itemcallnumber LIKE 'YGN9%' THEN '149 Young Adult Graphic Nonfiction 900s (YGN9%)'
		WHEN itemcallnumber LIKE 'CDY %' THEN '150 Young Adult Audiobooks (CDY %)'
		WHEN itemcallnumber LIKE 'CSY %' THEN '151 Young Adult Computer Software (CSY %)'
		WHEN itemcallnumber LIKE 'VGY PS%' THEN '152 Young Adult PlayStation Videogames (VGY PS%)'
		WHEN itemcallnumber LIKE 'VGY Wii %' THEN '153 Young Adult Wii Videogames (VGY Wii %)'
		WHEN itemcallnumber LIKE 'VGY XB%' THEN '154 Young Adult XBox Videogames (VGY XB%)'
		ELSE '155 Miscellaneous callnumbers'
	END "groups", COUNT(s.datetime) as total_circ, COUNT(DISTINCT s.itemnumber) as unique_circed
FROM items i LEFT OUTER JOIN statistics s USING(itemnumber)
WHERE i.homebranch='BASEHOR' AND month(s.datetime)=<<enter two-digit month, like 05 for May>> AND year(s.datetime)=<<enter four-digit year, like 2015>> AND s.type IN ('issue','renew') AND i.dateaccessioned <= <<enter last date of month you're counting stats on, like 2015-04-30>>
GROUP BY groups LIMIT 400



