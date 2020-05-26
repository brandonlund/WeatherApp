PImage img;

class Menu
{
  void show_menu()
  {
    switch (screen)
    {
      case 0:
        // MAIN SCREEN
        background(#0A2840);
        radar_button = new MyButton( 4 * displayWidth/5.0, displayHeight/5.0, displayHeight/5.0, displayHeight/10.0, "Radar", screen, 4);
        screen = radar_button.check_press();
        textSize(displayWidth/25);
        text("Please Enter ZIP Code", displayWidth/2, displayHeight/15);
        //println(zip);
        if ( zip_index != -1 )
        {
          is_zip = true;
        }
        break;
        
      case 1:
        // FORECAST
        background(#0A2840);
        radar_button = new MyButton( 4 * displayWidth/5.0, displayHeight/5.0, displayHeight/5.0, displayHeight/10.0, "Radar", screen, 4);
        screen = radar_button.check_press();
        textSize(displayWidth/25);
        text("Current ZIP Code: " + zip, displayWidth/2, displayHeight/15);
        
        /*****************************************************************/
        
        // Draw week box top
        float offset = 0;
        for (int i = 0; i < 14; i+= 2 )
        {
          fill(#FFFFFF);
          textSize(displayWidth/75);
          text( wForecast[i].name, 11 * displayWidth/70.0 + offset, displayHeight/5 );
          
          rectMode(CENTER);
          stroke(#00AAFF); // rect outline
          fill(#002D5A); // rect fill
          rect( 11 * displayWidth/70.0 + offset, displayHeight/3.5 + displayHeight/25, displayHeight/5, displayHeight/5, 7 );
          offset += 4 * displayWidth/35.0;
        }
        
        offset = 0;
        for ( int i = 0; i < 14; i += 2 )
        {
          fill(#FFFFFF);
          textSize(displayWidth/25);
          // TEMP
          text( str(wForecast[i].temperature) + "°" + wForecast[i].temp_unit, 11 * displayWidth/70.0 + offset, displayHeight/3.5 );
          // WIND
          textSize(displayWidth/100);
          text( "Wind " + wForecast[i].wind_speed + " " + wForecast[i].wind_direction, 11 * displayWidth/70.0 + offset, displayHeight/3.5 + displayHeight/40);
          
          img = loadImage( wForecast[i].icon, "png" );
          img.resize(displayHeight/10, displayHeight/10);
          image( img, 11 * displayWidth/70.0 + offset - ( displayWidth/35 ), displayHeight/3.5 + displayHeight/30 );
          
          offset += 4 * displayWidth/35.0;
        }
        
        // Draw week box bottom
        offset = 0;
        for (int i = 1; i < 14; i+= 2 )
        {
          fill(#FFFFFF);
          textSize(displayWidth/75);
          text( wForecast[i].name, 11 * displayWidth/70.0 + offset, displayHeight/2.2 );
          
          rectMode(CENTER);
          stroke(#00AAFF); // rect outline
          fill(#002D5A); // rect fill
          rect( 11 * displayWidth/70.0 + offset, displayHeight/1.85 + displayHeight/25, displayHeight/5, displayHeight/5, 7 );
          offset += 4 * displayWidth/35.0;
        }
        
        offset = 0;
        for ( int i = 1; i < 14; i += 2 )
        {
          fill(#FFFFFF);
          textSize(displayWidth/25);
          // TEMP
          text( str(wForecast[i].temperature) + "°" + wForecast[i].temp_unit, 11 * displayWidth/70.0 + offset, displayHeight/1.85 );
          // WIND
          textSize(displayWidth/100);
          text( "Wind " + wForecast[i].wind_speed + " " + wForecast[i].wind_direction, 11 * displayWidth/70.0 + offset, displayHeight/1.85 + displayHeight/40);
          
          img = loadImage( wForecast[i].icon, "png" );
          img.resize(displayHeight/10, displayHeight/10);
          image( img, 11 * displayWidth/70.0 + offset - ( displayWidth/35 ), displayHeight/1.85 + displayHeight/30 );
          
          offset += 4 * displayWidth/35.0;
        }
        
        
        break;
        
      case 2:
        // ZIP NOT FOUND
        fill(#FFFFFF);
        background(#0A2840);
        radar_button = new MyButton( 4 * displayWidth/5.0, displayHeight/5.0, displayHeight/5.0, displayHeight/10.0, "Radar", screen, 4);
        screen = radar_button.check_press();
        textSize(displayWidth/25);
        text("Current ZIP Code: " + zip, displayWidth/2, displayHeight/15);
        
        text( "ZIP Code Does Not Exist.\nPlease Enter New ZIP Code.", displayWidth/2, displayHeight/2 );
        
        break;
        
      case 3:
        // HOURLY
        background(#0A2840);
        radar_button = new MyButton( 4 * displayWidth/5.0, displayHeight/5.0, displayHeight/5.0, displayHeight/10.0, "Radar", screen, 4);
        screen = radar_button.check_press();
        
        break;
        
      case 4:
        // RADAR
        background(#0A2840);
        for ( int i = 0; i < 8; i++ )
        {
          radar[i].resize(displayWidth, displayHeight);
        }
        
        if ( System.currentTimeMillis() % 5000 >= 0 && System.currentTimeMillis() % 5000 <= 625 )
        {
          image(radar[0], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 625 && System.currentTimeMillis() % 5000 <= 1250 )
        {
          image(radar[1], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 1250 && System.currentTimeMillis() % 5000 <= 1875 )
        {
          image(radar[2], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 1875 && System.currentTimeMillis() % 5000 <= 2500 )
        {
          image(radar[3], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 2500 && System.currentTimeMillis() % 5000 <= 3125 )
        {
          image(radar[4], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 3125 && System.currentTimeMillis() % 5000 <= 3750 )
        {
          image(radar[5], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 3750 && System.currentTimeMillis() % 5000 <= 4375 )
        {
          image(radar[6], 0, 0);
        }
        else if (System.currentTimeMillis() % 5000 > 4375)
        {
          image(radar[7], 0, 0);
        }
        
        break;
      
      default:
        background(#0A2840);
        textSize(displayWidth/25);
        text("Please Enter ZIP Code", displayWidth/2, displayHeight/6);
        zip_index = find_loc_data(zip);
    }
    
  }
  
}
