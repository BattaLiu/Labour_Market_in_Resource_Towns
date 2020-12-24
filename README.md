# Labour_Market_in_Resource_Towns
## Motivation and Model
Resource towns in this project are the small isolated communities built around resourcebased
industries which are greatly affected by commodity prices. Among Canadian resource towns, quite a few of them are one-company towns, which
are characterised by the presence of a large employer in a local labour market. In this thesis, I propose to study several aspects of the economy in Canadian resource
towns. 
## Data Sources and Data Cleaning
1. Canadian Mines Handbook (1935-2003)/ Canadian & American mines handbook
(2005-2015) This handbook is published by Northern Miner Press and it provides
lots of information on producing mines in Canada. e.g. produced commodities,
geocode, capacity and operating rate, ownership. This data requires manual data input, all the data is in excel files.
2. World bank provides annual prices of 7 principal metals: silver, gold, iron, copper,
lead, nickel, zinc. It also gives crude oil, gas and coal price. They are shown in Figure
1 (Lead, Zinc, Silver, Gold, Copper, Nickel, Aluminium have national production
record in Cansim) Combining prices with the grades of mines, I calculate the unit
price of ore for mines with only a subset of those 7 metals.
3. Census of Canada 1971-2011: labour force activities (can derive regional employment)
, wage and salaries, age, sex, schooling, occupation, industry (Metal mines,
Coal mines, Non-metal mines(except coal), Crude petroleum and natural gas industries)...Full list of census variables useed in research is in [chosen-variable-from-cencus-20181102.xlsx](chosen-variable-from-cencus-20181102.xlsx). 
4. Natural Resources Canada: Minerals and Mining Map. This map provides the
information on principal operating mines and metallurgic works. 
5. mindat.org: coordinates of mines. This website gives a location-19**.Rmd files combine the [match.Rmd](match.Rmd) and [mindat-scraping.R](mindat-scraping.R) to locate the mines. Used files: NRC 900a map, GAF81-GAF06, boundary files of 2006. It generate an excel file with CSD info for mines at its best. 
## [Regression 1](regression1.do)
## [Regression 2](regression3-v2.do)
## [Regression 3](regression3-v3.do)

