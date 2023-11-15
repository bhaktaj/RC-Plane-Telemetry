public class verticalScrolling{
  //size and position
  int width=100;
  int height=500;
  int leftx=0;
  int topy=0;
  int scale_y_axis_spacing=50;
  float scale_major_unit=5;
  float pixels_per_unit;
  String display_desc_text="Meter(unit)";
  boolean suppressNegatives = true;
  
  //instrument parameter
  color face=color(0,0,0);
  color scale=color(255,255,255);
  color needle=color(255,255,102);
  int scale_text_height=30;
  float value=0;
  float minValue;
  float maxValue;
  
  
  
  public void drawInstrument(){
    int x,y;
    
    //fill rectangle
    noStroke();
    stroke(scale);
    strokeWeight(1);
    fill(face);
    rect(leftx, topy, width, height, 10);
    
    //draw middle indicator line
    line(leftx,topy+height/2,leftx+20,topy+height/2);
    line(leftx+width-20,topy+height/2,leftx+width,topy+height/2);
    
    //place description text at bottom
    textSize(30);
    textAlign(CENTER);
    fill(255,255,255);
    text(display_desc_text,width/2+leftx,topy+height+40);
    
    //draw the scale
    
    //determine the limits of altitude that can be displayed
    pixels_per_unit=scale_y_axis_spacing/scale_major_unit;
    minValue=(value-(float(height)/2)/pixels_per_unit);
    maxValue=(value+(float(height)/2)/pixels_per_unit);
    
    //now round the min and max altitudes to be displayed to the nearest major value
    if (value<0){
      minValue=ceil(minValue/scale_major_unit)*scale_major_unit;
    }
    else{
      minValue=floor(minValue/scale_major_unit)*scale_major_unit;
    }
        
    maxValue=floor(maxValue/scale_major_unit)*scale_major_unit; 

    //print the scale
    y=topy+scale_text_height/2-floor((value%scale_major_unit)*pixels_per_unit);
    x=width/2+leftx;
    
    for(float i=minValue;i<maxValue;i+=scale_major_unit){
      textSize(scale_text_height);
      textAlign(CENTER);
      fill(255,255,255);
      
      //check if the text will not be printed outside of the box
      if(text_within_box(y)){
        if(!((i<0) && suppressNegatives)){
          text(String.format("%.0f",i),x,y);
        }
      }
      
      //increment the y value
      y=y+scale_y_axis_spacing;
    }
  }
  
  private boolean text_within_box(int y){
    
    int upper_y_limit;
    int lower_y_limit;
    
    upper_y_limit=topy+height;
    lower_y_limit=topy+scale_text_height;
    
    
    if (y>upper_y_limit || y<lower_y_limit){
       return false;
     }
     else{
       return true;
     }
       
  }  
}
