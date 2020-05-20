class Data
{
  String city;
  String state;
  String zip;
  float lat;
  float lon;
  int timezone;
  String gridID;
  int gridX;
  int gridY;
  
  Data(String city_, String state_, String zip_, float lon_, float lat_, int timezone_, String gridID_, int gridX_, int gridY_)
  {
    city = city_;
    state = state_;
    zip = zip_;
    lat = lat_;
    lon = lon_;
    timezone = timezone_;
    gridID = gridID_;
    gridX = gridX_;
    gridY = gridY_;
  }
}
