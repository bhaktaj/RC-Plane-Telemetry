public class attitudeIndicator{
  //size and position
  int width=500;
  int height=500;
  int leftx=0;
  int topy=0;
  
  //instrument parameters
  int diameter=500;
  color sky=color(0,153,255);
  color ground=color(153,102,51);
  color pitch_scale=color(255,255,255);
  color wing=color(255,255,102);
  int pitch_scale_width=160;
  int pitch_scale_pixels_per_degree=4;
  float pitch=0;
  float roll=0;
  
  
  public void drawInstrument(){
    int wing_start_radius=50;
    int wing_end_radius=150;
    int i,y;
 
    //fill in sky and ground
    draw_ground_sky(pitch,roll);
  
    //draw roll scale
    stroke(pitch_scale);
    strokeWeight(1);
  
    arc(leftx+width/2,topy+width/2,400,400,PI,2*PI,OPEN);
    //draw pitch scale
    textSize(20);
    textAlign(CENTER);
    fill(255,255,255);
  
    for(i=0;i<4;i++){
      strokeWeight(1);
      y=130+i*80+topy;
      stroke(pitch_scale);
      line(width/2-pitch_scale_width/2+leftx,y,width/2+pitch_scale_width/2+leftx,y);
      text(str(20-i*15),width/2+leftx,y+6);
      noStroke();
    
    //draw wing
    stroke(wing);
    strokeWeight(10);
    line(width/2-wing_end_radius+leftx,height/2+topy,width/2-wing_start_radius+leftx,width/2+topy);
    line(width/2-wing_start_radius+leftx,width/2+topy,width/2-wing_start_radius+leftx,width/2+15+topy);
    line(width/2+wing_end_radius+leftx,height/2+topy,width/2+wing_start_radius+leftx,width/2+topy);
    line(width/2+wing_start_radius+leftx,width/2+topy,width/2+wing_start_radius+leftx,width/2+15+topy);
    line(width/2-5+leftx,width/2+topy,width/2+5+leftx,width/2+topy);
    } 
  }
  
  void draw_ground_sky(float pitch,float roll){
    float m, C, d, x1, x2, y1, y2;
    float angle1, angle2, angle_start, angle_end;
  
    //ensure any previous stroke commands are canceled
    noStroke();
  
    // calculate start and stop angles for ground and sky
    // for coordinate system concentric with instrument center
    // x_a increases to the left, y_a increases going up
    // positive pitch is pitching the airplane up
    // positive roll is rolling to the left (port)
    // pitch and roll are in degrees
  
    // calculate the equation of the ground/sky interface
    m=-tan(roll*PI/180);
    C=-pitch*pitch_scale_pixels_per_degree;
  
    //determine the coordinates of the intercept of the
    //ground/sky interface with the outer circle
    // solving y=mx+C and y^2+x^2=R^2 for x using quadratic formula
    d=pow(2*m*C,2)-(4*(pow(m,2)+1)*(pow(C,2)-pow(diameter/2,2)));
  
    // check roots will not be imaginary
    if(d<0)
    {
      //do something here
      return;
    }
  
    // calculate coordinates of interceps of 
    // sky/ground interface with the outer circle
    // representing the bezel of the instrument
    d=sqrt(d);
    x1=(-2*m*C+d)/(2*(pow(m,2)+1));
    x2=(-2*m*C-d)/(2*(pow(m,2)+1));
    y1=m*x1+C;
    y2=m*x2+C;
  
  
    //find the start angle for the ground arc
    //these angles are counterclockwise from the origin
    angle2=atan2(y2,x2);
    angle1=atan2(y1,x1);
  
    //for upright flying   
    angle_start=-angle1;
  
    if(angle2<0){ 
      angle_end=-angle2;
    }
    else{ 
      angle_end=2*PI-angle2;
    }
    
    fill(ground);
    arc(leftx+width/2,topy+height/2,diameter,diameter,angle_start,angle_end,CHORD);
  
    fill(sky);
    arc(leftx+width/2,topy+height/2,diameter,diameter,angle_end,2*PI-angle1,CHORD);
    noFill();
}

}
