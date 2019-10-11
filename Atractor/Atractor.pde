/*
  ATRACTORES
 
 Arreglos 
 Interacción con mouse / teclado
 ** funciones
 */

int sep = 25;

void setup() {
  size(displayWidth, displayHeight);
  background(0);
}

void draw() {
  background(0);
  stroke(255);

  for (int j=0; j<=height; j+= sep) {
    for (int i=0; i<=width; i+= sep) { // i=i+30
      float d = dist(i, j, mouseX, mouseY);

      if (d<250) {
        float valMap = map(d, 0, 250, 15, 5);
        // map(valorAmapear, vMin, vMax, vMinSalida, vMaxSalida);
        strokeWeight(valMap);
      } else {
        strokeWeight(5);
      }

      if (i < width/2) {
        strokeCap(PROJECT);
      } else {
        strokeCap(ROUND);
      }

      point(i, j);
    }
  }
}
