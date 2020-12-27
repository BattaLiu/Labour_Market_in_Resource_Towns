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
lead, nickel, zinc. It also gives crude oil, gas and coal price. They are shown in [this figure](new commodity price-1.png). Combining prices with the grades of mines, I calculate the unit price of ore for mines with only a subset of those 7 metals. A sample of constructed mine price is show in [this figure](figure-1.png) and their [annual price changes](mine_price_change.png).
3. Census of Canada 1971-2011: labour force activities (can derive regional employment)
, wage and salaries, age, sex, schooling, occupation, industry (Metal mines,
Coal mines, Non-metal mines(except coal), Crude petroleum and natural gas industries)...Full list of census variables useed in research is in [this excel file](chosen-variable-from-cencus-20181102.xlsx). 
4. Natural Resources Canada: Minerals and Mining Map. This map provides the
information on principal operating mines and metallurgic works. 
5. mindat.org: coordinates of mines. This website gives a location-19**.Rmd files combine the [match.Rmd](match.Rmd) and [mindat-scraping.R](mindat-scraping.R) to locate the mines. Used files: NRC 900a map, GAF81-GAF06, boundary files of 2006. It generate an excel file with CSD info for mines at its best. 
### Cleaning of geographic data
One big challenge in this research is how to make the mines in different years comparable. Though the mine location don't change, their corresponding [CSD]s(https://www150.statcan.gc.ca/n1/pub/92-195-x/2011001/geo/csd-sdr/def-eng.htm) change through these years. My solution is to find out the relative documents and figure out whether two CSDs in sequential census years are comparable.
## [Regression 1](regression1.do)
## [Regression 2](regression3-v2.do)
## [Regression 3](regression3-v3.do)

