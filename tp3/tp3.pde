// https://youtu.be/Ey2o0xkmoA4
PImage refe;
int cantidadInicial = 8;
float intensidadInicial = 1.0;
boolean usarGris = true;  

void setup() {
  size(800, 400);
  refe = loadImage("refe.png");
  refe.resize(width/2, height);
}

void draw() {
  background(255);

  int cantidad = cantidadInicial;
  float intensidad = intensidadInicial;

  image(refe, 0, 0);

  dibujarGrilla(cantidad, width/2, 0, width/2, height, intensidad, usarGris);
}

void dibujarGrilla(int cantidad, float origenX, float origenY, float ancho, float alto, float intensidadMax, boolean escalaGrises) {
  float tamX = ancho / cantidad;
  float tamY = alto / cantidad;

  for (int i = 0; i < cantidad; i++) {
    for (int j = 0; j < cantidad; j++) {
      float x = origenX + i * tamX;
      float y = origenY + j * tamY;

      boolean invertir = (i + j) % 2 == 0;

      float intensidad = calcularIntensidad(x + tamX/2, y + tamY/2, intensidadMax);

      dibujarDegradado(x, y, tamX, tamY, invertir, intensidad, escalaGrises);
    }
  }
}

// funcion con retorno
float calcularIntensidad(float x, float y, float intensidadMax) {
  float d = dist(mouseX, mouseY, x, y);
  return map(d, 0, width, intensidadMax, 0);
}

// funcion sin retorno 
void dibujarDegradado(float x, float y, float w, float h, boolean invertir, float intensidad, boolean escalaGrises) {
  pushMatrix();
  translate(x + w/2, y + h/2);
  if (invertir) rotate(PI);

  for (int i = 0; i <= w; i++) {
    float inter = map(i, 0, w, 0, 1);

    if (escalaGrises) {
      float sombra = map(pow(inter, 1.5), 0, 1, 255 * (1 - intensidad), 30 * intensidad);
      stroke(sombra);
    } else {
      float r = map(inter, 0, 1, 255, 100);
      float b = map(inter, 0, 1, 255, 200);
      stroke(r, 0, b); 
    }

    line(i - w/2, -h/2, i - w/2, h/2);
  }

  popMatrix();
}
 
void keyPressed() {
  if (key == 'r' || key == 'R') {
    cantidadInicial = 8;
    intensidadInicial = 1.0;
    usarGris = true;
  }
  if (key == 'c' || key == 'C') {
    usarGris = !usarGris;  
  }
}
