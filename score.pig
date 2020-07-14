-- Get data
raw_data = LOAD 'hdfs://cm:9000/uhadoop2020/pbelmonte/new-data.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage('\t', 'NO_MULTILINE', 'UNIX', 'SKIP_INPUT_HEADER') AS (EXT1: int,EXT2: int,EXT3: int,EXT4: int,EXT5: int,EXT6: int,EXT7: int,EXT8: int,EXT9: int,EXT10: int,EST1: int,EST2: int,EST3: int,EST4: int,EST5: int,EST6: int,EST7: int,EST8: int,EST9: int,EST10: int,AGR1: int,AGR2: int,AGR3: int,AGR4: int,AGR5: int,AGR6: int,AGR7: int,AGR8: int,AGR9: int,AGR10: int,CSN1: int,CSN2: int,CSN3: int,CSN4: int,CSN5: int,CSN6: int,CSN7: int,CSN8: int,CSN9: int,CSN10: int,OPN1: int,OPN2: int,OPN3: int,OPN4: int,OPN5: int,OPN6: int,OPN7: int,OPN8: int,OPN9: int,OPN10: int,EXT1_E: int,EXT2_E: int,EXT3_E: int,EXT4_E: int,EXT5_E: int,EXT6_E: int,EXT7_E: int,EXT8_E: int,EXT9_E: int,EXT10_E: int,EST1_E: int,EST2_E: int,EST3_E: int,EST4_E: int,EST5_E: int,EST6_E: int,EST7_E: int,EST8_E: int,EST9_E: int,EST10_E: int,AGR1_E: int,AGR2_E: int,AGR3_E: int,AGR4_E: int,AGR5_E: int,AGR6_E: int,AGR7_E: int,AGR8_E: int,AGR9_E: int,AGR10_E: int,CSN1_E: int,CSN2_E: int,CSN3_E: int,CSN4_E: int,CSN5_E: int,CSN6_E: int,CSN7_E: int,CSN8_E: int,CSN9_E: int,CSN10_E: int,OPN1_E: int,OPN2_E: int,OPN3_E: int,OPN4_E: int,OPN5_E: int,OPN6_E: int,OPN7_E: int,OPN8_E: int,OPN9_E: int,OPN10_E: int,dateloaded: bytearray,screenw: int,screenh: int,introelapse: int,testelapse: int,endelapse: int,IPC: int,country: chararray,lat_appx_lots_of_err: double,long_appx_lots_of_err: double);

-- Filter by one response per IP and valid country
filtered = FILTER raw_data BY IPC == 1 AND country != 'NONE';

-- Group by country
group_country = GROUP filtered BY country;

-- Get number of answers for each country
count_by_country = FOREACH group_country GENERATE group as country, SUM(filtered.IPC) as cnt;

-- Keep only the countries with more than 1000 answers
countries = FILTER count_by_country BY cnt > 1000l;

-- Get average score for each category for each person
prom_person = FOREACH filtered GENERATE country, (20 + EXT1 - EXT2 + EXT3 - EXT4 + EXT5 - EXT6 + EXT7 - EXT8 + EXT9 - EXT10) / 10.0 + 1.0 AS EXT_PROM, (38 - EST1 + EST2 - EST3 + EST4 - EST5 - EST6 - EST7 - EST8 - EST9 - EST10) / 10.0 + 1.0 AS EST_PROM, (14 - AGR1 + AGR2 - AGR3 + AGR4 - AGR5 + AGR6 - AGR7 + AGR8 + AGR9 + AGR10) / 10.0 + 1.0 AS AGR_PROM, (14 + CSN1 - CSN2 + CSN3 - CSN4 + CSN5 - CSN6 + CSN7 - CSN8 + CSN9 + CSN10) / 10.0 + 1.0 AS CSN_PROM, (8 + OPN1 - OPN2 + OPN3 - OPN4 + OPN5 - OPN6 + OPN7 + OPN8 + OPN9 + OPN10) / 10.0 AS OPN_PROM;

-- Group by country
group_prom_country = GROUP prom_person BY country;
/ 10.0 + 1
-- Get average score for each category for each country
prom_country = FOREACH group_prom_country GENERATE group as country, AVG(prom_person.EXT_PROM) AS EXT_PROM, AVG(prom_person.EST_PROM) AS EST_PROM, AVG(prom_person.AGR_PROM) AS AGR_PROM, AVG(prom_person.CSN_PROM) AS CSN_PROM, AVG(prom_person.OPN_PROM) AS OPN_PROM;

-- Join to get averages for countries with more than 1000 answers
joined = JOIN countries BY country LEFT OUTER, prom_country BY country;

-- Order by each category
order_by_ext = ORDER joined BY prom_country::EXT_PROM ASC;
order_by_est = ORDER joined BY prom_country::EST_PROM ASC;
order_by_agr = ORDER joined BY prom_country::AGR_PROM ASC;
order_by_csn = ORDER joined BY prom_country::CSN_PROM ASC;
order_by_opn = ORDER joined BY prom_country::OPN_PROM ASC;

-- Store
STORE order_by_ext INTO '/uhadoop2020/pbelmonte/results/score/order_by_ext/';
STORE order_by_est INTO '/uhadoop2020/pbelmonte/results/score/order_by_est/';
STORE order_by_agr INTO '/uhadoop2020/pbelmonte/results/score/order_by_agr/';
STORE order_by_csn INTO '/uhadoop2020/pbelmonte/results/score/order_by_csn/';
STORE order_by_opn INTO '/uhadoop2020/pbelmonte/results/score/order_by_opn/';