int wCampo;
int hCampo;

float xPallina;
float yPallina;
int dPallina;
float dirXPallina;
float dirYPallina;

int cornice;

float xRac1;
float yRac1;

float xRac2;
float yRac2;

float dirYRac1;
float dirYRac2;

int wRac;
int hRac;

int punteggioG1;
int punteggioG2;

void setup(){
  wCampo = 600;
  hCampo = 400;
  cornice=10;
  
  punteggioG1=0;
  punteggioG2=0;
  
  wRac=cornice;
  hRac=100;
  
  xRac1=0;
  yRac1=hCampo/2;
  
  xRac2=wCampo - wRac;
  yRac2=hCampo/2;
  
  size(wCampo,hCampo);
  xPallina = wCampo / 2;
  yPallina = hCampo / 2;
  dPallina = 10;
  dirXPallina=random(-3,3);
  dirYPallina=random(-3,3);
}



void draw(){
  background(200,200,200);
  //pallina che si muove
  fill(150,150,150);
 
  rect(cornice,cornice,wCampo-2*cornice,hCampo-2*cornice);
  fill(255,0,0);
  noStroke();
  ellipse(xPallina,yPallina,dPallina, dPallina);
  xPallina=xPallina + dirXPallina;
  yPallina=yPallina + dirYPallina;
  
  
  //la pallina che rimbalza
  if( xPallina > wCampo - dPallina / 2 - cornice){
    dirXPallina = - dirXPallina; 
  }
  
  if( xPallina < dPallina / 2 + cornice){
    dirXPallina = - dirXPallina;
  }
  
    if( yPallina > hCampo - dPallina / 2 - cornice){
    dirYPallina = - dirYPallina; 
  }
  
  if( yPallina < dPallina / 2 + cornice){
    dirYPallina = - dirYPallina;
  }
  
 // yRac2 = yPallina;
  //le racchette mosse dai giocatori
  if(yRac2 < yPallina){
   yRac2 = yRac2 + 1;  
  }
  
  if(yRac2 > yPallina){
   yRac2 = yRac2 - 1;  
  }
  
  
  if(yRac2 < cornice + hRac/2){
   yRac2= cornice + hRac/2;
  }
  if(yRac2 > hCampo - cornice - hRac/2){
   yRac2= hCampo - cornice - hRac/2;
  }
  
  yRac1=mouseY;
  
  if(yRac1 < cornice + hRac/2){
   yRac1= cornice + hRac/2;
  }
  if(yRac1 > hCampo - cornice - hRac/2){
   yRac1= hCampo - cornice - hRac/2;
  }
  
  
  rect(xRac1,yRac1-hRac/2,wRac,hRac);
  rect(xRac2,yRac2-hRac/2,wRac,hRac);
  
  
  
  //segno i punti
  if( xPallina > wCampo - dPallina / 2 - cornice){
    if( yPallina < yRac2-hRac/2 || yPallina > yRac2 + hRac/2  ){
      punteggioG1 = punteggioG1 + 1;
      println(punteggioG1 + " - " + punteggioG2);
    }
  }
  
  if( xPallina < dPallina / 2 + cornice){
    if( yPallina < yRac1 - hRac/2 || yPallina > yRac1 + hRac/2){
       punteggioG2 = punteggioG2 + 1; 
       println(punteggioG1 + " - " + punteggioG2);
    }

  }
  
  
  
  
  
  
  
  
  
}




