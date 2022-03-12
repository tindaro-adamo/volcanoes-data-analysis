[Tableau Public dashboard](https://public.tableau.com/app/profile/tindaro/viz/Volcanoes_16318883532200/Volcanoesanderuptions?publish=yes)

## Credits 
Eruptions data up to 2020 is publicly available at
https://www.kaggle.com/martincontreras/volcanic-eruptions-dataset-all-to-2020

Volcanoes data ( up to 2021 ) is taken from https://volcano.si.edu/

Both datasets are publicly available thanks to the Global Volcanism Program, Smithsonian Institution
https://volcano.si.edu/
 
## How 

- Python with [Pandas](https://pandas.pydata.org/) is used for exploration and data cleaning.<br>
- [volcanoes_tableau_prep_sql.ipynb](https://github.com/tindaro-adamo/volcanoes-data-analysis/blob/main/python/volcanoes_tableau_prep_sql.ipynb) uses SQLite with Python to query the data. <br>
The result of those queries are exported to CSV files and used as data source for the Tableau Public visualisation.
