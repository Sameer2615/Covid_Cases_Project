GLobal Covid_19,2020-2021 Data Analysis using Tableau and Sql

![Covid-19](https://github.com/Sameer2615/Covid_Cases_Project/blob/main/covid-19.avif)
 This project explores COVID-19 data through Excel, SQL, and Tableau to reveal meaningful insights that go beyond raw numbers. It emphasizes the pandemic's effects on people's lives and evaluates the effectiveness of vaccination efforts.


## Tableau Dashboard LINK: 


[Dashboard](https://public.tableau.com/app/profile/sameer.bhatt3239/viz/GlobalCovidCases2020-2021/Dashboard1)

## Description

 The dataset contains records of Covid-19 cases, deaths and vaccine records by country in 2020-2021. This project includes the following steps: data loading, data cleaning and preprocessing and EDA (exploratory data analysis).
 
# Analyzing COVID-19 Data: Insights with Excel, SQL, and Tableau

In a challenging era, technology and public health convergence take center stage. In this data analytics project, we delve into COVID-19 data using practical tools such as Excel, SQL, and Tableau. Our dataset includes information about COVID-19 deaths, vaccination rates, and related metrics. It highlights the pandemic's impact on lives and vaccination efficacy. 


To import Excel tables into a new database in SQl Pgadmin4 follow these step-by-step instructions: 

1.    Open SQL Pgamdin4: Launch pgadmin4 and connect to your SQL Server instance if you haven't already.
  
2.    Create a New Database: If you haven't already created the "Covid_Project" database, you can do so by right-clicking on "Databases" in the Object Explorer and selecting "New Database." Name it "Covid_project" and click "OK" to create the new database.
    
3.    Prepare Your Excel File: Make sure your Excel file (e.g., "covid_vaccines.xlsx" and "covid_deaths.xlsx") is well-structured with clear column names. Save it in a SQL Server.
  
4.    Import Excel Tables
   
    a. In pgadmin4, right-click on your "Covid_project" database in the Object Explorer, select "table," and then choose "Import Data."
  
    b. The SQL pgadmin4 will open. Click "Next" to begin.
  
    c. Choose a Data Source:
  
        •    Select "Microsoft Excel" as the data source.
    
        •    Click "Browse" to locate your Excel file (e.g., "covid_vaccines.xlsx").
    
        •    Choose the appropriate version of Excel (Excel 97-2003 or Excel 2007 or later).
    
        •    Click "Next."

      
    e. Specify Table Copy or Query:
  
        •    Choose "Copy data from one or more tables or views" and click "Next."
    
    f. Select Source Tables and Views:
  
        •    Choose the Excel worksheet (table) you want to import (e.g., "covid_vaccines$").
    
        •    Click "Next."
    
    g. Review Mapping:
  
        •    Confirm that the columns from your Excel table are correctly mapped to the columns in your SQL table.
      
        •    Click "Next."
    
    h. Specify Table Copy Options:
    
        •    Choose whether to run the package immediately or save it as an SSIS package.
    
        •    Click "Next."
    
    i. Complete the Wizard:
  
        •    Review your selections and click "Finish" to start the import process.
    
     j. The Wizard will execute the package and import the Excel data into your "SQL project 1 Covid" database.
  
5.    Repeat for Other Excel Table: Follow the same process to import the other Excel table (e.g., "covid_deaths.xlsx") into the same database.
   
  
6.    Verify Data: Once both tables are imported, you can verify the data by querying them in pgadmin4

   
That's it! You have successfully imported Excel tables into your "Covid_project" database in SQL Server Management Studio.
