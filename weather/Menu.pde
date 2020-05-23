PImage img;

class Menu
{
  
  void show_menu()
  {
    
    switch (screen)
    {
      case 0:
        background(#0A2840);
        textSize(displayWidth/25);
        text("Please Enter ZIP Code", displayWidth/2, displayHeight/15);
        //println(zip);
        if ( zip_index != -1 )
        {
          is_zip = true;
        }
        break;
        
      case 1:
        background(#0A2840);
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
        fill(#FFFFFF);
        background(#0A2840);
        textSize(displayWidth/25);
        text("Current ZIP Code: " + zip, displayWidth/2, displayHeight/15);
        
        text( "ZIP Code Does Not Exist.\nPlease Enter New ZIP Code.", displayWidth/2, displayHeight/2 );
        
        break;
      
      default:
        background(#0A2840);
        textSize(displayWidth/25);
        text("Please Enter ZIP Code", displayWidth/2, displayHeight/6);
        zip_index = find_loc_data(zip);
    }
    
  }
  
  
  
}
