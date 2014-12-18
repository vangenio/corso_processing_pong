/*
tipi di variabili: int, float, 



*/

//dichiarazioni delle variabili

float xPallina;
float yPallina;
float dirXPallina;
float dirYPallina;
int diaPallina;  //diametro pallina
int bordoCampo;

float xRac1;
float yRac1;
float dirYRac1;

float xRac2;
float yRac2;
float dirYRac2;

int wRac;
int hRac;

int puntiG1;
int puntiG2;
void setup(){
  size(800,600);
  //inizializzazione variabili
  xPallina=width/2;
  yPallina=height/2;
  dirXPallina=2;   //random
  dirYPallina=2;   //random
  diaPallina=10;
  bordoCampo=20;
  
   wRac=bordoCampo;
   hRac=100;
   
   
   xRac1 = 0;
   yRac1 = height/2;
   dirYRac1=1;
  
   xRac2 = width-wRac;
   yRac2 = height/2;
   dirYRac2=1;
  

  puntiG1=0;
  puntiG2=0;
  noCursor();
  
}


void draw(){
 background(255,255,230);
 fill(255,255,100);
 noStroke();
 rect(bordoCampo,bordoCampo,width-bordoCampo*2, height-bordoCampo*2);
 
 fill(200,0,0);
 
  //la pallina che si muove
  xPallina = xPallina + dirXPallina;
  yPallina = yPallina + dirYPallina;
  ellipse(xPallina,yPallina,10,10);



  //la pallina che rimbalza
  if( xPallina > width -bordoCampo ) dirXPallina = -dirXPallina;
  if( xPallina < bordoCampo ) dirXPallina = -dirXPallina;
  if( yPallina > height -bordoCampo ) dirYPallina = -dirYPallina;
  if( yPallina < bordoCampo ) dirYPallina = -dirYPallina;
 
  //le racchette che si muovono comandate dagli utenti
  yRac1=mouseY;
  if(yRac2>yPallina) dirYRac2=-1;
  if(yRac2<yPallina) dirYRac2=1;
  
  yRac2 = yRac2 + dirYRac2;
  
  rect(xRac1,yRac1-hRac/2,wRac,hRac);
  rect(xRac2,yRac2-hRac/2,wRac,hRac);

  //la pallina che segna punto 
  
  
  
  //parete giocatore 1
  if( xPallina < bordoCampo ){
   
    if(yPallina<yRac1-hRac/2 || yPallina > yRac1+hRac/2){
    
      //segna il punto
      puntiG2 = puntiG2+1;
      println("giocatore 2 GOAAAAL! " + puntiG2);
      
      
    }  
    
  }
  
  
  //parete giocatore 2
  if( xPallina > width -bordoCampo ) {
    
    if(yPallina<yRac2-hRac/2 || yPallina > yRac2+hRac/2){
    
      //segna il punto
      puntiG1 = puntiG1+1;
      println("giocatore 1 GOAAAAL! " + puntiG1);
      
      
    }  
  }
  
  
  
 
 
  
}
