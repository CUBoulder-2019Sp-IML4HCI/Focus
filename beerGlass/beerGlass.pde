import netP5.*;
import oscP5.*;
int R = 100;
int G = 5;
float pR = 100;
float pG = 5;
int B = 20;
color focus = color(R,G,B);

//Global Variables
OscP5 oscP5;
NetAddress dest;
float fillLine = 80; // Level of the beer
float std_avg = 0;  //average standard deviation
int count = 0;  // count for averaging
int textTimer = 0; // timer for displaying text

void setup(){
  //OSC setup
  oscP5 = new OscP5(this,12000); //listen for OSC messages
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator
  
  // Drawing
  size(300,300);
  
}

void draw(){
  
  //Background
  background(255);
  fill(100);
  //noStroke();
  rect(-1, height-100, width+2, 100);
  fill(focus);
  rect(-1,0,width+2, height-100);
  
  //Glass
  strokeWeight(2);
  stroke(25);
  noFill();
  ellipse(width/2,50,width/2,width/8);
  line(width/2-width/4, 50, width/2-width/4, height-80);
  line(width/2+width/4, 50, width/2+width/4, height-80);
  
  //Base
  fill(170);
  noStroke();
  rect(width/2-width/4-4, height-80, width/2+8, 37);
  stroke(0);
  arc(width/2, height-80, width/2, width/8, 0, PI);
  arc(width/2-width/4-2, height-62, 15, 35, PI/2+0.22, 3*PI/2);
  arc(width/2+width/4+2, height-62, 15, 35, -PI/2, PI/2-0.22);
  arc(width/2, height-49, width/2+10, width/8, 0.23, PI-0.23);
  
  //Handle
  fill(170);
  noStroke();
  ellipse(width/2+width/4+45, 100+10, 20, 20);
  ellipse(width/2+width/4+45, height-125, 20, 20);
  rect(width/2+width/4,100,45,20);
  rect(width/2+width/4+25+10, 110, 20, height-145+10-100);
  rect(width/2+width/4,height-145+10,45,20);
  stroke(170);
  noFill();
  strokeWeight(4);
  arc(width/2+width/4+25+2, 120+10-2, 20, 20, -PI/2,0);
  arc(width/2+width/4+25+2, height-145+2, 20, 20, 0, PI/2);
  
  noFill();
  stroke(0);
  strokeWeight(2);
  line(width/2+width/4, 100, width/2+width/4+45, 100);
  arc(width/2+width/4+45, 100+10, 20, 20, -PI/2, 0);
  line(width/2+width/4+45+10, 100+10, width/2+width/4+45+10, height-125);
  arc(width/2+width/4+45, height-125, 20, 20, 0, PI/2);
  line(width/2+width/4, height-125+10, width/2+width/4+45, height-125+10);
  
  line(width/2+width/4, 120, width/2+width/4+25, 120);
  arc(width/2+width/4+25, 120+10, 20, 20, -PI/2, 0);
  line(width/2+width/4+25+10, 120+10, width/2+width/4+25+10, height-145);
  arc(width/2+width/4+25, height-145, 20, 20, 0, PI/2);
  line(width/2+width/4, height-145+10, width/2+width/4+25, height-145+10);
  
  //Beer
  stroke(0);
  fill(214,147,40);
  rect(width/2-width/4, height-fillLine, width/2, fillLine-80);
  ellipse(width/2,height-80,width/2,width/8);
  strokeWeight(2);
  fill(232, 208, 178);
  ellipse(width/2,height-fillLine,width/2,width/8);
  
  //Foam
  fill(232, 208, 178);
  noStroke();
  rect(width/2-width/4+1, height-fillLine-20, width/2-1, 20);
  stroke(0);
  //ellipse(width/2,height-fillLine,width/2,width/8);
  strokeWeight(2);
  ellipse(width/2,height-fillLine-20,width/2,width/8);
  
  noFill();
  arc(width/2,height-80,width/2,width/8, 0, PI);
  strokeWeight(1);
  stroke(50);
  
  stroke(0);
  arc(width/2,50,width/2,width/8, 0, PI);

 //fillLine += 1;
  //If beer is full, display text and empty the beer
  if (fillLine >= (height-50)){
          textSize(32);
          text("GRAB A BEER!", width/2,height/2);
          fillLine = 80;
          //textTimer += 1;
          textTimer = 100;
        }
  // Set up a timer for displaying the text
  if(textTimer > 0){
    textTimer -= 1;
    text("GRAB A BEER!", width/2-100,height/2);
  };
  if(textTimer >=120){
    textTimer = 0;
  }
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    float std = theOscMessage.get(0).floatValue();
    
    std = max(std-0.25,0);
    std = 1.4*min(std,1);
    fillLine += 0.2*std;
    
    R = int((float(255) - float(255)*min(1,std))/2 +pR/2);
    G = int((float(255)*min(1,std))/2 +pG /2);
    
    pR = float(R);
    pG = float(G);
    
    
    focus = color(R,G,50);
    
    /*
    
    if(theOscMessage.checkTypetag("f")) {
      float std = theOscMessage.get(0).floatValue();
      count += 1;
      std_avg += std; // sum up standard deviations
      if (count >= 5){ // average the past 5 deviations
        std_avg = std_avg/5;
        if (std_avg > 0.5){ // consider user focused if average > 0.5
          fillLine += std_avg*10;
          focus = color(109,163,91);  // green background if focused
          showMessage((int)std);
        }else{
          focus = color(100,5,20);  // red background if unfocused
        }
        std_avg = 0;
      }
    }
    */
    
  }
}

void showMessage(int i) {
    println(i);
}
