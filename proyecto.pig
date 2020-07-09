raw_data = LOAD 'hdfs://cm:9000/uhadoop2020/pbelmonte/new-data.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage('\t', 'NO_MULTILINE', 'UNIX', 'SKIP_INPUT_HEADER') AS (EXT1: int,EXT2: int,EXT3: int,EXT4: int,EXT5: int,EXT6: int,EXT7: int,EXT8: int,EXT9: int,EXT10: int,EST1: int,EST2: int,EST3: int,EST4: int,EST5: int,EST6: int,EST7: int,EST8: int,EST9: int,EST10: int,AGR1: int,AGR2: int,AGR3: int,AGR4: int,AGR5: int,AGR6: int,AGR7: int,AGR8: int,AGR9: int,AGR10: int,CSN1: int,CSN2: int,CSN3: int,CSN4: int,CSN5: int,CSN6: int,CSN7: int,CSN8: int,CSN9: int,CSN10: int,OPN1: int,OPN2: int,OPN3: int,OPN4: int,OPN5: int,OPN6: int,OPN7: int,OPN8: int,OPN9: int,OPN10: int,EXT1_E: int,EXT2_E: int,EXT3_E: int,EXT4_E: int,EXT5_E: int,EXT6_E: int,EXT7_E: int,EXT8_E: int,EXT9_E: int,EXT10_E: int,EST1_E: int,EST2_E: int,EST3_E: int,EST4_E: int,EST5_E: int,EST6_E: int,EST7_E: int,EST8_E: int,EST9_E: int,EST10_E: int,AGR1_E: int,AGR2_E: int,AGR3_E: int,AGR4_E: int,AGR5_E: int,AGR6_E: int,AGR7_E: int,AGR8_E: int,AGR9_E: int,AGR10_E: int,CSN1_E: int,CSN2_E: int,CSN3_E: int,CSN4_E: int,CSN5_E: int,CSN6_E: int,CSN7_E: int,CSN8_E: int,CSN9_E: int,CSN10_E: int,OPN1_E: int,OPN2_E: int,OPN3_E: int,OPN4_E: int,OPN5_E: int,OPN6_E: int,OPN7_E: int,OPN8_E: int,OPN9_E: int,OPN10_E: int,dateloaded: bytearray,screenw: int,screenh: int,introelapse: int,testelapse: int,endelapse: int,IPC: int,country: chararray,lat_appx_lots_of_err: double,long_appx_lots_of_err: double);

filtered = FILTER raw_data BY IPC == 1 AND country != 'NONE';

group_country = GROUP filtered BY country;

count_by_country = FOREACH group_country GENERATE group as country, SUM(filtered.IPC) as cnt;

countries = FILTER count_by_country BY cnt > 1000l;

prom_person = FOREACH filtered GENERATE country, (EXT1_E + EXT2_E + EXT3_E + EXT4_E + EXT5_E + EXT6_E + EXT7_E + EXT8_E + EXT9_E + EXT10_E) / 10.0 AS EXT_E_PROM, (EST1_E + EST2_E + EST3_E + EST4_E + EST5_E + EST6_E + EST7_E + EST8_E + EST9_E + EST10_E) / 10.0 AS EST_E_PROM, (AGR1_E + AGR2_E + AGR3_E + AGR4_E + AGR5_E + AGR6_E + AGR7_E + AGR8_E + AGR9_E + AGR10_E) / 10.0 AS AGR_E_PROM, (CSN1_E + CSN2_E + CSN3_E + CSN4_E + CSN5_E + CSN6_E + CSN7_E + CSN8_E + CSN9_E + CSN10_E) / 10.0 AS CSN_E_PROM, (OPN1_E + OPN2_E + OPN3_E + OPN4_E + OPN5_E + OPN6_E + OPN7_E + OPN8_E + OPN9_E + OPN10_E) / 10.0 AS OPN_E_PROM;

group_prom_country = GROUP prom_person BY country;

prom_e_country = FOREACH group_prom_country GENERATE group as country, AVG(prom_person.EXT_E_PROM) AS EXT_E_PROM, AVG(prom_person.EST_E_PROM) AS EST_E_PROM, AVG(prom_person.AGR_E_PROM) AS AGR_E_PROM, AVG(prom_person.CSN_E_PROM) AS CSN_E_PROM, AVG(prom_person.OPN_E_PROM) AS OPN_E_PROM;

joined = JOIN countries BY country LEFT OUTER, prom_e_country BY country;

order_by_ext = ORDER joined BY prom_e_country::EXT_E_PROM ASC;
order_by_est = ORDER joined BY prom_e_country::EST_E_PROM ASC;
order_by_agr = ORDER joined BY prom_e_country::AGR_E_PROM ASC;
order_by_csn = ORDER joined BY prom_e_country::CSN_E_PROM ASC;
order_by_opn = ORDER joined BY prom_e_country::OPN_E_PROM ASC;