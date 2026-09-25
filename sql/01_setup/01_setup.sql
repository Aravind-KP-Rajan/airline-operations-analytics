-- Create the project database.
CREATE DATABASE IF NOT EXISTS AIRLINE_DB;

-- Keep source data, cleaned data, and reporting models separate.
CREATE SCHEMA IF NOT EXISTS AIRLINE_DB.RAW;
CREATE SCHEMA IF NOT EXISTS AIRLINE_DB.STAGING;
CREATE SCHEMA IF NOT EXISTS AIRLINE_DB.ANALYTICS;

-- Supply compute for loads and queries while limiting idle usage.
CREATE WAREHOUSE IF NOT EXISTS AIRLINE_WH
    WAREHOUSE_SIZE = XSMALL
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE;

-- Check the warehouse settings after creation.
SHOW WAREHOUSES LIKE 'AIRLINE_WH';
