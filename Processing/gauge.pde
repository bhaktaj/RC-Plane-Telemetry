public class gauge{
  //size and position
  int width=300;
  int height=100;
  int leftx=0;
  int topy=0;
  float max_value=100;
  float min_value=0;
  float low_thresh=10;
  float high_thresh=90;
  float value=0;
  String display_desc_text="Meter(unit): ";
  
  //instrument display parameters
  color low=color(255,255,51);
  color high=color(255,51,51);
  color good=color(0,153,0);
  color face=color(0,0,0);
  int bar_margin=20;
  
  public void drawInstrument(){
    String display_text;
    
    //if value is less than the min value set it to the min value
    if (value<min_value){
      value=min_value;
    }
    
    //if value is more than the max value set it to the max value
    if (value>max_value){
      value=max_value;
    }
    
    //draw the outer rectange
    noStroke();
    stroke(255,255,255);
    strokeWeight(1);
    fill(face);
    rect(dX(0), dY(0), width, height, 10);
    
    //draw the gauge rectangle for the low range
    noStroke();
    fill(low);
    rect(dX(0+bar_margin), dY(height/2), bar_width(low_thresh), height/2-bar_margin, 0);
    
    //draw the gauge rectange for the good range
    fill(good);
    rect(dX(0+bar_margin+bar_width(low_thresh)), dY(height/2), bar_width(high_thresh)-bar_width(low_thresh), height/2-bar_margin, 0);
    
    //draw the gauge rectange for the high range
    fill(high);
    rect(dX(0+bar_margin+bar_width(high_thresh)), dY(height/2), bar_width(max_value)-bar_width(high_thresh), height/2-bar_margin, 0);
    
    //draw the description text
    textSize(30);
    textAlign(LEFT);
    fill(255,255,255);
    display_text=display_desc_text+String.format("%.1f",value);
    text(display_text,dX(bar_margin),dY(30));
    
    //draw the triangle
    drawGuageIndicator();
  } 
 
  private int dX(int localX){
    // changes local cordinates to display screen coordinates
    return localX+leftx;
  }

  private int dY(int localY){
    // changes local cordinates to display screen coordinates
    return localY+topy;
  }
  
  private int bar_width(float pvalue){
    // return the width of the bar for a given value
    return floor((width-2*bar_margin)*(pvalue-min_value)/(max_value-min_value));
  }
  
  private void drawGuageIndicator(){
    int triangleSize=(bar_margin-1)+10;
    int indicatorMidLocalX,triangleBaseY,x1,x2,x3,y1,y2,y3;
    
    
    noStroke();
    fill(255,255,255);
    
    indicatorMidLocalX=bar_width(value);
    triangleBaseY=dY(height-5);
    
    x1=dX(indicatorMidLocalX-triangleSize/2+bar_margin);
    x2=dX(indicatorMidLocalX+triangleSize/2+bar_margin);
    x3=dX(indicatorMidLocalX+bar_margin);
    
    y1=triangleBaseY;
    y2=y1;
    y3=topy+height-bar_margin-5;
    
    triangle(x1,y1,x2,y2,x3,y3);
  }  
  
}
