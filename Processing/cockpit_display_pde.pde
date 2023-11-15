import processing.serial.*;
Serial myPort; 

attitudeIndicator attitudeIndicator = new attitudeIndicator();
verticalScrolling altitudeIndicator = new verticalScrolling();
transmitter tx = new transmitter();

gauge voltmeter= new gauge();
textDisplay ammeter= new textDisplay();
textDisplay lattitudeDisplay= new textDisplay();
textDisplay longitudeDisplay= new textDisplay();

float pitch,roll;



void setup()
{  
  size(1000, 1000);
  background(100,100,100);
  myPort = new Serial(this, "COM5", 115200);
  
  attitudeIndicator.topy=100;
  attitudeIndicator.leftx=250;
  
  altitudeIndicator.topy=100;
  altitudeIndicator.leftx=800;
  altitudeIndicator.display_desc_text="ALT(ft)";
  
  ammeter.topy=830;
  ammeter.leftx=100;
  ammeter.display_desc_text="Current(A): ";
  
  lattitudeDisplay.topy=700;
  lattitudeDisplay.leftx=500;
  lattitudeDisplay.width=400;
  lattitudeDisplay.display_desc_text="Lat: ";
  
  longitudeDisplay.topy=750;
  longitudeDisplay.leftx=500;
  longitudeDisplay.width=400;
  longitudeDisplay.display_desc_text="Lon: ";
  
  
  voltmeter.topy=700;
  voltmeter.leftx=100;
  voltmeter.min_value=10;
  voltmeter.max_value=14;
  voltmeter.low_thresh=11.5;
  voltmeter.high_thresh=12.6;
  voltmeter.display_desc_text="Batt(V): ";
}

void draw()
{  
   //update values
   if(tx.update(myPort)){
     attitudeIndicator.pitch=tx.pitch;
     attitudeIndicator.roll=tx.roll;
     altitudeIndicator.value=tx.altitude;
     longitudeDisplay.value=tx.longitude;
     lattitudeDisplay.value=tx.lattitude;   
     voltmeter.value=random(10.5,12.4);
   }
     
   //draw the instruments
   attitudeIndicator.drawInstrument();
   altitudeIndicator.drawInstrument();
   ammeter.drawInstrument();
   voltmeter.drawInstrument();
   longitudeDisplay.drawInstrument();
   lattitudeDisplay.drawInstrument();
}
