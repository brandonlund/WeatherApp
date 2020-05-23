import controlP5.*;
import http.requests.*;
import java.io.*;

Data[] data;
public weatherDataForecast[] wForecast;
weatherDataHourly[] wHourly;
Menu menu = new Menu();
int screen = 0;


ControlP5 cp5;
int num_locations;
public int num_forecast;
int num_hourly;
String api_url_forecast;
String api_url_forecast_hourly;
public static String zip = "";
boolean is_zip = false;
PFont font;
int zip_index = -1;
boolean first_run = true;
int old_index = 0;

void setup()
{
  //size(displayWidth, displayHeight);
  cp5 = new ControlP5(this);
  json();
  fullScreen();
  smooth();
  font = createFont("font.TTF", 128 * displayHeight / 1440);
  textFont(font);
  textAlign(CENTER);
  cp5.addTextfield("zip").setPosition(3*displayWidth/7, displayHeight/10).setSize(2*displayWidth/14, displayHeight/15).setFont(font).setFocus(true).setColor(255).setLabel("");
}

void draw()
{
  fill(255);
  if (screen == 0)
  {
    menu.show_menu();
    println(" " + zip);
    zip_index = find_loc_data(zip);
    old_index = zip_index;
    
    if ( zip_index == -1 )
    {
      screen = 2;
    }
    
    if ( is_zip == true )
    {
      screen = 1;
    }
  }
  else if ( screen == 1 )
  {
    println( "old_index: " + old_index );
    println( "zip_index: " + zip_index );
    zip_index = find_loc_data(zip);
    
    if ( zip_index == -1 )
    {
      screen = 2;
    }
    
    if ( System.currentTimeMillis() % 10000 < 100 || first_run || old_index != zip_index )
    {
      get_weather();
      first_run = false;
    }
    
    old_index = zip_index;
    menu.show_menu();
  }
  else if ( screen == 2 )
  {
    zip_index = find_loc_data(zip);
    
    if ( zip_index == -1 )
    {
      screen = 2;
    }
    else
    {
      screen = 1; 
    }
  }
}

void get_weather()
{
  String api_status;
  String api_OK = "OK";
  
  GetRequest get_status = new GetRequest("https://api.weather.gov/");
  get_status.send();

  JSONObject response = parseJSONObject(get_status.getContent());
  api_status = response.getString("status");
  println("status: " + api_status);
  
  if ( api_status.equals(api_OK) )
  {
    json();
  
    if ( zip_index == -1 )
    {
      println("Zip code does not exist.");
    }
    else
    {
      println(data[zip_index].city + ", " + data[zip_index].state + ", " + data[zip_index].zip);
      println(data[zip_index].lat + ", " + data[zip_index].lon);
      
      coord_to_gridpoint( data[zip_index].lat, data[zip_index].lon, zip_index );
      generate_api_url(data[zip_index].gridID, data[zip_index].gridX, data[zip_index].gridY);
      get_forecast();
      get_hourly();
    }
    
    // write_file(); // Was for writing sorted locations to file to improve loading time.
  }
  else
  {
    println("Weather.gov API is down. Please try again later.");
  }
}

void get_forecast()
{
  GetRequest req = new GetRequest(api_url_forecast);
  req.send();

  JSONObject dataJson = parseJSONObject(req.getContent());
  JSONObject properties = dataJson.getJSONObject("properties");
  JSONArray periods = properties.getJSONArray("periods");
  int num_forecast = periods.size();
  String temp_trend;
  
  wForecast = new weatherDataForecast[num_forecast];
  
  for (int i = 0; i < num_forecast; i++)
  {
    JSONObject wd = periods.getJSONObject(i);
    
    int number = wd.getInt("number");
    String name = wd.getString("name");
    String start_time = wd.getString("startTime");
    String end_time = wd.getString("endTime");
    boolean is_day = wd.getBoolean("isDaytime");
    int temperature = wd.getInt("temperature");
    String temp_unit = wd.getString("temperatureUnit");
    String icon = wd.getString("icon");
    if (wd.isNull("temperatureTrend"))
    {
      temp_trend = null;
    }
    else
    {
      temp_trend = wd.getString("temperatureTrend");
    }
    String wind_speed = wd.getString("windSpeed");
    String wind_direction = wd.getString("windDirection");
    String short_forecast = wd.getString("shortForecast");
    String detailed_forecast = wd.getString("detailedForecast");
    
    wForecast[i] = new weatherDataForecast(number, name, start_time, end_time, is_day, temperature, temp_unit, temp_trend, wind_speed, wind_direction, icon, short_forecast, detailed_forecast);
  }
  
  
  for ( int i = 0; i < num_forecast; i++)
  {
    println(wForecast[i].number);
    println(wForecast[i].name);
    println(wForecast[i].start_time);
    println(wForecast[i].end_time);
    println(wForecast[i].is_day);
    println(wForecast[i].temperature);
    println(wForecast[i].temp_unit);
    println(wForecast[i].temp_trend);
    println(wForecast[i].wind_speed);
    println(wForecast[i].wind_direction);
    println(wForecast[i].icon);
    println(wForecast[i].short_forecast);
    println(wForecast[i].detailed_forecast);
  }
  
}

