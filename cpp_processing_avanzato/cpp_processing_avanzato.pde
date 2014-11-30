/*

Pong game. Two player, Simple AI for "Player vs Computer" or "computer vs computer" mode.
Player can use a DIY arduino controlled pad, an explora, or the keyboard ("q" and "a" for player 1, "9" and "6" for the player 2)
Press "p" to stroke again from the middle

TODO
 - more intelligent AI

2014/11/25
Eugenio Vannoni

Made for educational purpose. 
Jumpstar processing Starter 3d 2014, 
Workshop a cura di Officine Arduino


This example is in the public domain.

*/



//variabili campo
  int w; //larghezza schermo
  int h; //altezza schermo
  int maxX,minX,maxY,minY;


//variabili pallina
  int xP; //x della palla
  int yP; //y della palla
  int dP; //diametro palla
  float dirxP; //direzione x della palla
  float diryP; //direzione y della palla
  float vPinit=0.4;
  float vP=vPinit; // velocità della pallina
  float dirP; //direzione della pallina in radianti


//variabili racchette
  int rac1;  //stato della racchetta 1
  int rac2;  //stato della racchetta 2
  int vRac;  //velocità della racchetta
  int hRac;   //altezza delle racchette
  int wRac;   //larghezza delle racchette
  int yRac1; // posizione verticale della racchetta 1
  int yRac2; //posizione verticale della racchetta 2
  int xRac1; // posizione orizzontale della racchetta 1
  int xRac2; //posizione orizzontale della racchetta 2


//variabili giocatori
  int puntiGiocatore1;
  int puntiGiocatore2;
  boolean segnato;
  boolean autoplay1=true;
  boolean autoplay2=true;
//impostazioni seriale per comunicare con arduino
  import processing.serial.*;
  int lf = 10;    // Linefeed in ASCII
  String myString = null;
  Serial myPort;  // The serial port
  boolean periferica = false;

PFont myFont;

void setup(){
  myFont = createFont("UbuntuMono-Regular-48", 48);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  
    size(displayWidth, displayHeight);
 //impostazioni seriale per comunicare con arduino
if(periferica){
 
 // List all the available serial ports
 // println(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  myString = myPort.readStringUntil(lf);
  myString = null;
 }
//impostazioni campo
  dP=10; //diametro della palla
  w=displayWidth;  //larghezza del campo misurato in numeri di diametri di palla
  h=displayHeight; // altezza del campo misurato in numeri di diametro di palla
  size(w,h);   //setto le dimensioni del campo
  minX=4*dP;  //setto il limite minore orizzontale del gioco
  maxX=w-4*dP; //setto il limite maggiore orizzontale del gioco
  minY=2*dP; //setto il limite minore verticale del gioco
  maxY=h-2*dP; //setto il limite maggiore verticale del gioco
  
  
//impostazioni pallina
 lancioPallina();


//impostazioni racchette
  hRac=10*dP;   // set altezza racchette
  wRac=dP;     // larghezza racchetta
  yRac1=height/2 - hRac/2; // set posizione verticale della racchetta 1
  yRac2=height/2 - hRac/2; // set posizione verticale della racchetta 2
  xRac1=minX-dP+1; //set posizione orizzontale racchetta 1
  xRac2=maxX; //set posizione orizzontale racchetta 1 
  rac1=0;
  rac2=0;
  vRac=3;


//impostazioni giocatori
  puntiGiocatore1=0;
  puntiGiocatore2=0;
  segnato=true;

 
} //fine setup

