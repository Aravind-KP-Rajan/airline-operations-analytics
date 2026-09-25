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
- STAGING flight table: complete; star schema, Power BI report and insights: planned

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


## STAGING transformation

`AIRLINE_DB.STAGING.FLIGHTS_CLEAN` retains the RAW columns and adds a typed
`FLIGHT_DATE` plus standardized carrier, origin and destination codes.
The RAW `FL_DATE` remains available for source comparison. Snowflake had
already inferred delay minutes and status flags as numeric, so they were
not converted again.

Validation found 7,079,081 STAGING rows, zero missing converted flight
dates, and a date range of 2024-01-01 through 2024-12-31. No carrier or
airport code values changed during trimming and uppercasing.

Of these flights, 6,965,267 were neither cancelled nor diverted and have
arrival-delay values. Another 96,315 were cancelled and 17,499 diverted;
those groups have no regular arrival-delay value. The planned arrival OTP
denominator is operated, non-diverted flights. Cancellation and diversion
will be reported separately.

See `sql/03_staging/01_flights_clean.sql` for the SQL and validation checks.
