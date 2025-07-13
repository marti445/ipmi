int pantalla = 0;
int contadorFrames = 0;
int duracionPantalla = 300;
float alpha = 0;
float posXImg = -400;
float textoY = 600;

PImage img0, img1, img2, img3;

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
    tint(255, alpha);
    image(img0, posXImg, 0, width, height);
    tint(255);
    fill(255, alpha);
    text("Bienvenido a R.E.P.O", width / 2, textoY - 20);
    textSize(20);
    text("Explora zonas oscuras en busca de recursos valiosos.", width / 2, textoY + 20);
    textSize(24);
  }

  else if (pantalla == 1) {
    tint(255, alpha);
    image(img1, posXImg, 0, width, height);
    tint(255);
    fill(255, alpha);
    text("Objetivo", width / 2, textoY - 20);
    textSize(20);
    text("Recolecta artefactos, reliquias y tesoros antes de que sea tarde.", width / 2, textoY + 20);
    textSize(24);
  }

  else if (pantalla == 2) {
    tint(255, alpha);
    image(img2, posXImg, 0, width, height);
    tint(255);
    fill(255, alpha);
    text("¡Peligro!", width / 2, textoY - 20);
    textSize(20);
    text("Criaturas misteriosas acechan entre las sombras.", width / 2, textoY + 20);
    textSize(24);
  }

  else if (pantalla == 3) {
    tint(255, alpha);
    image(img3, posXImg, 0, width, height);
    tint(255);
    fill(255, alpha);
    text("Has perdido a un compañero", width / 2, textoY - 20);
    textSize(20);
    text("¿Te animás a volver a intentarlo?", width / 2, textoY + 20);
    textSize(24);

    fill(50, 150, 255);
    rect(botonX, botonY, botonAncho, botonAlto, 10);
    fill(255);
    textSize(20);
    text("Reiniciar", botonX + botonAncho / 2, botonY + botonAlto / 2);
    textSize(24);
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
