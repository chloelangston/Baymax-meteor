char letter;
String words = "";
String hi = "";
String askName = "What's your name?";
String name = "";
String options = "";
int btn1X, btn1Y;      // Position of 1st button
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
boolean btn1Over = false;
boolean btn2 = false;
boolean btn3 = false;
boolean optionKeys = false;
boolean bodyPoints = false;
int pointSize = 20;
color shapeColor = color(255, 255, 255);
float eyeScale = 0.5;
float easing = 0.05;
int sec2;
color hColor1 = color(200, 255, 200);
color hColor2 = color(180, 255, 180);
color hColor3 = color(160, 255, 160);
color hColor4 = color(140, 255, 140);
color hColor5 = color(120, 255, 120);

class Big6 {
  Body b = new Body();
  Arm a = new Arm();
  Legs l = new Legs();
  Head h = new Head();
  
  void drawMe(){
    h.drawHead();
    h.drawFace();
    b.drawBody();
    b.drawBodyBottom();
    l.drawLeg();
    l.drawLeg2();
    a.drawArm();
    a.drawArm2();
    a.drawHands();
    a.drawHands2();
    a.drawFingers();
    a.drawHands2();
    a.drawFingers2();
  }
}

class Spot {
  void drawSpot(){
    
    noStroke();
    //fill(0, 102, 0);
    
    //ellipse(200, 100, 30, 30);
    ellipse(mouseX, mouseY, 30, 30);
    
  }
}

class Body {
  void drawBody(){
   pushMatrix();
   translate(0, 40);
   noStroke();
   if((bodyPoints == true) && ((sec2-2) % 6 == 0)){
     fill(hColor2);
   }
   else {
     fill(shapeColor);
   }
   scale(0.8, 1.0, 0.8);
   //ellipse(100,100, 150,200);
   sphere(110);
   popMatrix();
  }
  void drawBodyBottom(){
   pushMatrix();
   translate(0, 130, 10);
   noStroke();
   if((bodyPoints == true) && ((sec2-4) % 6 == 0)){
     fill(hColor4);
   }
   else {
     fill(shapeColor);
   }
   scale(1.3, 1.5, 1.4);
   sphere(100);
   popMatrix();
  }
}

class Head {
  void drawHead(){
    pushMatrix();
   translate(0, -70);
   scale(0.9, 0.6, 0.7);
   noStroke();
   
   if((bodyPoints == true) && ((sec2-1) % 6 == 0)){
     fill(hColor1);
   }
   else {
     fill(shapeColor);
   }
   sphere(50);
   popMatrix();
  }
  
  void drawFace(){
    pushMatrix();
    translate(-18, -81, 32);
    scale(0.5, eyeScale, 0.2);
    noStroke();
    fill(0);
    sphere(12);
    popMatrix();
    
    pushMatrix();
    translate(20, -81, 32);
    scale(0.5, eyeScale, 0.2);
    noStroke();
    fill(0);
    sphere(12);
    popMatrix();
    
    pushMatrix();
    stroke(0);
    translate(0, 0, 32);
    line(-18, -81, 20, -81);
    popMatrix();
    
    int sec = second();
    if (sec % 10 == 0) {
      eyeScale = 0.1;
    }
    else {
      eyeScale = 0.5;
    }
  }
}

class Arm {
 void drawArm(){
   //rotate(PI/-3.0);
   pushMatrix();
   translate(-110, 80);
   rotateZ(radians(25));
   noStroke();

   if((bodyPoints == true) && ((sec2-3) % 6 == 0)){
     fill(hColor3);
   }
   else {
     fill(shapeColor);
   }
   scale(0.5, 1.5, 0.5);
   sphere(90);
   popMatrix();
   
   pushMatrix();
   translate(-120, 100);
   rotateZ(radians(25));
   noStroke();
   scale(0.7, 1.4, 0.7);
   sphere(80);
   popMatrix();
 }
 
