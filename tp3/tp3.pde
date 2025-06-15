/*  OP‑ART – Checkerboard cilíndrico interactivo
    Resolución: 800×400
    Izquierda: F_1.jpg (referencia)   |   Derecha: patrón dinámico
*/

PImage refImg;

// Variables que el usuario puede modificar
int   tiles     = 8;      // número de celdas por fila y columna
float intensity = 1.0;    // fuerza del degradado
boolean animar  = true;   // on/off animación
boolean verRef  = true;   // mostrar / ocultar imagen

// Valores por defecto para reinicio
final int   TILES_DEF     = 8;
final float INTENSITY_DEF = 1.0;

void setup() {
  size(800, 400, P2D);
  refImg = loadImage("F_1.jpg");          // ← asegúrate que exista
  refImg.resize(width/2, height);         // 400×400 a la izquierda
}

void draw() {
  background(255);
  
  // 1️⃣  Imagen fija de referencia
  if (verRef) image(refImg, 0, 0);
  
  // 2️⃣  Patrón interactivo a la derecha
  drawChecker(width/2, 0, width/2, height);
}

/* ──────────────────────────────────────────────
   FUNCIÓN SIN RETORNO  ▸ Dibuja un tile gradiente
   ────────────────────────────────────────────── */
void drawGradientTile(float x, float y, float w, float h, boolean flip, float factor) {
  pushMatrix();
  translate(x, y);
  // Elegimos si invertimos el degradado
  if (flip) rotate(PI);
  
  // Dibujamos muchas líneas verticales para simular gradiente
  for (int i = 0; i <= int(w); i++) {
    float inter = map(i, 0, w, 0, 1);
    // Factor controla qué tan marcado es el gradiente
    float shade = map(pow(inter, 1.5), 0, 1, 255 * (1 - factor), 30 * factor);
    stroke(shade);
    line(i - w/2, -h/2, i - w/2, h/2);
  }
  popMatrix();
}

/* ──────────────────────────────────────────────
   FUNCIÓN CON RETORNO ▸ Calcula factor dinámico
   ────────────────────────────────────────────── */
float gradientFactor(float cx, float cy) {
  // Distancia del centro del tile al cursor (en coord. absolutas)
  float d = dist(cx, cy, mouseX, mouseY);
  // Mapear a rango [0 … intensity] (más cerca → más fuerte)
  return map(d, 0, width/2, intensity, 0);
}

/* ───────────────────
   Dibuja la grilla
   ─────────────────── */
void drawChecker(int ox, int oy, int w, int h) {
  pushMatrix();
  translate(ox, oy);
  
  float tileW = w / float(tiles);
  float tileH = h / float(tiles);
  
  for (int i = 0; i < tiles; i++) {
    for (int j = 0; j < tiles; j++) {
      // Centro de cada tile
      float cx = i * tileW + tileW / 2;
      float cy = j * tileH + tileH / 2;
      
      // ¿Degradado normal o invertido? (estilo tablero)
      boolean flip = (i + j) % 2 == 1;
      
      // Factor dinámico usando función que RETORNA
      float factor = gradientFactor(cx + ox, cy + oy);
      
      // Llamada a la función SIN retorno
      drawGradientTile(cx, cy, tileW, tileH, flip, factor);
    }
  }
  popMatrix();
}

/* ───────────────────────────────
   Eventos de teclado para el usuario
   ─────────────────────────────── */
void keyPressed() {
  if (key == 'r' || key == 'R') resetSketch();       // reiniciar
  
  else if (key == 'w' || key == 'W') tiles = min(20, tiles + 1);   // + densidad
  else if (key == 's' || key == 'S') tiles = max(4,  tiles - 1);   // - densidad
  
  else if (key == 'a' || key == 'A') intensity = min(2.0, intensity + 0.1); // + intensidad
  else if (key == 'd' || key == 'D') intensity = max(0.1, intensity - 0.1); // - intensidad
  
  else if (key == 'm' || key == 'M') animar = !animar;   // pausar animación
  else if (key == 'h' || key == 'H') verRef = !verRef;   // ocultar / mostrar ref
}

/* ───────────────────────────────
   Restaurar valores originales
   ─────────────────────────────── */
void resetSketch() {
  tiles     = TILES_DEF;
  intensity = INTENSITY_DEF;
  verRef    = true;
}
