/*

Step by step pong game code.


2014/11/25
Eugenio Vannoni

Made for educational purpose. 
Jumpstar processing Starter 3d 2014, 
Workshop a cura di Officine Arduino


This example is in the public domain.

*/


PFont myFont;

int wCampo=400;  //larghezza campo
int hCampo=400;  //altezza campo

float xPallina=wCampo/2;  //coordinata x pallina
float yPallina=hCampo/2;  //coordinata y pallina
int dPallina=10; //diametro pallina
float dirXPallina=random(-2,2);//round(random(0,1)*2-1)*random(0.8,1.2); //direizone x pallina
float dirYPallina=random(-2,2);//round(random(0,1)*2-1)*random(0.8,1.2); //direzione y pallina

int hRac=40;
int wRac=10;
int xRac1=0;
int xRac2=wCampo-wRac;
int yRac1=hCampo/2-hRac/2;
int yRac2=hCampo/2-hRac/2;
int dRac1=0;
int dRac2=0;

int pGioc1=0; // punteggio giocatore 1
int pGioc2=0; // punteggio giocatore 2

void setup(){
    myFont = createFont("UbuntuMono-Regular-48", 48);
  textFont(myFont);
  textAlign(CENTER, CENTER);
  
  
  size(wCampo,hCampo); 
}

void draw(){
  background(200,200,200);  // stende un velo di colore su tutto lo schermo

text(pGioc1+" "+pGioc2,wCampo/2,20);

//se la pallina tocca i bordi laterali dove non ci sono le racchette si segna il punto all'avversario

if(xPallina <dPallina/2 && yPallina < yRac1 ) pGioc1=pGioc1+1;
if(xPallina <dPallina/2 && yPallina > yRac1+hRac ) pGioc1=pGioc1+1;

if(xPallina >wCampo-dPallina/2 && yPallina < yRac2 ) pGioc2=pGioc2+1;
if(xPallina >wCampo-dPallina/2 && yPallina > yRac2+hRac ) pGioc2=pGioc2+1;  
  
  
//pallina che si muve
  xPallina=xPallina + dirXPallina;
  yPallina=yPallina + dirYPallina;
  ellipse(xPallina, yPallina, dPallina, dPallina);
 


//pallina che rimbalza sui bordi del campo
  if(xPallina > width-dPallina / 2 ) dirXPallina=-dirXPallina; // rimbalzo a destra
  if(xPallina < 0 +dPallina / 2) dirXPallina=-dirXPallina; // rimbalzo a sinistra
  if(yPallina > height - dPallina / 2 ) dirYPallina=-dirYPallina; //rimbalzo sotto
  if(yPallina < 0 + dPallina / 2) dirYPallina=-dirYPallina;// rimbalzo sopra

//due racchette che si muovono comandate dai giocatori
yRac1=yRac1+dRac1;
yRac2=yRac2+dRac2;

if(yRac1+hRac>hCampo)yRac1=hCampo-hRac;
if(yRac2+hRac>hCampo)yRac2=hCampo-hRac;

if(yRac1<0)yRac1=0;
if(yRac2<0)yRac2=0;

rect(xRac1,yRac1,wRac,hRac);
rect(xRac2,yRac2,wRac,hRac);


  
}


void keyPressed(){
  if(key == 'a') dRac1=1;
  if(key == 'q') dRac1=-1;
  if(key == '6') dRac2=1;
  if(key == '9') dRac2=-1;  
  
} 
void keyReleased(){
  if(key == 'a') dRac1=0;
  if(key == 'q') dRac1=0;
  if(key == '6') dRac2=0;
  if(key == '9') dRac2=0;  
  
} 



