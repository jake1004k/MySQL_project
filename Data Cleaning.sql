# create a database

create database layoffs;
use layoffs;

# copy table

select*from raw_layoffs;
create table layoffs like raw_layoffs;
select*from layoffs;
insert layoffs 
select * from raw_layoffs;
select*from layoffs;

# Duplicates

with dup_rows as 
(
select *, row_number() over(
partition by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
) as row_num
from layoffs
)
select * from dup_rows where row_num >1;


CREATE TABLE `layoffs_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
alter table layoffs_2 add column row_num int;

insert into layoffs_2 
select *, row_number() over(
partition by company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
) as row_num
from layoffs;

select * from layoffs_2
where row_num >1;

set SQL_safe_updates=0;
delete from layoffs_2
where row_num >1;

select * from layoffs_2
where row_num >1;


# standardizing data

select company,trim(company)
from layoffs_2;

update layoffs_2
set company =trim(company);

select distinct(industry)
from layoffs_2
order by 1;

select *
from layoffs_2
where industry like 'Crypto%';

update layoffs_2
set industry='crypto'
where industry like 'crypto%';

select distinct(industry)
from layoffs_2
order by 1;

select distinct(location)
from layoffs_2
order by 1;

select distinct(country)
from layoffs_2
order by 1;

select country, trim(country)
from layoffs_2
group by country
order by 1;

update layoffs_2
set country='United States'
where country='United States.';

select distinct(country)
from layoffs_2
order by 1;

select `date`,str_to_date(`date`,'%m/%d/%Y') 
from layoffs_2;

update layoffs_2
set `date`=str_to_date(`date`,'%m/%d/%Y') ;

select `date`
from layoffs_2;

alter table layoffs_2
modify column `date` date;


# Null and Blank Values

select *
from layoffs_2
where industry is null 
or industry ='';

select t1.company,t1.industry,t2.industry 
from layoffs_2 t1
join layoffs_2 t2 
on t1.company =t2.company 
and t1.location = t2.location
where t1.industry is null or t1.industry=''
and t2.industry is not null 
order by t1.company;

update layoffs_2 t1
set industry = null
where industry ='';

update layoffs_2 t1
join layoffs_2 t2 
on t1.company =t2.company 
set t1.industry=t2.industry
where t1.industry is null 
and t2.industry is not null ;




select * 
from layoffs_2
where total_laid_off is null 
and percentage_laid_off is null;

delete 
from layoffs_2
where total_laid_off is null 
and percentage_laid_off is null;

select * 
from layoffs_2;

alter table layoffs_2 
drop column row_num;


# EDA

select * 
from layoffs_2
where total_laid_off= 
(select max(total_laid_off) from layoffs_2);

# Google has highest number of layoffs in the entire dataset with 12000 laid off 

select * 
from layoffs_2
where percentage_laid_off= 
(select max(percentage_laid_off) from layoffs_2);

# many company like Ahead,airlift ,airy rooms have seems to shut-down as their laidoff is 100%

select company , sum(total_laid_off)
from layoffs_2
group by company
order by 2 desc;
# as seen Amazon has highest number of laidoff follwed by Google and mets

select min(`date`),max(`date`)
from layoffs_2;
# the dataset ranges from 2020-03-11 to 2023-03-06

select industry , sum(total_laid_off)
from layoffs_2
group by industry
order by 2 desc;
# most laidoffs have been happened in consumer and retail sector

select country , sum(total_laid_off)
from layoffs_2
group by country
order by 2 desc;
# United States have laid the mostlayoffs with 256559,followed by India with 35993

select year(`date`) , sum(total_laid_off)
from layoffs_2
group by year(`date`)
order by 2 desc;
# highest laidoff is in 2022 follwed by 2023, considering only 3 months data in 2023 it very high 

