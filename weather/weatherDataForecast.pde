class weatherDataForecast
{
  
  int number;
  String name;
  String start_time;
  String end_time;
  boolean is_day;
  int temperature;
  String temp_unit;
  String temp_trend;
  String wind_speed;
  String wind_direction;
  String icon;
  String short_forecast;
  String detailed_forecast;
  
  /*
    "number": 1,
    "name": "This Afternoon",
    "startTime": "2020-05-18T16:00:00-05:00",
    "endTime": "2020-05-18T18:00:00-05:00",
    "isDaytime": true,
    "temperature": 72,
    "temperatureUnit": "F",
    "temperatureTrend": "falling",
    "windSpeed": "15 mph",
    "windDirection": "ENE",
    "icon": "https://api.weather.gov/icons/land/day/sct?size=medium",
    "shortForecast": "Mostly Sunny",
    "detailedForecast": "Mostly sunny. High near 72, with temperatures falling to around 68 in the afternoon. East northeast wind around 15 mph."
  */
  
  weatherDataForecast( int number_, String name_, String start_time_, String end_time_, boolean is_day_, 
                      int temperature_, String temp_unit_, String temp_trend_, String wind_speed_, 
                      String wind_direction_, String icon_, String short_forecast_, String detailed_forecast_ )
  {
    
    number = number_;
    name = name_;
    start_time = start_time_;
    end_time = end_time_;
    is_day = is_day_;
    temperature = temperature_;
    temp_unit = temp_unit_;
    temp_trend = temp_trend_;
    wind_speed = wind_speed_;
    wind_direction = wind_direction_;
    icon = icon_;
    short_forecast = short_forecast_;
    detailed_forecast = detailed_forecast_;
    
  }
}
