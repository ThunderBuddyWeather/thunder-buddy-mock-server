# WireMock Response Files

This directory contains static response files used by WireMock for the Thunder Buddy Mock Server.

## Files

- `current-weather.json`: Sample current weather data
- `daily-forecast.json`: Sample daily forecast data
- `hourly-forecast.json`: Sample hourly forecast data
- `weather-alerts.json`: Sample weather alerts data
- `icons/`: Directory containing weather icons

## Usage

These files can be referenced in WireMock mappings using the `bodyFileName` property. For example:

```json
{
  "response": {
    "status": 200,
    "bodyFileName": "current-weather.json"
  }
}
```

Variables like `${lat}` and `${lon}` in these files will be replaced with values from the request when using WireMock response templating.