 void drawHands(){
   pushMatrix();
   translate(-150, 190, 3);
   rotateZ(radians(-30));
   if((bodyPoints == true) && ((sec2-3) % 6 == 0)){
     fill(hColor3);
   }
   else {
     fill(shapeColor);
   }
   scale(1.0, 1.2, 1.0);
   sphere(30);
   popMatrix();
 }
 
 void drawFingers(){
   pushMatrix();
   translate(-150, 220, 10);
   rotateZ(radians(-35));
   scale(0.5, 1.3, 0.6);
   if((bodyPoints == true) && ((sec2-3) % 6 == 0)){
     fill(hColor3);
   }
   else {
     fill(shapeColor);
   }
   sphere(20);
   popMatrix();
   
   pushMatrix();
   translate(-130, 210, 8);
   rotateZ(radians(-20));
   scale(0.5, 1.3, 0.5);
   sphere(18);
   popMatrix();
 }
 
  void drawArm2(){
   pushMatrix();
   translate(110, 80);
   rotateZ(radians(-25));

   if((bodyPoints == true) && ((sec2-3) % 6 == 0)){
     fill(hColor3);
   }
   else {
     fill(shapeColor);
   }
   scale(0.5, 1.5, 0.5);
   sphere(90);
   popMatrix();
   
   pushMatrix();
   translate(120, 100);
   rotateZ(radians(-25));
   noStroke();
   scale(0.7, 1.4, 0.7);
   sphere(80);
   popMatrix();
 }
 
  void drawHands2(){
   pushMatrix();
   translate(150, 190, 3);
   rotateZ(radians(30));
   scale(1.0, 1.2, 1.0);
   if((bodyPoints == true) && ((sec2-3) % 6 == 0)){
     fill(hColor3);
   }
   else {
     fill(shapeColor);
   }
   sphere(30);
   popMatrix();
 }
 
 void drawFingers2(){
   pushMatrix();
   translate(150, 220, 10);
   rotateZ(radians(35));
   scale(0.5, 1.3, 0.6);
   if((bodyPoints == true) && ((sec2-3) % 6 == 0)){
     fill(hColor3);
   }
   else {
     fill(shapeColor);
   }
   sphere(20);
   popMatrix();
   
   pushMatrix();
   translate(130, 210, 8);
   rotateZ(radians(20));
   scale(0.5, 1.3, 0.5);
   sphere(18);
   popMatrix();
 }
}


class Legs {
 void drawLeg(){
   pushMatrix();
  //ellipse(70, 200, 40, 50); 
  noStroke();

   if((bodyPoints == true) && ((sec2-5) % 6 == 0)){
     fill(hColor5);
   }
   else {
     fill(shapeColor);
   }
  translate(-50, 290);
  scale(1.0, 1.8, 1.0);
  sphere(50);
  popMatrix();
 }
 void drawLeg2(){
   pushMatrix();
  //ellipse(130, 200, 40, 50);

   if((bodyPoints == true) && ((sec2-5) % 6 == 0)){
     fill(hColor5);
   }
   else {
     fill(shapeColor);
   }
  translate(45, 290);
  scale(1.0, 1.8, 1.0);
  sphere(50);
  popMatrix();
 }
}

float sceneCenterX = 500;
float sceneCenterY = 400;

void mouseDragged(){
  //rotateY(mouseX/100);
  //b.drawMe();
}

void keyPressed() {
  // The variable "key" always contains the value 
  // of the most recent key pressed.
  
  if (optionKeys == false) {
    if ((key >= 'A' && key <= 'z') || key == ' ') {
      letter = key;
      words = words + key;
      // Write the letter to the console
      // println(key);
    }
    else if (key == 13){
      optionKeys = true;
      name = words;
      hi = "Hi " + name + ", how are you feeling today?";
      words = "";
      askName = "";
      options = "(w) well\n(n) not well\n(v) very bad";
      
    }
  }
  
  else if (optionKeys == true){
    if (key == 'w'){
        options = "That's great";
      }
      
      else if (key == 'n') {
        options = "Where do you not feel well?";
        bodyPoints = true;
      }
      
      else if (key == 'v') {
        options = "Oh no!  Where do you not feel well?";
        bodyPoints = true;
      }
  }
}

