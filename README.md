# Layoffs Data Cleaning and Analysis Project

This project involves cleaning and analyzing a dataset of layoffs to extract meaningful insights.

## Data Cleaning Steps

1. **Duplicate Removal:** Identified and removed duplicate entries from the dataset to ensure data integrity.

2. **Handling Null Values:**
   - Identified columns with null values and decided on appropriate strategies to handle them.
   - For columns where null values were not critical (e.g., `industry`), nulls were either filled or dropped based on the context.
   - For critical columns like `total_laid_off` and `percentage_laid_off`, null values were handled carefully, considering their impact on the analysis.

3. **Standardizing Data:**
   - Ensured consistency in data format (e.g., standardized date formats) to facilitate analysis.
   - Standardized textual data (e.g., company names) to remove unnecessary spaces or characters.

4. **Handling Blank Values:**
   - Identified columns with blank values and determined whether these blanks should be considered null or if there were specific reasons for them.
   - Blank values were either filled or marked appropriately based on the context.

5. **Data Transformation:**
   - Transformed data where necessary to ensure consistency and accuracy (e.g., converting textual data to lowercase for uniformity).

6. **Data Validation:**
   - Checked the data for any anomalies or inconsistencies after cleaning to ensure the quality of the dataset.

## Exploratory Data Analysis (EDA)

1. **Company with Highest Layoffs:** Identified the company with the highest number of layoffs in the entire dataset.
2. **Shutdown Analysis:** Noted companies with a 100% layoff rate, indicating possible shutdowns.
3. **Industry Analysis:** Analyzed the distribution of layoffs across industries to identify sectors most affected by layoffs.
4. **Country Analysis:** Examined the distribution of layoffs by country to understand the geographical impact.
5. **Trend Analysis:** Studied the trend of layoffs over the years to identify any patterns or changes over time.

## Conclusion

The cleaned dataset provides a reliable foundation for further analysis, with meaningful insights extracted through exploratory data analysis.

