/*
  3D scaner with infared sensor and two servo motors

  The motors will tilt and pan the sensor to take an image of the object and transmit to to a Matlab script that uses the data to plot.

  Created 20 Sep. 2017

*/
#include "Servo.h" // Included the Servo library

const int analogInPin = A0;  // Analog input pin that the sensor is attached to
const int analogOutPin1 = 9; // Analog output pin that the base motor is attached to
const int analogOutPin2 = 8;  //  Analog output pin that the top motor is attached to

Servo baseServo; // declaring the top and base servos
Servo topServo;

int posBase = 0;              // Inital base servo position
int posTop = 0;              // Inital top servo position

float sensorValue = 0;        // value read from the pot
int outputValue1 = 0;        // value output to the PWM (analog out)
int outputValue2 = 0;        // value output to the PWM (analog out)

// Out 1 is for the base motor
// Out 2 is for the top motor

void setup() {
  // initialize serial communications at 9600 bps:
  Serial.begin(9600);

  baseServo.attach(analogOutPin1);
  topServo.attach(analogOutPin2);
}


void loop() {
    int read1 = 0;
    int read2 = 0;
    int read3 = 0;
    int avRead = 0;
    // initalizing average reading variables

      for (posBase = 90; posBase >= 30; posBase -= 1) { // goes from 60 degrees to 30 degrees
         baseServo.write(posBase);                      // tell servo to go to position in variable 'posBase'
          for (posTop = 100; posTop >= 45; posTop -= 1) { // goes from 100 degrees to 70 degrees
          topServo.write(posTop);                       // tell servo to go to position in variable 'posTop'
         delay(50);                                      // Waits 50 seconds for the sensor to get a reading of a single point
          read1 = SensorRead();
          delay(50);
         read2 = SensorRead();
          delay(50);
          read3 = SensorRead();
          delay(50);

          avRead = (read1 + read2 + read3)/3;  // Calculating the average read from the sensor
          
          // Send the top angle, the base angle, and the average read to Matlab
          Serial.println(posTop);    
          Serial.println(posBase);        
          Serial.println(avRead); 
           
       }
      }
  Serial.println(-1);
}
int SensorRead() {
  // read the analog in value:
  sensorValue = analogRead(analogInPin);
  //return sensorValue;
  int result = 0.121951 * (700 - sensorValue);
  return sensorValue;
}
