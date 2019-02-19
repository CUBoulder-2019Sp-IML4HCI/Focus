import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent;
import netP5.*;
import oscP5.*;

//Global Variables
Robot robot;
OscP5 oscP5;
NetAddress dest;


void setup()
{
  oscP5 = new OscP5(this, 12003);
  dest = new NetAddress("127.0.0.1", 6448);
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    //if(theOscMessage.checkTypetag("f")) {
      float x = theOscMessage.get(0).floatValue();
      float y = theOscMessage.get(1).floatValue();
       clickMouse((int)x, (int)y);
       println(x);
       println(y);
    //}
  }
}

void clickMouse(int x, int y){
  //robot setup
   try
    {
      robot = new Robot();
    }
    catch (AWTException e)
    {
      println("Robot class not supported by your system!");
      exit();      
    }
  robot.mouseMove(x, y); //test line to move cursor
  robot.mousePress(InputEvent.BUTTON1_MASK); // Left=Button1, right=Button2
  robot.mouseRelease(InputEvent.BUTTON1_MASK);
}