void draw(){
//lettura seriale per comunicare con arduino
if(periferica){
while (myPort.available() > 0) {
   byte[] inBuffer = new byte[8];
   
    myPort.readBytesUntil(lf, inBuffer);
    if (inBuffer != null) {
      
      String str = new String(inBuffer);
      if(int(str.substring(0,2))== 1)if(!autoplay1)  yRac1=round(map(int(str.substring(2,6)),0,1000,minY,maxY));
      if(int(str.substring(0,2))== 2)if(!autoplay2)  yRac2=round(map(int(str.substring(2,6)),0,1000,minY,maxY));
      
    }
  }
}
  
    if(autoplay2){
	if(yP>yRac2+hRac/2)yRac2+=5;
	if(yP<yRac2+hRac/2)yRac2-=5; 
    }
    
    if(autoplay1){
	if(yP>yRac1+hRac/2)yRac1+=5;
	if(yP<yRac1+hRac/2)yRac1-=5; 
    }
//controllo che le racchette non superino i bordi
  if(yRac1 < minY) yRac1=minY;
  if(yRac2 < minY) yRac2=minY;
  if(yRac1 > maxY-hRac) yRac1= maxY-hRac;
  if(yRac2 > maxY-hRac) yRac2= maxY-hRac;

  
  
//disegno campo da gioco
  background(100);   // stendo un velo di colore sul campo
  stroke(0,0,0); // setto il colore della linea di bordo
  strokeWeight(dP);
  fill(100); // setto il colore del riempimento
  rect(minX-dP/2,minY-dP/2,maxX-minX+dP,maxY-minY+dP); //disegno il rettangolo di gioco
  //noFill(); //tolgo il riempimento
  line(minX+(maxX-minX)/2,minY,minX+(maxX-minX)/2,maxY); //disegno la metà campo
  ellipse(minX+(maxX-minX)/2,minY+(maxY-minY)/2,5*dP,5*dP); //disegno l'area di lancio iniziale
//imposto colorazione palette e pallina 
  noStroke(); // dichiaro di non disegnare i contorni delle figure
  fill(255); //setto il colore bianco del riempimento


  
//controllo rimbalzi e punteggio
  if(xP+dirxP*dP>maxX){ // se la pallina tocca il lato destro giocatore 2
    if(yP<yRac2 || yP>yRac2+hRac) {
      puntiGiocatore1+=1; // assegno il punto al giocatore 1
      segnato=true; // attivo il reset della pallina
    }
   // dirxP=-dirxP;    // condizione di rimbalzo orizzontale
   
        dirP=(dirP+(PI/2*3-dirP)*2)%(2*PI);
        float spizza=(((float(yP)-float(yRac2))/float(hRac))-0.5)*2*PI/8;
    dirP-=spizza;
    dirxP=cos(dirP)*vP;
    diryP=sin(dirP)*vP;
    
    
     
 }
  if( xP+dirxP*dP<minX){ // se la pallina tocca il lato destro giocatore 1
    //dirxP=-dirxP;    // condizione di rimbalzo orizzontale
    
    dirP=(dirP+(PI/2*3-dirP)*2)%(2*PI);
    float spizza=(((float(yP)-float(yRac1))/float(hRac))-0.5)*2*PI/8;
    dirP+=spizza;
    dirxP=cos(dirP)*vP;
    diryP=sin(dirP)*vP;
    
    if(yP<yRac1 || yP>yRac1+hRac) {
      puntiGiocatore2+=1; // assegno il punto al giocatore 1
      segnato=true; // attivo il reset della pallina
    }
    
  } // fine controllo rimbalzi e punteggio
  
  if(yP+diryP*dP>maxY || yP+diryP*dP<minY) {
  
   // diryP=-diryP;   // condizione di rimbalzo verticale
    
      dirP=(dirP+(PI-dirP)*2)%(2*PI);
    dirxP=cos(dirP)*vP;
    diryP=sin(dirP)*vP;
    
  }
  
  xP+=round(dirxP*dP);  //eseguo lo spostamento x
  yP+=round(diryP*dP);  //eseguo lo spostamento y
  
//se è stato segnato rimetto la palla al centro e visualizzo il punteggio
 vP+=0.0005; text( puntiGiocatore1 + "  "+puntiGiocatore2, width/2, dP*5);
  
 if(segnato){
   
   println("Giocatore1: " + puntiGiocatore1 + " | Giocatore2: "+puntiGiocatore2); // visualizzo il punteggio
  println("######");
  
  delay(1000); // attendo un secondo prima di ripartire
   
   xP=width/2; // set posizione orizzontale pallina
   yP=height/2; // set posizione verticale pallina
   lancioPallina();
   yRac1=height/2 - hRac/2; // set posizione verticale della racchetta 1
   yRac2=height/2 - hRac/2; // set posizione verticale della racchetta 2
   vP=vPinit;
   segnato=false; //completato reset
 } // fine if segnato
  
//sposto racchette
  yRac1+=rac1;
  yRac2+=rac2;

 
  ellipse(xP,yP,dP,dP); //disegno la palla
  
//disegno palette
  rect(xRac1,yRac1,wRac,hRac);
  rect(xRac2,yRac2,wRac,hRac);
  stroke(255,0,0);
//line(xP,yP,xP+dirxP*50,yP+diryP*50);


}  //fine draw


//controllo delle palette con i tasti
void keyPressed(){
 if( key == '9' ) rac2=-vRac; // paletta 2 su
 if( key == '6' ) rac2=+vRac; // paletta 2 giù
 if( key == 'q' || key == 'Q' ) rac1=-vRac; //paletta 1 su
 if( key == 'a' || key == 'A' ) rac1=+vRac; //paletta 1 giù
 if(key  == 'p'|| key == 'P') segnato=true;
 
}//fine keypressed
void keyReleased(){
 if( key == '9' ) rac2=0; // paletta 2 su
 if( key == '6' ) rac2=0; // paletta 2 giù
 if( key == 'q' || key == 'Q' ) rac1=0; //paletta 1 su
 if( key == 'a' || key == 'A' ) rac1=0; //paletta 1 giù  
}//fine keyreleased

void lancioPallina(){
//lancio pallina a velocità costante e direzionato verso le racchette  
   xP=width/2;  // posizione iniziale orizzontale della palla: al centro
  yP=height/2; //posizione verticalle iniziale della palla: al centro
  vP=vPinit;
  float range=PI/2;
  dirP=random(range*2);
  if(dirP>range)dirP+=PI-range/2*3;
  if (dirP<=range)dirP-=range/2;
 
//scompongo la velocità nei vettori
  dirxP=cos(dirP)*vP; 
  diryP=sin(dirP)*vP;
/*
// lancio palline base
  dirxP=random(2)-1;   //direzione iniziale della palla: random
  diryP=random(2)-1; // direzione iniziale della palla:random
*/
  
  
}//fine lancio  pallina

boolean sketchFullScreen() {
  return true;
}
