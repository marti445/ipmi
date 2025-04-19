PImage img;
void setup (){
size (800, 400);
img = loadImage("imagen1.jpg");

}

void draw (){
background (255);

image (img, 0, 0, 400, 400);
println (mouseX + " / " + mouseY);

// fondo
noStroke();
fill(240);  
rect(400, 0, 400, 300); 
fill(37, 49, 42); // verde oscuro del fondo
rect(400, 300, 400, 100); // base verde
  
// Base de la lámpara 
fill(0); 
ellipse(600, 325, 140, 70); // base superior
ellipse(600, 335, 140, 70); // base intermedia
ellipse(600, 345, 140, 70); // base inferior
  
// Interruptor
fill(30);
rect(565, 325, 15, 10); 
  
// Cuello 
stroke(0);
strokeWeight(15);
noFill();
bezier(630, 325, 625, 180, 610, 190, 595, 155); // cuello curvo
  
// Cabezal 
noStroke();
fill(0); 
ellipse(555, 130, 100, 85); // parte externa 
fill(180); 
ellipse(545, 130, 65, 65); // interior gris
fill (245); 
ellipse (545, 130, 45, 45); // foco
  
// cable
stroke(0);
strokeWeight(4);
noFill();
bezier(641, 296, 660, 285, 685, 285, 736, 298); // cable curvo
}
