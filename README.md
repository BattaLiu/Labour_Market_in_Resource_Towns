# Labour_Market_in_Resource_Towns
## Motivation and Model
Resource towns in this project are the small isolated communities built around resource-based
industries which are greatly affected by commodity prices. Among Canadian resource towns, quite a few of them are one-company towns, which
are characterised by the presence of a large employer in a local labour market. In this thesis, I propose to study several aspects of the economy in Canadian resource
towns. 
## Data Sources and Data Cleaning
1. *Canadian Mines Handbook* (1935-2003)/ *Canadian & American mines handbook*
(2005-2015) This handbook is published by Northern Miner Press and it provides
lots of information on producing mines in Canada. e.g. produced commodities,
geocode, capacity and operating rate, ownership. This data requires manual data input, all the data is in excel files.
2. **World bank** provides annual prices of 7 principal metals: silver, gold, iron, copper,
lead, nickel, zinc. It also gives crude oil, gas and coal price. They are shown in [this figure](new commodity price-1.png). Combining prices with the grades of mines, I calculate the unit price of ore for mines with only a subset of those 7 metals. A sample of constructed mine price is show in [this figure](figure-1.png) and their [annual price changes](mine_price_change.png).
3. **Census of Canada** 1971-2011: labour force activities (can derive regional employment)
, wage and salaries, age, sex, schooling, occupation, industry (Metal mines,
Coal mines, Non-metal mines(except coal), Crude petroleum and natural gas industries)...Full list of census variables useed in research is in [this excel file](chosen-variable-from-cencus-20181102.xlsx). [Boundary files](https://www.library.mcgill.ca/StatCan/geogfiles/census2006/canadafiles/index.html) also play an important role in this research.
4. **Natural Resources Canada**: Minerals and Mining Map (NRC map 900a). This map provides the
information on principal operating mines and metallurgic works. 
5. **mindat.org**: coordinates of mines. This website gives a location-19**.Rmd files combine the [match.Rmd](match.Rmd) and [mindat-scraping.R](mindat-scraping.R) to locate the mines. Used files: NRC 900a map, GAF81-GAF06, boundary files of 2006. It generate an excel file with CSD info for mines at its best. 
6. [**Geographic Attribut File**](https://www12.statcan.gc.ca/census-recensement/2011/geo/ref/att-eng.cfm) (GAF): contains geographic data at the dissemination block level. The file includes population and dwelling counts, land area, geographic codes, names, unique identifiers and, where applicable, types. Recent census year data can be achieved easily but older years data are stored in some specific libraries. 
### Cleaning of geographic data
One big challenge in this research is to match the mining locations with census data collection area, [CSD](https://www150.statcan.gc.ca/n1/pub/92-195-x/2011001/geo/csd-sdr/def-eng.htm). GAF of different census years provide 7-digit standard CSD code, province name, and CSD name for matching with mine location info from NRC map 900a. If some mines are still unmatched, coordinate data of mines scrapped from mindat.org and boundary files of Census are used to improve matching rate.
Another challenge is to make sure the mines in different years comparable. Though the mine location don't change, their corresponding CSDs change through these years. My solution has three steps: 
1) Findout the smallest census data collection area, [*EA*/*DA*](http://mchp-appserv.cpe.umanitoba.ca/viewDefinition.php?printer=Y&definitionID=102632), in a CSD .
2) If the CSDs are unchanged or just renamed, that's good as it is still comparable between two census years. If a CSD is split, we can combine it again. But if a CSD loses and get some EAs at the same change, we need to figure out whether this CSD is still a valid observation. 
## [Regression 1](regression1.do)
## [Regression 2](regression3-v2.do)
## [Regression 3](regression3-v3.do)

