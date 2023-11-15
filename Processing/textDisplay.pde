public class textDisplay{
  //size and position
  int width=300;
  int height=50;
  int leftx=0;
  int topy=0;
  String display_desc_text="Meter(unit):";
  String display_text;
  
  //instrument parameter
  color face=color(0,0,0);
  color scale=color(255,255,255);
  int scale_text_height=30;
  String value="0";

  
  public void drawInstrument(){
    
    //fill rectangle
    noStroke();
    stroke(scale);
    strokeWeight(1);
    fill(face);
    rect(leftx, topy, width, height, 10);
       
    //display the text
    textSize(30);
    textAlign(LEFT);
    fill(255,255,255);
    display_text=display_desc_text+value;
    text(display_text,leftx+10,topy+height/2+10);
       
  }
  
 
}
