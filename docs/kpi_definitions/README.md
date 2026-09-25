# KPI definitions

These definitions use the 2024 BTS reporting operating-carrier flight
records in `AIRLINE_DB.ANALYTICS.FACT_FLIGHTS`. Report filters will
change the counts but not the definitions.

| KPI | Numerator / calculation | Denominator / population |
| --- | --- | --- |
| Total reported flights | Count fact rows | All reported flights, including cancellations and diversions |
| Cancelled flights | Count rows where `CANCELLED = 1` | All reported flights |
| Cancellation rate | Cancelled flights | Total reported flights |
| Diverted flights | Count rows where `DIVERTED = 1` | All reported flights |
| Diversion rate | Diverted flights | Total reported flights |
| Arrival-eligible flights | Sum `ARRIVAL_ELIGIBLE_FLAG` | Flights neither cancelled nor diverted |
| On-time arrivals | Count rows where `ARRIVAL_ON_TIME_FLAG = 1` | Arrival-eligible flights |
| Arrival OTP % | On-time arrivals | Arrival-eligible flights |
| Delayed arrivals (15+ min) | Count eligible rows where `ARRIVAL_ON_TIME_FLAG = 0` | Arrival-eligible flights |
| Average arrival delay (minutes) | Average signed `ARR_DELAY` | Arrival-eligible flights |

For arrival OTP, `ARR_DELAY < 15` is on time. Early arrivals have
negative delay minutes and qualify as on time. Cancelled and diverted
flights have no regular `ARR_DELAY`; they are excluded from arrival OTP
and reported through separate rates.

The average arrival delay uses signed minutes, so early arrivals can
lower the average. If a dashboard needs the average delay among late
flights only, it will be a separate, explicitly named measure.

`CARRIER_DELAY`, `WEATHER_DELAY`, `NAS_DELAY`, `SECURITY_DELAY` and
`LATE_AIRCRAFT_DELAY` are reported delay-cause **minutes**. Summing
them measures attributed minutes, not a count of flights exclusively
caused by one category.

Departure OTP is defined below using the verified BTS departure-delay fields.


## Departure OTP

| KPI | Numerator / calculation | Denominator / population |
| --- | --- | --- |
| Departure-eligible flights | Count rows where `CANCELLED = 0` | All non-cancelled flights, including diversions |
| On-time departures | Count eligible rows where `DEP_DELAY < 15` | Departure-eligible flights |
| Departure OTP % | On-time departures | Departure-eligible flights |

The 2024 data has 6,982,766 departure-eligible flights. All have
recorded `DEP_DELAY` and `DEP_DEL15` values. Of the 96,315 cancelled
flights, 3,345 nevertheless have a departure-delay value; they remain
excluded from departure OTP by the business rule. The view's
`DEPARTURE_ON_TIME_FLAG` had zero mismatches with BTS's `DEP_DEL15`
indicator among eligible flights.
