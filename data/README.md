# Data source and provenance

## Official source

- Publisher: U.S. Department of Transportation, Bureau of Transportation
  Statistics (BTS), TranStats
- Dataset: Reporting Carrier On-Time Performance (1987-present)
- Download page:
  https://www.transtats.bts.gov/DL_SelectFields.aspx?QO_fu146_anzr=b0-gvzr&gnoyr_VQ=FGJ
- Project selection: individual flight records for each month of 2024,
  all/default geography, reporting operating carriers
- Download format: BTS-generated ZIP archives containing CSV files

## Local source files

Twelve monthly ZIP downloads are retained locally as the original source.
Their extracted CSV copies were uploaded to Snowflake. ZIP/CSV files are
excluded from this Git repository because of their size.

The first BTS download was generated on 2026-09-24. Exact retrieval
timestamps, original archive names, file sizes and checksums for all
12 months should be recorded in a source manifest before the project
is finalized.

## Snowflake ingestion

- Destination: `AIRLINE_DB.RAW.BTS_ONTIME_2024`
- Method: Snowsight local CSV upload; January created the table and
  February–December were appended to the existing table.
- Loaded records: 7,079,081
- Validation: all 12 months of 2024 present; parsed flight dates range
  from 2024-01-01 through 2024-12-31; zero unparseable flight dates.
- Candidate flight key check found zero repeated keys using date,
  reporting carrier, flight number, origin, destination and scheduled
  departure time.

## Scope and limitations

These are reported U.S. domestic nonstop operating-carrier flights.
The data does not represent every flight worldwide or any Indian airline.
Carrier reporting coverage and definitions should be considered when
comparing airlines. Delay-cause columns contain reported minutes in
broad categories; they do not identify one exclusive cause per flight.
A tail number is available, but aircraft model is not established by
this selected dataset.

No individual flight records are included in this repository.
