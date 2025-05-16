// Variables 
int pantalla = 0;
int contadorFrames = 0;
int duracionPantalla = 300;
float alpha = 0;
float posXImg = -400;
float textoY = 600;

// Imágenes
PImage img0, img1, img2, img3;

// Botón
int botonX = 300;
int botonY = 450;
int botonAncho = 200;
int botonAlto = 60;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(24);
  frameRate(60);

  img0 = loadImage("presentacion.jpg");  
  img1 = loadImage("recoleccion1.jpg");
  img2 = loadImage("monstruo.jpg");       
  img3 = loadImage("perder.jpg");         
}

void draw() {
  background(0);

  if (posXImg < 0) posXImg += 4;
  if (alpha < 255) alpha += 3;
  if (textoY > 320) textoY -= 2;

  if (pantalla == 0) {
    mostrarPantallaAnimada(img0, "Bienvenido a R.E.P.O", "Explora zonas oscuras en busca de recursos valiosos.");
  } else if (pantalla == 1) {
    mostrarPantallaAnimada(img1, "Objetivo", "Recolecta artefactos, reliquias y tesoros antes de que sea tarde.");
  } else if (pantalla == 2) {
    mostrarPantallaAnimada(img2, "¡Peligro!", "Criaturas misteriosas acechan entre las sombras.");
  } else if (pantalla == 3) {
    mostrarPantallaFinal(img3, "Has perdido a un compañero", "¿Te animás a volver a intentarlo?");
  }

  if (pantalla < 3) {
    contadorFrames++;
    if (contadorFrames >= duracionPantalla) {
      pantalla++;
      contadorFrames = 0;
      alpha = 0;
      posXImg = -400;
      textoY = 600;
    }
  }
}

void mostrarPantallaAnimada(PImage img, String titulo, String descripcion) {
  tint(255, alpha);
  image(img, posXImg, 0, width, height);
  tint(255);  // Reset básico de tinte

  fill(255, alpha);
  text(titulo, width / 2, textoY - 20);
  textSize(20);
  text(descripcion, width / 2, textoY + 20);
  textSize(24);
}

void mostrarPantallaFinal(PImage img, String titulo, String descripcion) {
  tint(255, alpha);
  image(img, posXImg, 0, width, height);
  tint(255);

  fill(255, alpha);
  text(titulo, width / 2, textoY - 20);
  textSize(20);
  text(descripcion, width / 2, textoY + 20);
  textSize(24);

  // Botón de reinicio
  fill(50, 150, 255);
  rect(botonX, botonY, botonAncho, botonAlto, 10);
  fill(255);
  textSize(20);
  text("Reiniciar", botonX + botonAncho / 2, botonY + botonAlto / 2);
  textSize(24);
}

void mousePressed() {
  if (pantalla == 3) {
    if (mouseX > botonX && mouseX < botonX + botonAncho &&
      mouseY > botonY && mouseY < botonY + botonAlto) {
      pantalla = 0;
      contadorFrames = 0;
      alpha = 0;
      posXImg = -400;
      textoY = 600;
    }
  }
}
