# Online-Retail-Cohort-Analysis-SQL-Tableau

## Overview:
In this project, we conduct a detailed online retail cohort analysis using data from the source [Online Retail Dataset](https://archive.ics.uci.edu/dataset/352/online+retail), aiming to prepare the data for creating a dashboard in Tableau. This is a transnational dataset set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.The project closely aligns with responsibilities in the current position, where similar analyses are performed to derive insights for strategic decision-making.

## Analysis:
The project begins with data cleaning, assessing the total number of records, and identifying null values, specifically focusing on records without a CustomerID. A series of Common Table Expressions (CTEs) are employed to filter and clean the dataset, removing records with Quantity and Unit Price greater than 0 and addressing duplicates.

The clean dataset, stored in a temporary table (#online_retail_clean), becomes the foundation for subsequent analyses. The focus shifts to cohort analysis, starting with extracting essential information such as CustomerID, the first invoice date, and cohort dates. This information is stored in another temporary table (#cohort).

The retention analysis involves calculating the cohort index, representing the number of months since the customer's first purchase. Subqueries and joins are used to compute this index, and the results are stored in a temporary table (#cohort_retention). The project then proceeds to create a cohort table, pivoting the data to understand the retention rates over different time intervals.

To visualize the cohort analysis effectively, the project generates a pivot table (#cohort_pivot) and calculates cohort rates as percentages, providing valuable insights into customer retention trends. The final output is structured to facilitate easy integration with Tableau for creating a cohesive and informative dashboard.

Throughout the project, the skills applied include data cleaning, working with CTEs, utilizing subqueries, and employing pivoting techniques. The end goal of preparing the data for Tableau aligns with the practical application of these skills in real-world scenarios, reflecting the day-to-day tasks involved in generating actionable insights for the sales team.

## Links:
### Online Retail Dataset
[Dataset: Online Retail Data](https://github.com/FranciscoLoncq/Online-Retail-Cohort-Analysis-SQL-Tableau/blob/main/online%2Bretail%20(2).zip)

### Cohort Analysis SQL Query
[SQL Analysis Query](https://github.com/FranciscoLoncq/Online-Retail-Cohort-Analysis-SQL-Tableau/blob/main/Online%20Retail%20Queries.sql)

### Tableau
[Cohort Analysis Dashboard](https://public.tableau.com/app/profile/francisco.loncq/viz/OnlineRetailCohortDashboard/CohortRetentionTables)

### Credits
Angelina Frimpong
