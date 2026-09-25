# Analytics model

## Grain

`FACT_FLIGHTS` contains one row per BTS reported flight in 2024,
including cancelled and diverted flights.

## Tables

| Table | Grain | Key used for analysis | Verified rows |
| --- | --- | --- | ---: |
| `DIM_DATE` | One calendar date | `DATE_KEY` | 366 |
| `DIM_AIRLINE` | One reporting carrier | `CARRIER_CODE` | 15 |
| `DIM_AIRPORT` | One airport | `AIRPORT_ID` | 348 |
| `FACT_FLIGHTS` | One reported flight | Dimension keys plus flight details | 7,079,081 |

## Relationships

- `FACT_FLIGHTS.DATE_KEY` → `DIM_DATE.DATE_KEY`
- `FACT_FLIGHTS.CARRIER_CODE` → `DIM_AIRLINE.CARRIER_CODE`
- `FACT_FLIGHTS.ORIGIN_AIRPORT_ID` → `DIM_AIRPORT.AIRPORT_ID`
- `FACT_FLIGHTS.DEST_AIRPORT_ID` → `DIM_AIRPORT.AIRPORT_ID`

The airport dimension plays two roles: origin and destination. Power BI
relationship handling for these roles will be documented when the report
model is built.

## Row-level arrival flags

- `ARRIVAL_ELIGIBLE_FLAG = 1` when a flight is neither cancelled nor diverted.
- For eligible flights, `ARRIVAL_ON_TIME_FLAG = 1` when `ARR_DELAY < 15`;
  otherwise it is `0`.
- Ineligible flights have a NULL arrival on-time flag.

Validation found 6,965,267 eligible arrivals and zero mismatches against
BTS's `ARR_DEL15` indicator. All 7,079,081 flight rows matched every
required dimension key.

## Limits

The selected data contains aircraft tail numbers but does not establish
aircraft models. No aircraft-model dimension has been created. Airline
names have not been added from an official lookup yet.
