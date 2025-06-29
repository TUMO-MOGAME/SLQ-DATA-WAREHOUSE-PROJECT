/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

USE bronze;

IF OBJECT_ID ('bronze.crm_cust_info','u') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
    cst_key nvarchar(50),
    cst_firstname nvarchar(50),
    cst_lastname nvarchar(50),
    cst_marital_status nvarchar(50),
    cst_gndr nvarchar(50),
    cst_create_date date
);

IF OBJECT_ID ('bronze.crm_prd_info','u') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id int,
    prd_key nvarchar(50),
    prd_nm nvarchar(50),
    prd_cost int,
    prd_line nvarchar(50),
    prd_start_dt datetime,
    prd_end_dt datetime
);

IF OBJECT_ID ('bronze.crm_sales_details','u') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num nvarchar(50),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt int,
    sls_ship_dt int,
    sls_due_dt int,
    sls_sales int,
    sls_quantity int,
    sls_price int
);


IF OBJECT_ID ('bronze.crm_cust_info','u') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.erp_cust_az12(
	cid nvarchar(50),
    bdate date,
    gen nvarchar(50)
);


IF OBJECT_ID ('bronze.erp_loc_a101','u') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101(
	cid nvarchar(50),
	cntry nvarchar(50)
);


IF OBJECT_ID ('bronze.erp_px_cat_g1v2','u') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2(
	id nvarchar(50),
    cat nvarchar(50),
	subcat nvarchar(50),
	maintenance nvarchar(50)
);

SHOW VARIABLES LIKE 'secure_file_priv';

# BULK INSERT bronze.crm_cust_info i wanted the null values to be uploaded as well the data should be as it is 
# MySQL Stored Procedure Syntax
#❌ Why This Happens
#In MySQL, LOAD DATA INFILE is not allowed inside stored procedures
# so i had to skip the stored procedures 


truncate table bronze.crm_cust_info;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@cst_id, @cst_key, @cst_firstname, @cst_lastname, @cst_marital_status, @cst_gndr, @cst_create_date)
SET
  cst_id = NULLIF(@cst_id, ''),
  cst_key = NULLIF(@cst_key, ''),
  cst_firstname = NULLIF(@cst_firstname, ''),
  cst_lastname = NULLIF(@cst_lastname, ''),
  cst_marital_status = NULLIF(@cst_marital_status, ''),
  cst_gndr = NULLIF(@cst_gndr, ''),
  cst_create_date = NULLIF(@cst_create_date, '');
  
select * from crm_cust_info limit 30;
  
truncate table bronze.crm_prd_info;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@prd_id, @prd_key, @prd_nm, @prd_cost, @prd_line, @prd_start_dt, @prd_end_dt)
SET
  prd_id       = NULLIF(@prd_id, ''),
  prd_key      = NULLIF(@prd_key, ''),
  prd_nm       = NULLIF(@prd_nm, ''),
  prd_cost     = NULLIF(@prd_cost, ''),
  prd_line     = NULLIF(@prd_line, ''),
  prd_start_dt = NULLIF(@prd_start_dt, ''),
  prd_end_dt   = NULLIF(@prd_end_dt, '');
  
select * from bronze.crm_prd_info limit 30;


truncate table bronze.crm_sales_details;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@sls_ord_num, @sls_prd_key, @sls_cust_id, @sls_order_dt, @sls_ship_dt, @sls_due_dt, @sls_sales, @sls_quantity, @sls_price)
SET
  sls_ord_num   = NULLIF(@sls_ord_num, ''),
  sls_prd_key   = NULLIF(@sls_prd_key, ''),
  sls_cust_id   = NULLIF(@sls_cust_id, ''),
  sls_order_dt  = NULLIF(@sls_order_dt, ''),
  sls_ship_dt   = NULLIF(@sls_ship_dt, ''),
  sls_due_dt    = NULLIF(@sls_due_dt, ''),
  sls_sales     = NULLIF(@sls_sales, ''),
  sls_quantity  = NULLIF(@sls_quantity, ''),
  sls_price     = NULLIF(@sls_price, '');
  
select * from crm_sales_details limit 30;


truncate table bronze.erp_cust_az12;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@CID, @BDATE, @GEN)
SET
  cid   = NULLIF(@CID, ''),
  bdate = NULLIF(@BDATE, ''),
  gen   = NULLIF(@GEN, '');
  
select * from erp_cust_az12 limit 30;


truncate table bronze.erp_loc_a101;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@CID, @CNTRY)
SET
  cid   = NULLIF(@CID, ''),
  cntry = NULLIF(@CNTRY, '');
  
select * from erp_loc_a101 limit 30;


truncate table bronze.erp_px_cat_g1v2;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@ID, @CAT, @SUBCAT, @MAINTENANCE)
SET
  id          = NULLIF(@ID, ''),
  cat         = NULLIF(@CAT, ''),
  subcat      = NULLIF(@SUBCAT, ''),
  maintenance = NULLIF(@MAINTENANCE, '');
  
select * from erp_px_cat_g1v2 limit 30;
