#include <SoftwareSerial.h>

SoftwareSerial BluetoothSerial(2,3);

char data;



void setup() {
  pinMode(7,OUTPUT);
  Serial.begin(9600);
  BluetoothSerial.begin(9600);

}

void loop() {
  if(BluetoothSerial.available() > 0)
  {
    data = BluetoothSerial.read();

    switch(data)
    {
      case 'a':
        for(int i=0; i< 5; i++){
          tone(7,500);
          delay(100);
          noTone(7);
          delay(50);
        }
        break;
        
      case 'b':

        while(BluetoothSerial.read() != 'c')
        {
          float sampledData = analogRead(A0) * (5.0/1023.0);
          BluetoothSerial.println(sampledData); // sending to bluetooth
          Serial.println(sampledData); // sending to computer serial port
          delay(25);
        }
        while(BluetoothSerial.read() == 'c'){
          tone(7,500);
          delay(100);
          noTone(7);
        }
        
        break; 

      
    }
    
  }

}
