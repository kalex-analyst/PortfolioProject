SQL Project Overview: Covid19Data_Exploration

This project focuses on analyzing the COVID-19 dataset from Our World in Data using MySQL Workbench. The dataset, originally in Excel format, was converted into a CSV file and imported into MySQL for exploration and analysis.
Key Objectives
•	Analyze infection and death rates across different countries and continents.
•	Compare total cases vs. population to determine infection spread.
•	Identify countries with the highest infection and death rates.
•	Use window functions (e.g., SUM OVER PARTITION BY) to track cumulative vaccinations.
•	Implement Common Table Expressions (CTEs) and Views for better query efficiency and future visualizations.

Key Techniques Used

✔ Aggregations (SUM(), MAX(), AVG())
✔ Joins (INNER JOIN between COVID deaths and vaccination tables)
✔ Window Functions (SUM() OVER(PARTITION BY)) for cumulative calculations
✔ Common Table Expressions (CTEs) for structured queries
✔ Views to store results for visualization tools
By leveraging SQL, this project uncovers critical insights about COVID-19 trends, infection rates, and vaccination progress on both a country and global scale.
