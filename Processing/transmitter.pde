public class transmitter{
  
  //raw data
  float ax;
  float ay;
  float az;
  float pressure;
  String lattitude;
  String longitude;
  float temperature;
  //calculated data
  float altitude;
  float pitch;
  float roll;
  
  //process flags, monitor, and settings
  boolean startReceived=false;
  boolean endReceived=false;
  int startTime;
  int timeOutPeriodms=500;
  int tokenCount=0;
  int tokensExpected=6;
  
  //update the data from data received on the serial port
  public boolean update(Serial port){
    
    String data="";
    
    //reset process flags
    startReceived=false;
    endReceived=false;
    tokenCount=0;
    resetTimer();
         
    while(!endReceived && !checkTimeOut()){
      
      //get data from serial port
      if(port.available()>0){
        //read unit a line feed character is obtained
        data=trim(port.readStringUntil(10));
        
        //check a line feed was found
        if (data==null){
          //try again
          continue;
        }
        
        //check if START token is received
        if (data.contentEquals("START")){
          startReceived=true;
          endReceived=false;
          tokenCount=0;
          continue;
        }
        
        //process the data
        if(tokenCount<tokensExpected){
          if (processLine(data)){
            tokenCount++;
          }  
        }
        
        if(tokenCount==tokensExpected){
          println("all tokens received");
          calculateDerivedValues();
          return true;
        }  
        
      }
      else{
        //no data was received
        if(checkTimeOut()){
          println("timeout reached");
          delay(100);
        }
      }     
   }
   
   return checkTimeOut();
  }
  
  //check if timeout has been reached
  private boolean checkTimeOut(){
    if((millis()-startTime)>timeOutPeriodms){
      return true;
    }
    else{
      return false;
    }  
  }
  
  //reset the start time for timeout detection
  private void resetTimer(){
    startTime=millis();
  }
  
  //process the data line received
  private boolean processLine(String pData){
     
   String values[]; 
   
   //check if we have reached the end
   if (pData.contentEquals("END")){
     endReceived=true;
     return false;
   }
   
   
   //the data is expected with leading token
   //separated from the value with a colon
   if(pData.indexOf(":")>0){
     values=split(pData,":");
 
     switch (trim(values[0]))
     {
       case "ax":
         ax=float(values[1]);
         return true;
       
       case "ay":
         ay=float(values[1]);
         return true;
       
       case "az":
         az=float(values[1]);
         return true;
       
       case "Temp(C)":
         temperature=float(values[1]);
         return true;
       
       case "Lat":
         lattitude=values[1];
         return true;
         
       case "Lon":
         longitude=values[1];
         return true;
         
       case "Pressure":
         pressure=float(values[1]);
         
       default:
         return false;
     }    
    }
    else{
      return false;
    }  
  }
  
  //Calculate the derived values
  private void calculateDerivedValues(){
    PVector acc;
    float xzProjectionLength;
    
    acc=new PVector(ax,ay,az);
    acc.normalize();
    
    //method based on https://www.nxp.com/docs/en/application-note/AN3461.pdf
    pitch=90-atan2(acc.z,acc.x)*180/PI;
    xzProjectionLength=sqrt(pow(acc.x,2)+pow(acc.z,2));
    roll=atan2(xzProjectionLength,acc.y)*180/PI-90;
    
    //from https://en.wikipedia.org/wiki/Pressure_altitude
    altitude=145366.45*(1-pow(pressure/1013,0.190284))-370;
  }  
}  
