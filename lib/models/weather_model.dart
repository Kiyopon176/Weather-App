class Weather {
  final String city;
  final double temperature;
  final String description;
  final List<DailyForecast> dailyForecasts;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.dailyForecasts,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    var dailyForecastsJson = json['forecast']['forecastday'] as List;
    List<DailyForecast> dailyForecasts = dailyForecastsJson.map((day) => DailyForecast.fromJson(day)).toList();

    return Weather(
      city: json['location']['name'] ?? 'Unknown city',
      temperature: json['current']['temp_c']?.toDouble() ?? 0.0,
      description: json['current']['condition']['text'] ?? 'No description',
      dailyForecasts: dailyForecasts,
    );
  }
}

class DailyForecast {
  final String date;
  final List<HourlyForecast> hourlyForecasts;

  DailyForecast({
    required this.date,
    required this.hourlyForecasts,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    var hourlyForecastsJson = json['hour'] as List;
    List<HourlyForecast> hourlyForecasts = hourlyForecastsJson.map((hour) => HourlyForecast.fromJson(hour)).toList();

    return DailyForecast(
      date: json['date'] ?? 'Unknown date',
      hourlyForecasts: hourlyForecasts,
    );
  }
}

class HourlyForecast {
  final String time;
  final double temperature;
  final int humidity;
  final String condition;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.condition,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time'] ?? 'Unknown time',
      temperature: json['temp_c']?.toDouble() ?? 0.0,
      humidity: json['humidity']?.toInt() ?? 0,
      condition: json['condition']['text'] ?? 'No condition',
    );
  }
}
