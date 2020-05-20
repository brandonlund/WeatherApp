class weatherDataHourly
{
  
  int number;
  String start_time;
  String end_time;
  boolean is_day;
  int temperature;
  String temp_unit;
  String wind_speed;
  String wind_direction;
  String short_forcast;
  
  /*
    "number": 1,
    "name": "",
    "startTime": "2020-05-18T17:00:00-04:00",
    "endTime": "2020-05-18T18:00:00-04:00",
    "isDaytime": true,
    "temperature": 69,
    "temperatureUnit": "F",
    "temperatureTrend": null,
    "windSpeed": "13 mph",
    "windDirection": "E",
    "icon": "https://api.weather.gov/icons/land/day/bkn?size=small",
    "shortForecast": "Partly Sunny",
    "detailedForecast": ""
  */
  
  weatherDataHourly( int number_, String start_time_, String end_time_, boolean is_day_, 
                      int temperature_, String temp_unit_, String wind_speed_, 
                      String wind_direction_, String short_forcast_ )
  {
    
    number = number_;
    start_time = start_time_;
    end_time = end_time_;
    is_day = is_day_;
    temperature = temperature_;
    temp_unit = temp_unit_;
    wind_speed = wind_speed_;
    wind_direction = wind_direction_;
    short_forcast = short_forcast_;
    
  }
}
