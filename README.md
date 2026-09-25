# Airline Operations Analytics

Flight-level analysis of U.S. domestic airline operations using real 2024
Reporting Carrier On-Time Performance data from the U.S. Bureau of
Transportation Statistics (BTS).

## Project status

- Snowflake database: `AIRLINE_DB`
- Warehouse: `AIRLINE_WH` (X-Small; auto-suspend after 60 seconds)
- Schemas: `RAW`, `STAGING`, `ANALYTICS`
- RAW table: `AIRLINE_DB.RAW.BTS_ONTIME_2024`
- Loaded and date-validated RAW records: **7,079,081** across January–December 2024
- STAGING transformations, star schema, Power BI report and insights: planned

## Planned data flow

BTS monthly CSV downloads → Snowflake RAW → STAGING → ANALYTICS →
Power BI → three-page operations report

## Planned report pages

1. Operations Overview
2. Airline, Airport & Route Performance
3. Delay & Disruption Analysis

## Data source

U.S. Department of Transportation, Bureau of Transportation Statistics:
[Reporting Carrier On-Time Performance](https://www.transtats.bts.gov/).
This project uses reporting operating-carrier data for U.S. domestic flights,
not synthetic flight records. See [data documentation](data/README.md)
for the download method, scope and limitations.

## Repository policy

Original BTS ZIP/CSV downloads and Snowflake credentials are not committed.
SQL scripts, methods, definitions and report documentation are versioned here.
