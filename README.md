# WhetherKit

A library for defining and retrieving weather data for The Whether App.

## Requesting Weather Data

Request weather data using the shared `Whether` instance.

```swift
let location = WhetherLocation(latitude: 41.8825149, longitude: -87.6297767)
Whether.shared.weather(at: location) {(result) in
    switch result {
    case .success(let weatherReport):
      // ...
    case .failure(let error):
      // ...
    }
}
```

## Authentication

IMPORTANT: `WhetherKit` authenticates by requesting a token from the server,
and passing it for each request. Token granting is rate limited, however,
so if you run unit tests locally, you should use a local server, or your IP
will receive 403 status codes for auth token requests (and 401 for others).

It is very likely I'll add a per-app token rather than rate limiting by IP,
so stay tuned for changes.

## Data Types

### WeatherReport

A `WeatherReport` contains a bunch of weather snapshots and some meta data.

### WeatherSnapshot

A weather snapshot is what represents the weather at a given point in time.

All public attributes are either raw types, such as the "summary" (which is an English string),
or the uv index, which is a double, or Foundation's `Measurement`s.

Foundation makes it easy to convert values from one unit to another:

```swift
snapshot.temperature.value // 21.0
snapshot.temperature.converted(to: .fahrenheit).value // 69.8
```

By default, all values are in SI units.

IMPORTANT: Most of these fields are optional and exist only based on where
the snapshot exists. For example, precipitation accumulation doesn't exist for
current weather, but does for daily weather. I hope to clean this up so more fields
are guaranteed to be present.