void get_hourly()
{
  GetRequest req = new GetRequest(api_url_forecast_hourly);
  req.send();

  JSONObject dataJson = parseJSONObject(req.getContent());
  JSONObject properties = dataJson.getJSONObject("properties");
  JSONArray periods = properties.getJSONArray("periods");
  int num_hourly = periods.size();
  
  wHourly = new weatherDataHourly[num_hourly];
  
  for (int i = 0; i < num_hourly; i++)
  {
    JSONObject wd = periods.getJSONObject(i);
    
    int number = wd.getInt("number");
    String start_time = wd.getString("startTime");
    String end_time = wd.getString("endTime");
    boolean is_day = wd.getBoolean("isDaytime");
    int temperature = wd.getInt("temperature");
    String temp_unit = wd.getString("temperatureUnit");
    String wind_speed = wd.getString("windSpeed");
    String wind_direction = wd.getString("windDirection");
    String short_forecast = wd.getString("shortForecast");
    
    wHourly[i] = new weatherDataHourly(number, start_time, end_time, is_day, temperature, temp_unit, wind_speed, wind_direction, short_forecast);
  }
  
  /*
  for ( int i = 0; i < num_periods; i++)
  {
    println(wHourly[i].number);
    println(wHourly[i].start_time);
    println(wHourly[i].end_time);
    println(wHourly[i].is_day);
    println(wHourly[i].temperature);
    println(wHourly[i].temp_unit);
    println(wHourly[i].wind_speed);
    println(wHourly[i].wind_direction);
    println(wHourly[i].short_forecast);
  }
  */
  
}

void generate_api_url( String gridID, int gridX, int gridY )
{
  api_url_forecast = "https://api.weather.gov/gridpoints/" + gridID + "/" + gridX + "," + gridY + "/forecast";
  api_url_forecast_hourly = "https://api.weather.gov/gridpoints/" + gridID + "/" + gridX + "," + gridY + "/forecast/hourly";
  println(api_url_forecast);
}

void json()
{
  JSONObject json = loadJSONObject("sorted_data.json");
  JSONArray field_data = json.getJSONArray("data");
  num_locations = field_data.size();
  
  data = new Data[num_locations];
  
  for ( int i = 0; i < num_locations; i++ )
  {
    // Get each object
    JSONObject d = field_data.getJSONObject(i);
    
    JSONObject fields = d.getJSONObject("fields");
    String city = fields.getString("city");
    String st = fields.getString("state");
    String zip = fields.getString("zip");
    float lon = fields.getFloat("longitude");
    float lat = fields.getFloat("latitude");
    int tz = fields.getInt("timezone");
    
    //println("City: " + city);
    //println("State: " + st);
    //println("Zip: " + zip);
    //println("Longitude: " + lon);
    //println("Latitude: " + lat);
    //println("Timezone: " + tz);
    
    // put the city, state, zip, lon, lat, and timezone into data array
    data[i] = new Data( city, st, zip, lon, lat, tz, "", 0, 0 );
  }
  // sort_zip(); // No more sort due to file being in order.
  // println("Sorted");
}

void sort_zip()
{
  println("Sorting");
  for ( int i = 0; i < num_locations - 1; i++)
  {
    int min_idx = i; 
    for (int j = i+1; j < num_locations; j++) 
    {
      if (parseInt(data[j].zip) < parseInt(data[min_idx].zip))
      {
          min_idx = j; 
      }
    }
    
    println("Swap " + i);
    Data temp = data[min_idx]; 
    data[min_idx] = data[i]; 
    data[i] = temp; 
  }
}

int find_loc_data(String zip)
{
  int l = 0;
  int r = num_locations - 1; 
  int num_loops = 0;
  while (l <= r) 
  { 
    num_loops++;
    int m = l + (r - l) / 2; 
    // Check if x is present at mid 
    if (parseInt(data[m].zip) == parseInt(zip)) 
    {
      println("Search took " + num_loops + " loops.");
      is_zip = true;
      
      return m; 
    }
    // If x greater, ignore left half 
    if (parseInt(data[m].zip) < parseInt(zip)) 
    {
      l = m + 1; 
    }
    // If x is smaller, ignore right half 
    else
    {
      r = m - 1; 
    }
  } 

  // if we reach here, then element was 
  // not present 
  println("Search took " + num_loops + " loops. But it didn't find anything.");
  zip = "";
  is_zip = false;
  return -1;
}

void coord_to_gridpoint( float lat, float lon, int loc_index )
{
  String gridID;
  int gridX;
  int gridY;
  GetRequest loc = new GetRequest("https://api.weather.gov/points/" + lat + "," + lon);
  loc.send();

  JSONObject locJson = parseJSONObject(loc.getContent());
  JSONObject grid = locJson.getJSONObject("properties");
  gridID = grid.getString("cwa");
  gridX = grid.getInt("gridX");
  gridY = grid.getInt("gridY");
  
  data[loc_index].gridID = gridID;
  data[loc_index].gridX = gridX;
  data[loc_index].gridY = gridY;
}

void write_file()
{
  println("Starting to write.");
  try {
    FileWriter myWriter = new FileWriter("C:/Users/Brandon/Documents/Processing/weather/sorted_data.json");
    myWriter.write("{\"data\":[");
    for ( int i = 0; i < num_locations; i++ )
    {
      myWriter.write("{\"fields\": " + "\n" + "{");
      myWriter.write("\"city\": " + "\"" + data[i].city + "\",");
      myWriter.write("\"state\": " + "\"" + data[i].state + "\",");
      myWriter.write("\"zip\": " + "\"" + data[i].zip + "\",");
      myWriter.write("\"longitude\": " + "\"" + data[i].lon + "\",");
      myWriter.write("\"latitude\": " + "\"" + data[i].lat + "\",");
      myWriter.write("\"timezone\": " + "\"" + data[i].timezone + "\"");
      myWriter.write("}},");
      println("Zip " + data[i].zip + " written.");
    }
    myWriter.write("]}");
    
    myWriter.close();
    System.out.println("Successfully wrote to the file.");
  } catch (IOException e) {
    System.out.println("An error occurred.");
    e.printStackTrace();
  }
}