class Button {
  void drawButton(){
    update(mouseX, mouseY);
    if (btn1Over){
      fill(0);
    } else {
      fill(255);
    }
    stroke(255);
    rect(btn1X, btn1Y, rectSize, rectSize);
    
  }
}


int pointTransX = 200;
int pointTransY = 200;
color pointColor;
boolean pointOver = false;

class BodyPoints {
  
  void drawBodyPoints(){
    float glow_amount = round(map(sin(millis()/150), -1,1, 128,255));
    
    fill(glow_amount,255,0);
    pushMatrix();
    translate(500, 270, 20);
    sphere(pointSize);
    popMatrix();
    
    pushMatrix();
    translate(500, 320, 60);
    sphere(pointSize);
    popMatrix();
    
    pushMatrix();
    translate(500, 470, 140);
    sphere(pointSize);
    popMatrix();
    
    pushMatrix();
    translate(360, 450, 60);
    sphere(pointSize);
    popMatrix();
    
    pushMatrix();
    translate(640, 450, 60);
    sphere(pointSize);
    popMatrix();
    
    pushMatrix();
    translate(450, 640, 60);
    sphere(pointSize);
    popMatrix();
    
    pushMatrix();
    translate(545, 640, 60);
    sphere(pointSize);
    popMatrix();
    //filter(BLUR, 2);
    
  }
}


float fov = 2.0*PI/5.0;
//float fov = mouseX/float(width) * PI/2;
float cameraZ = (height/2.0) / tan(fov/2.0);


//void mouseClicked(){
//  if (bodyPoints){
//    perspective(fov/2, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
//    sceneCenterX = width - mouseX;
//    sceneCenterY = height - mouseY;
//  }
//}


Big6 b = new Big6();
Spot s = new Spot();
Button btn = new Button();
BodyPoints bp = new BodyPoints();

int lastTimeCheck;
int timeIntervalFlag = 5;

void setup(){
  size(1000,800, P3D);
  btn1X = 680;
  btn1Y = 270;
  lastTimeCheck = second();
}

float eyeX = width-mouseX;
float eyeY = height-mouseY;

void draw(){
  sec2 = second();
  if (mousePressed) {
    camera(eyeX, eyeY, (height/2) / tan(PI/6), sceneCenterX, sceneCenterY, 0, 0, 1, 0);
  }
  pushMatrix();
  background(100);
  lights();
  translate(500, 350);
  b.drawMe();
  //filter(BLUR,1);
  //s.drawSpot();
  popMatrix();
  
  textSize(36);
  fill(255);
  text(askName, 50, 120, 540, 300);
  textSize(26);
  text(words, 50, 160, 540, 300);
  text(hi, 500, 200, 540, 300);
  textSize(16);
  text(options, 680, 270, 200, 200);
  if (bodyPoints) {
    bp.drawBodyPoints();
    eyeX = width/2;
    eyeY = height/2;
  }
  else {
    eyeX = width-mouseX;
    eyeY = height-mouseY;
  }
  //update(mouseX, mouseY);
  //  if (pointOver){
  //   fill(0,0,0);
  //  }
  //  else {
  //    fill(255,0,0);
  //  }
    
  //  rect(pointTransX, pointTransY, pointSize, pointSize);
}


void update(int x, int y){
  if (overPoint(pointTransX, pointTransY, pointSize, pointSize)){
    pointOver = true;
  }
}

void mousePressed() {
  if(btn1Over) {
    options = "well";
  }
  
}

boolean overPoint(int x, int y, int width, int height) {
  if(mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
}