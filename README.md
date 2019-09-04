# WhetherKit

A library for defining and retrieving weather data for The Whether App.

## WeatherReport

A `WeatherReport` contains a bunch of weather snapshots and some meta data.

## WeatherSnapshot

A weather snapshot is what represents the weather at a given point in time.

All public attributes are either raw types, such as the "summary" (which is an English string),
or the uv index, which is a double, or Foundation's `Measurement`s.

Foundation makes it easy to convert values from one unit to another:

```swift
snapshot.temperature.value # 21.0
snapshot.temperature.converted(to: .fahrenheit).value # 69.8
```

By default, all values are in SI units.
