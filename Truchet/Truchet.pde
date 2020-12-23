import processing.pdf.*;

boolean grabar = true; // true, false
int tam = 50;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  rectMode(CENTER);
  noLoop();
}
void draw() {
  if (grabar == true) {
    beginRecord(PDF, "modulo1.pdf");
  }

  background(255);
  translate(tam/2, tam/2);
  for (int j = 0; j<height; j = j + tam) {
    for (int i = 0; i<width; i = i + tam) {
      pushMatrix();    
      translate(i, j);
      rotate(radians( int(random(4))*90 ));
      modulo3();
      popMatrix();
    }
  }
  if (grabar) {
    endRecord();
    saveFrame("truchet.png");
    grabar = false;
  }
}

void modulo1() {// funcion. Serie de instrucciones.
  strokeWeight(5);
  stroke(0);
  line(-tam/2, tam/2, tam/2, -tam/2);
}
void modulo2() {// funcion. Serie de instrucciones.
  noStroke();
  fill(0);
  triangle(-tam/2, tam/2, tam/2, tam/2, tam/2, -tam/2);
}
void modulo3() {// funcion. Serie de instrucciones.
  stroke(int(random(3)) * 50 );
  strokeWeight(10 + int(random(3)) * 5);
  noFill();
  arc(-tam/2, tam/2, tam, tam, radians(270), radians(360));
  arc(tam/2, -tam/2, tam, tam, radians(90), radians(180));
}
