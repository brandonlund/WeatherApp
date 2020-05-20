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
        text("Current ZIP Code: " + zip, displayWidth/2, displayHeight/15);
        
        /*****************************************************************/
        rectMode(CENTER);
        stroke(#00AAFF); // rect outline
        fill(#002D5A); // rect fill
        rect( displayWidth/2, displayHeight/3.5, displayWidth * .8, displayHeight/5 );
        break;
      
      default:
        background(#0A2840);
        textSize(displayWidth/25);
        text("Please Enter ZIP Code", displayWidth/2, displayHeight/6);
        zip_index = find_loc_data(zip);
    }
    
  }
  
  
  
}
